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

    $("body").append(alert_tmpl);
    $("body").append(confirm_tmpl);
    
});

var Common = {
    alert: function(options) {
        options = options || {};

        $("#j-modalAlert .j-title").html(options.title);
        $("#j-modalAlert .j-content").html(options.content);
        $('#j-modalAlert').modal('show');

        $("#j-modalAlert .j-btn-confirm").unbind("click").bind("click", function() {
            $('#j-modalAlert').modal('hide');
            (typeof options.confirm === "function") && options.confirm();
            return false;
        });
    },

    confirm: function(options) {
        options = options || {};

        $("#j-modalConfirm .j-title").html(options.title);
        $("#j-modalConfirm .j-content").html(options.content);
        $('#j-modalConfirm').modal('show');

        $("#j-modalConfirm .j-btn-confirm").unbind("click").bind("click", function() {
            $('#j-modalConfirm').modal('hide');
            (typeof options.confirm === "function") && options.confirm();
            return false;
        });

        $("#j-modalConfirm .j-btn-cancel").unbind("click").bind("click", function() {
            $('#j-modalConfirm').modal('hide');
            (typeof options.cancel === "function") && options.cancel();
            return false;
        });
    }
};

var Str = {
    format: function(source, params) {
        if (arguments.length == 1)
            return function() {
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
        $.each(params, function(i, n) {
            source = source.replace(new RegExp("\\{" + i + "\\}", "g"), n);
        });
        return source;
    }
};