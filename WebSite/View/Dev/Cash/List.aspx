<%@ Page Title="" Language="C#" MasterPageFile="~/View/DevMaster.Master" AutoEventWireup="true" CodeBehind="List.aspx.cs" Inherits="Backstage.View.Dev.Cash.List" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Header" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Content" runat="server">
    
			<div class="widget-box" >
				<div class="widget-title">
					<span class="icon">
						<i class="icon-shopping-cart"></i>
					</span>
					<h5>结算管理</h5>
				</div>
				<div class="widget-content">
					<ul class="nav nav-tabs" id="j-tab">
                        <li class="active"><a href="#">未处理</a></li>
					</ul>
					<table class="table table-bordered table-striped with-check">
						<thead>
							<tr>
								<th><input type="checkbox" id="j-btn-selectAll" name="title-table-checkbox" /></th>
								<th>商户账户</th>
								<th>金额</th>
								<th>手续费</th>
								<th>银行</th>
								<th>卡号</th>
                                <th>提现时间</th>
								<th>状态</th>
								<th>操作</th>
							</tr>
						</thead>
						<tbody id="j-list">
						</tbody>
					</table>
				</div>

				<div class="widget-footer">
					<div class="pagination alternate" id="j-pagination">
                        <ul class="page-main"></ul>
					</div>
				</div>
			</div>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Footer" runat="server">
    <!--页面js-->
        <script src="../public/js/ue.pager.js"></script>

        <script type="text/jquery-tmpl-x" id="j-tmpl-listitem">
        	{{each(i, v) list}}
	        	<tr data-gid="1">
					<td><input type="checkbox" class="j-select" /></td>
					<td>${v.AccountName}</td>
					<td><b class="text-info">${v.Money}</b>元</td>
					<td><b class="text-error">${v.Fee}</b>元</td>
					<td>${v.Bank}</td>
					<td>${v.CardNumber}td>
					<td>${v.CreateTime}</td>
                    <td class="j-status"><b class="text-error">${v.Status}</b></td>
                    ${if v.Status == 0}
					<td style="width:60px;">
						<a class="btn btn-primary btn-mini j-btn-pay" href="javascript:;"><i class="icon-pencil icon-white"></i> 打款</a>
					</td>
                    
				</tr>
			{{/each}}
        </script>

        <script type="text/javascript">
            var MPage = {
                cid: 0,//当前分类 默认是全部分类
                pageNum: 1,//当前页

                init: function () {
                    var mpage = this;

                    mpage.getList(1, 0);

                },

                getList: function (p, type) {
                    var mpage = this;

                    //$.getJSON("", { p: p, type : type}, function(json){
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
                    $.ajax({
                        url: "../../Handler/Backstage/DevSystemHandler.ashx?action=getcashs&start=" + (p - 1) + "&limit=8",
                        type: "Get",
                        dataType: "json"
                        //context: document.body
                    }).success(function (data) {

                        json.result.count = data.data.TotalCount;
                        json.result.list = data.data.Results;

                        $("#j-list").html($("#j-tmpl-listitem").tmpl(json.result));

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
                                mpage.getList(page, type);
                            }
                        });

                        //绑定提款
                        $("#j-list .j-btn-pay").bind("click", function () {
                            var $item = $(this).parents("tr");
                            var id = $item.attr("data-id");

                            Common.confirm({
                                title: "打款确认提示",
                                content: "您确定更改该提款申请为已处理？",
                                confirm: function () {
                                    $.ajax({
                                        url: "../../Handler/Backstage/DevSystemHandler.ashx?action=updatecash&id=" + id,
                                        type: "Get",
                                        dataType: "json"
                                        //context: document.body
                                    }).success(function (data) {
                                        $item.find(".j-status").html('<b class="text-success">已处理</b>');
                                    });
                                },
                                cancel: function () {
                                    //执行取消回调
                                    alert('执行取消回调');
                                }
                            });
                            return false;
                        });

                    });

                    //});

                }
            }

            $(function () {
                MPage.init();
            });

        </script>
</asp:Content>
