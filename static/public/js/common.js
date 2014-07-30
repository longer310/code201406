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

	var tip_tip = '<div class="alert hide" id="j-tip">\
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

		$('#j-tip')[0].className = 'alert alert-' + type;

		$("#j-tip").height("auto");

		$("#j-tip .j-btn-close").unbind("click").bind("click", function(){
        	$('#j-tip')[0].className = 'alert hide';
            return false;
        });

		setTimeout(function(){
			$('#j-tip')[0].className = 'alert hide';
		}, delay);
		
		var height = $("#j-tip").height();
		$("#j-tip").css({
			height : height,
			"margin-top" : -height / 2
		});
	}
}