<%@ Page Title="" Language="C#" MasterPageFile="~/View/merchant.Master" AutoEventWireup="true" CodeBehind="Add.aspx.cs" Inherits="Backstage.View.Push.Add" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Header" runat="server">

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Content" runat="server">
    <div class="widget-box" >
				<div class="widget-title">
					<span class="icon">
						<i class="icon-cog"></i>
					</span>
					<h5>新增推送</h5>
				</div>
				<div class="widget-content">
					<form action="#" method="get" class="form-horizontal" id="j-addForm" />
						<div class="control-group">
							<label class="control-label">推送主题</label>
							<div class="controls">
								<input type="text" id="j-title" />
							</div>
						</div>

						<div class="control-group">
							<label class="control-label">推送类型</label>
							<div class="controls">
								<select id="j-type">
									<option value="0">商品推送</option>
									<option value="1">活动推送</option>
									<option value="2">图片墙推送</option>
									<option value="3">URL推送</option>
								</select>
							</div>
						</div>

						<div class="control-group" id="j-goto_hold">
							<label class="control-label">商品选择</label>
							<div class="controls">
								<input type="text" id="j-goto" />
							</div>
						</div>

						<div class="control-group" id="j-url_hold" style="display:none;">
							<label class="control-label">URL地址</label>
							<div class="controls">
								<input type="text" id="j-url" />
							</div>
						</div>

						<div class="form-actions">
							<button type="reset" class="btn"><i class="icon-refresh"></i> 清除重置</button>
							<button type="submit" class="btn btn-primary"><i class="icon-ok icon-white"></i> 完成保存</button>
						</div>
					</form>
				</div>
			</div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Footer" runat="server">
    <!--页面js-->
        <script src="../public/js/ue.pager.js"></script>

        <script charset="utf-8" src="../public/kindeditor/kindeditor-min.js"></script>
		<script charset="utf-8" src="../public/kindeditor/lang/zh_CN.js"></script>

		<!--选择电子券弹窗-->
		<div id="j-selectModal" class="modal hide">
			<div class="modal-header">
				<button data-dismiss="modal" class="close" type="button">×</button>
				<h3>选择电子券</h3>
			</div>
			<div class="modal-body">
				<ul class="activity-list" id="j-list">
                    <li><a href="#">电子券名称电子券名称电子券名称电子券名称电子券名称</a></li>
                    <li><a href="#">电子券名称电子券名称电子券名称电子券名称电子券名称</a></li>
                    <li><a href="#">电子券名称电子券名称电子券名称电子券名称电子券名称</a></li>
                    <li><a href="#">电子券名称电子券名称电子券名称电子券名称电子券名称</a></li>
                    <li><a href="#">电子券名称电子券名称电子券名称电子券名称电子券名称</a></li>
                    <li><a href="#">电子券名称电子券名称电子券名称电子券名称电子券名称</a></li>
                </ul>
			</div>
			<div class="modal-footer">
				<div class="pagination alternate" id="j-pagination">
					<ul class="page-main">
						<li class="disabled"><a href="#">首页</a></li>
						<li class="disabled"><a href="#">上一页</a></li>
						<li class="active">
							<a href="#">1</a>
						</li>
						<li><a href="#">2</a></li>
						<li><a href="#">3</a></li>
						<li><a href="#">4</a></li>
						<li><a href="#">下一页</a></li>
						<li><a href="#">末页</a></li>
						<li class="page-info"><b class="text-info">1</b>/8页 共<b class="text-info">18</b>条记录</li>
					</ul>
				</div>
			</div>
		</div>

		<!--电子券列表模版-->
		<script type="text/jquery-tmpl-x" id="j-tmpl-listitem">
        	{{each(i, v) list}}
	        	<li data-id="1"><a href="#">电子券名称电子券名称电子券名称电子券名称电子券名称</a></li>
			{{/each}}
        </script>

        <script type="text/javascript">
            var MPage = {
                init: function () {
                    var mpage = this;


                    $("#j-type").bind("change", function () {
                        var type = parseInt($(this).val());

                        $("#j-goto").removeAttr("data-id").val('');
                        switch (type) {
                            case 0:
                                $("#j-goto_hold").show().find("label").html("商品选择");
                                $("#j-url_hold").hide();
                                break;
                            case 1:
                                $("#j-goto_hold").show().find("label").html("活动选择");
                                $("#j-url_hold").hide();
                                break;
                            case 2:
                                $("#j-goto_hold").show().find("label").html("图片墙选择");
                                $("#j-url_hold").hide();
                                break;
                            case 3:
                                $("#j-goto_hold").hide();
                                $("#j-url_hold").show();
                                break;
                        }
                    });

                    //绑定选择
                    $("#j-goto").bind("focus", function () {
                        var type = parseInt($("#j-type").val());
                        mpage.getGotoList(1, type);
                        $('#j-selectModal').modal('show');
                    });

                    //绑定提交表单
                    $("#j-addForm").bind("submit", function () {
                        var save_data = {
                            title: $.trim($("#j-title").val()),
                            goto: $("#j-goto").attr("data-id"),
                            url: $('#j-url').val()

                        }

                        console.log(save_data);
                        alert('提交数据')
                        return false;
                    });

                    //绑定重置表单
                    $("#j-addForm").bind("reset", function () {
                        $("#j-title").val('');
                        $("#j-type").val('');
                        $("#j-goto").val('');
                        $("#j-url").val('');
                        return false;
                    });
                },

                getGotoList: function (p, type) {
                    var mpage = this;

                    //$.getJSON("", { p: p, type : type}， function(json){
                    var json = {
                        code: 0,
                        msg: "",
                        result: {
                            count: 59,
                            list: [
                                {},
                                {},
                                {},
                                {},
                                {},
                                {}
                            ]
                        }
                    };

                    $("#j-list").html($("#j-tmpl-listitem").tmpl(json.result));

                    $("#j-list li").bind("click", function () {
                        var gid = $(this).attr("data-id"),
                            title = $(this).text();

                        $("#j-goto").attr("data-id", gid).val(title);
                        $('#j-selectModal').modal('hide');
                        return false;
                    });

                    ue.pager({
                        //target : $(".list_pager"),//放置分页的元素
                        pagerTarget: $("#j-pagination ul"),
                        first: '<li><a href="#">首页</a></li>',
                        firstDisabled: '<li class="disabled"><a href="#">首页</a></li>',
                        last: '<li><a href="#">末页</a></li>',
                        lastDisabled: '<li class="disabled"><a href="#">末页</a></li>',
                        prev: '<li><a href="#">上一页</a></li>',
                        prevDisabled: '<li class="disabled"><a href="#">上一页</a></li>',
                        next: '<li><a href="#">下一页</a></li>',
                        nextDisabled: '<li class="disabled"><a href="#">下一页</a></li>',
                        current: '<li class="active"><a href="#">@{page}</a></li>',
                        page: '<li><a href="#">@{page}</a></li>',
                        tip: '<li class="page-info"><b class="text-info">@{nowPage}</b>/@{pageCount}页 共<b class="text-info">@{count}</b>条记录</li>',
                        now: p,//当前页
                        maxPage: 5,//显示的最多页数
                        per: 6,//每页显示几个
                        count: json.result.count,
                        onchange: function (page) {//切换页数回调函数
                            mpage.getGotoList(page, type);
                        }
                    })
                    //});

                }
            }

            $(function () {
                MPage.init();
            });

        </script>
</asp:Content>
