﻿<%@ Page Title="" Language="C#" MasterPageFile="~/View/merchant.Master" AutoEventWireup="true" CodeBehind="List.aspx.cs" Inherits="Backstage.View.Push.List" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Header" runat="server">

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Content" runat="server">
    <div class="widget-box" >
				<div class="widget-title">
					<span class="icon">
						<i class="icon-cog"></i>
					</span>
					<h5>推送服务</h5>
					<div class="buttons">
						<a href="Add.aspx?sellerId=<%=SellerId %>" class="btn btn-primary btn-mini"><i class="icon-plus icon-white"></i> 添加</a>
					</div>
				</div>
				<div class="widget-content">
					<table class="table table-bordered table-striped">
						<thead>
							<tr>
								<th>编号</th>
								<th>类型</th>
								<th>推送主题</th>
								<th>内容</th>
								<th>推送日期</th>
							</tr>
						</thead>
						<tbody id="j-message-list">
						</tbody>
					</table>
				</div>

				<div class="widget-footer">
					<div class="pagination alternate" id="j-message-pagination">
						<ul class="page-main"></ul>
					</div>
				</div>
			</div>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Footer" runat="server">
     <!--页面js-->
        <script src="<%=DomainUrl %>/script/js/ue.pager.js"></script>

        <script type="text/jquery-tmpl-x" id="j-tmpl-message-listitem">
        	{{each(i, v) list}}
	        	<tr data-gid="1">
					<td style="width:30px;">1</td>
					<td>${v.type}商品推送</td>
					<td>${v.title}</td>
					<td>${v.content}</td>
					<td>${v.createtime}</td>
				</tr>
			{{/each}}
        </script>

        <script type="text/javascript">
            var sellerId = '<%=SellerId%>'
            var MPage = {
                init: function () {
                    var mpage = this;

                    mpage.getCommentList(1);
                },

                getCommentList: function (p) {
                    var mpage = this;

                    //$.getJSON("", { p: p}， function(json){
                    var json = {
                        code: 0,
                        msg: "",
                        result: {
                            count: 59,
                            list: [
                                {
                                    id: 1,
                                    title: "评论主题评论主题评论主题评论主题",
                                    content: "评论内容评论内容评论内容评论内容评论内容评论内容"
                                },
                                {
                                    id: 2,
                                    title: "评论主题评论主题评论主题评论主题",
                                    content: "评论内容评论内容评论内容评论内容评论内容评论内容"
                                },
                                {
                                    id: 3,
                                    title: "评论主题评论主题评论主题评论主题",
                                    content: "评论内容评论内容评论内容评论内容评论内容评论内容"
                                },
                                {
                                    id: 4,
                                    title: "评论主题评论主题评论主题评论主题",
                                    content: "评论内容评论内容评论内容评论内容评论内容评论内容"
                                },
                                {
                                    id: 5,
                                    title: "评论主题评论主题评论主题评论主题",
                                    content: "评论内容评论内容评论内容评论内容评论内容评论内容"
                                },
                                {
                                    id: 6,
                                    title: "评论主题评论主题评论主题评论主题",
                                    content: "评论内容评论内容评论内容评论内容评论内容评论内容"
                                }
                            ]
                        }
                    };
                    $.ajax({
                        url: "../../Handler/Backstage/SystemHandler.ashx?action=getpushs&sellerId=" + sellerId + "&start=" + (p - 1) + "&limit=8",
                        type: "Get",
                        dataType: "json"
                        //context: document.body
                    }).success(function (data) {
                        json.result.list = data.data.Results;
                        json.result.count = data.data.TotalCount;

                        $("#j-message-list").html($("#j-tmpl-message-listitem").tmpl(json.result));

                        ue.pager({
                            //target : $(".list_pager"),//放置分页的元素
                            pagerTarget: $("#j-message-pagination ul"),
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
                                mpage.getCommentList(page);
                            }
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
