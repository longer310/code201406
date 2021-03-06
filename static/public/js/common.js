$(function(){
	var alert_tmpl = '\
		<div id="j-modalAlert" class="modal hide">\
			<div class="modal-header">\
				<button data-dismiss="modal" class="close" type="button">×</button>\
				<h3 class="j-title"></h3>\
			</div>\
			<div class="modal-body">\
				<p class="j-content"></p>\
			</div>\
			<div class="modal-footer">\
				<a data-dismiss="modal" class="btn btn-primary j-btn-confirm" href="#">确认</a>\
			</div>\
		</div>';

	var confirm_tmpl = '\
		<div id="j-modalConfirm" class="modal hide">\
			<div class="modal-header">\
				<button data-dismiss="modal" class="close" type="button">×</button>\
				<h3 class="j-title"></h3>\
			</div>\
			<div class="modal-body">\
				<p class="j-content"></p>\
			</div>\
			<div class="modal-footer">\
				<a data-dismiss="modal" class="btn btn-primary j-btn-confirm" href="#">确认</a>\
				<a data-dismiss="modal" class="btn j-btn-cancel" href="#">取消</a>\
			</div>\
		</div>';

	var tip_tip = '<div class="alert hide modal-tip" id="j-tip">\
						<a class="close j-btn-close" href="javascript:;">×</a>\
						<p class="j-content"></p>\
					</div>';

	$("body").append(alert_tmpl);
	$("body").append(confirm_tmpl);
	$("body").append(tip_tip);
});

var Common = {
	alert : function (options){
		options = options || {};


		$("#j-modalAlert .j-title").html(options.title);
		$("#j-modalAlert .j-content").html(options.content);
        $('#j-modalAlert').modal('show');

        $("#j-modalAlert .j-btn-confirm").unbind("click").bind("click", function(){
        	$('#j-modalAlert').modal('hide');
            (typeof options.confirm === "function") && options.confirm();
            return false;
        });

        $("#j-modalAlert").height("auto");
		var height = $("#j-modalAlert").height();
		$("#j-modalAlert").css({
			height : height,
			"margin-top" : -height / 2
		});
	},

	confirm : function(options){
		options = options || {};

		$("#j-modalConfirm .j-title").html(options.title);
		$("#j-modalConfirm .j-content").html(options.content);
        $('#j-modalConfirm').modal('show');

        $("#j-modalConfirm .j-btn-confirm").unbind("click").bind("click", function(){
        	$('#j-modalConfirm').modal('hide');
            (typeof options.confirm === "function") && options.confirm();
            return false;
        });

        $("#j-modalConfirm .j-btn-cancel").unbind("click").bind("click", function(){
        	$('#j-modalConfirm').modal('hide');
            (typeof options.cancel === "function") && options.cancel();
            return false;
        });

        $("#j-modalConfirm").height("auto");
		var height = $("#j-modalConfirm").height();
		$("#j-modalConfirm").css({
			height : height,
			"margin-top" : -height / 2
		});
	},

	tip : function(options){
		options = options || {};
		var type = options.type || "info";
		var delay = options.delay || 3000;

		$("#j-tip .j-content").html(options.content);

		$('#j-tip')[0].className = 'alert modal-tip alert-' + type;

		$("#j-tip").height("auto");

		$("#j-tip .j-btn-close").unbind("click").bind("click", function(){
        	$('#j-tip')[0].className = 'alert hide modal-tip';
            return false;
        });

		setTimeout(function(){
			$('#j-tip')[0].className = 'alert hide modal-tip';
		}, delay);
		
		var height = $("#j-tip").height();
		$("#j-tip").css({
			height : height,
			"margin-top" : -height / 2
		});
	}
}

var Route = {
    SEARCH : 1,
    HASH : 2,
    FILENAME : 4,
    ALL : 7,

    parse : function (url) {
        var _this = this;
        var a =  document.createElement('a');

        a.href = url;

        var route = {
            hostname : a.hostname,
            host : a.host,
            hash : a.hash.replace("#", ""),
            search : a.search.replace("?", ""),
            pathname : a.pathname,
            url : a.href,
            protocol : a.protocol,
            file : (a.pathname.split('/').reverse())[0],
            port : a.port,
            origin : a.origin
        };

        if (arguments.length == 2){
            route.param = _this.split(route, arguments[1]);
        }
        
        return route;
    },

    split : function (route, pattern){
        var _this = this;
        var pattern = pattern || _this.SEARCH,
            param = {}, 
            i, arg,
            args;

        if (pattern & _this.FILENAME){
            args = route.file.split(/[\-\.]/gi);

            //去掉第一个页面名称和最后一个文件后缀名称
            args.shift();
            args.pop();

            for (var i = 0; i < args.length / 2; i++){
                param[args[2 * i]] = args[2 * i + 1];
            }
        }

        if (pattern & _this.SEARCH){
            param = _this.splitKeyValue(route.search);
        }

        if (pattern & _this.HASH){
            param = _this.splitKeyValue(route.hash.replace("?", ''));
        } 

        return param;
    },

    splitKeyValue : function(search, gap, equal){
        var arg, args, param = {},
            gap = gap || '&',
            equal = equal || '=';

        args = search.split(gap);
        for (var i = 0; i < args.length; i++){
            arg = args[i].split(equal);
            if (arg.length == 2){
                param[arg[0]] = arg[1] || "";
            }
        }

        return param;
    },

    format : function(url, param, filter){
        var _this = this,
            param_arr = [],
            filter = filter || [],
            pre_param = {},
            p;

        var base_url, search, url_arr;
        url_arr = url.split("?");
        base_url = url_arr[0] || '';
        search = url_arr[1] || '';

        pre_param = _this.splitKeyValue(search);

        for (p in param){
            if(filter.indexOf(p) >= 0 ) continue;
            pre_param[p] = param[p];
        }

        for (p in pre_param){
            if (!!pre_param[p]){
                param_arr.push(p + '=' + pre_param[p]);
            }
        }

        return base_url + (param_arr.length > 0 ? '?' + param_arr.join('&') : '')
    },

    goto : function(url, param, filter){
        url = Route.format(url, param, filter);

        var loading = document.createElement("div");
        loading.innerHTML = '<div class="loading-mask"></div><div class="loading-main">正在加载中...</div>';
        loading.className = "loading-dialog";
        document.body.appendChild(loading);

        var load_iframe = document.createElement("iframe");
        load_iframe.style.height = "0px";
        load_iframe.style.width = "0px";
        load_iframe.frameBorder = 0;
        load_iframe.id = "load_iframe";

        load_iframe.onload = function(){
            document.location.href = url;
        }

        load_iframe.onerror = function(){
            alert("加载失败，请重试");
            document.body.removeChild(load_iframe, document.body);
            document.body.removeChild(loading, document.body);
        }

        

        setTimeout(function(){
            load_iframe.src = url;
            document.body.appendChild(load_iframe);
        }, 1000);
    }
}