$(function () {
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

    var tip_tip = '<div class="alert hide" id="j-tip">\
						<a class="close j-btn-close" href="javascript:;">×</a>\
						<p class="j-content"></p>\
					</div>';

    $("body").append(alert_tmpl);
    $("body").append(confirm_tmpl);
    $("body").append(tip_tip);
});

var Common = {
    alert: function (options) {
        options = options || {};


        $("#j-modalAlert .j-title").html(options.title);
        $("#j-modalAlert .j-content").html(options.content);
        $('#j-modalAlert').modal('show');

        $("#j-modalAlert .j-btn-confirm").unbind("click").bind("click", function () {
            $('#j-modalAlert').modal('hide');
            (typeof options.confirm === "function") && options.confirm();
            return false;
        });

        $("#j-modalAlert").height("auto");
        var height = $("#j-modalAlert").height();
        $("#j-modalAlert").css({
            height: height,
            "margin-top": -height / 2
        });
    },

    confirm: function (options) {
        options = options || {};

        $("#j-modalConfirm .j-title").html(options.title);
        $("#j-modalConfirm .j-content").html(options.content);
        $('#j-modalConfirm').modal('show');

        $("#j-modalConfirm .j-btn-confirm").unbind("click").bind("click", function () {
            $('#j-modalConfirm').modal('hide');
            (typeof options.confirm === "function") && options.confirm();
            return false;
        });

        $("#j-modalConfirm .j-btn-cancel").unbind("click").bind("click", function () {
            $('#j-modalConfirm').modal('hide');
            (typeof options.cancel === "function") && options.cancel();
            return false;
        });

        $("#j-modalConfirm").height("auto");
        var height = $("#j-modalConfirm").height();
        $("#j-modalConfirm").css({
            height: height,
            "margin-top": -height / 2
        });
    },

    tip: function (options) {
        options = options || {};
        var type = options.type || "info";
        var delay = options.delay || 3000;

        $("#j-tip .j-content").html(options.content);

        $('#j-tip')[0].className = 'alert alert-' + type;

        $("#j-tip").height("auto");

        $("#j-tip .j-btn-close").unbind("click").bind("click", function () {
            $('#j-tip')[0].className = 'alert hide';
            return false;
        });

        setTimeout(function () {
            $('#j-tip')[0].className = 'alert hide';
        }, delay);

        var height = $("#j-tip").height();
        $("#j-tip").css({
            height: height,
            "margin-top": -height / 2
        });
    },

    parseDate: function (date, format) {
        var o = {
            "M+": date.getMonth() + 1, //month
            "d+": date.getDate(), //day
            "h+": date.getHours(), //hour
            "m+": date.getMinutes(), //minute
            "s+": date.getSeconds(), //second
            "q+": Math.floor((date.getMonth() + 3) / 3), //quarter
            "S": date.getMilliseconds() //millisecond
        };

        if (/(y+)/.test(format)) {
            format = format.replace(RegExp.$1, (date.getFullYear() + "").substr(4 - RegExp.$1.length));
        }

        for (var k in o) {
            if (new RegExp("(" + k + ")").test(format)) {
                format = format.replace(RegExp.$1, RegExp.$1.length == 1 ? o[k] : ("00" + o[k]).substr(("" + o[k]).length));
            }
        }
        return date;
    },
}

String.prototype.ToDate = function () {
    var date = new Date(parseInt(this.replace("/Date(", "").replace(")/", ""), 10));
    return date;
}
Date.prototype.Format = function (format) {
    /*
    * eg:format="YYYY-MM-dd hh:mm:ss";
    */
    var o = {
        "M+": this.getMonth() + 1,  //month
        "d+": this.getDate(),     //day
        "h+": this.getHours(),    //hour
        "m+": this.getMinutes(),  //minute
        "s+": this.getSeconds(), //second
        "q+": Math.floor((this.getMonth() + 3) / 3),  //quarter
        "S": this.getMilliseconds() //millisecond
    }

    if (/(y+)/.test(format)) {
        format = format.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
    }

    for (var k in o) {
        if (new RegExp("(" + k + ")").test(format)) {
            format = format.replace(RegExp.$1, RegExp.$1.length == 1 ? o[k] : ("00" + o[k]).substr(("" + o[k]).length));
        }
    }
    return format;
}

var Route = {
    SEARCH: 1,
    HASH: 2,
    FILENAME: 4,
    ALL: 7,

    parse: function (url) {
        var _this = this;
        var a = document.createElement('a');

        a.href = url;

        var route = {
            hostname: a.hostname,
            host: a.host,
            hash: a.hash.replace("#", ""),
            search: a.search.replace("?", ""),
            pathname: a.pathname,
            url: a.href,
            protocol: a.protocol,
            file: (a.pathname.split('/').reverse())[0],
            port: a.port,
            origin: a.origin
        };

        if (arguments.length == 2) {
            route.param = _this.split(route, arguments[1]);
        }

        return route;
    },

    split: function (route, pattern) {
        var _this = this;
        var pattern = pattern || _this.SEARCH,
            param = {},
            i, arg,
            args;

        if (pattern & _this.FILENAME) {
            args = route.file.split(/[\-\.]/gi);

            //去掉第一个页面名称和最后一个文件后缀名称
            args.shift();
            args.pop();

            for (var i = 0; i < args.length / 2; i++) {
                param[args[2 * i]] = args[2 * i + 1];
            }
        }

        if (pattern & _this.SEARCH) {
            param = _this.splitKeyValue(route.search);
        }

        if (pattern & _this.HASH) {
            param = _this.splitKeyValue(route.hash.replace("?", ''));
        }

        return param;
    },

    splitKeyValue: function (search, gap, equal) {
        var arg, args, param = {},
            gap = gap || '&',
            equal = equal || '=';

        args = search.split(gap);
        for (var i = 0; i < args.length; i++) {
            arg = args[i].split(equal);
            if (arg.length == 2) {
                param[arg[0]] = arg[1] || "";
            }
        }

        return param;
    },

    format: function (url, param, filter) {
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

        for (p in param) {
            if (filter.indexOf(p) >= 0) continue;
            pre_param[p] = param[p];
        }

        for (p in pre_param) {
            if (!!pre_param[p]) {
                param_arr.push(p + '=' + pre_param[p]);
            }
        }

        return base_url + (param_arr.length > 0 ? '?' + param_arr.join('&') : '');
    }
};

//全局格式化公用方法，别删除呀！
var Str = {
    format: function (source, params) {
        if (arguments.length == 1)
            return function () {
                var args = $.makeArray(arguments);
                args.unshift(source);
                return $.format.apply(this, args);
            };
        if (arguments.length > 2 && params.constructor != Array) {
            params = $.makeArray(arguments).slice(1);
        }
        if (params.constructor != Array) {
            params = [params];
        }
        $.each(params, function (i, n) {
            source = source.replace(new RegExp("\\{" + i + "\\}", "g"), n);
        });
        return source;
    },
    getQueryString: function (name) {
        var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
        var r = window.location.search.substr(1).match(reg);
        if (r != null) return unescape(r[2]); return null;
    },
};
