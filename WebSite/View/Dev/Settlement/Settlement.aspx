<%@ Page Title="" Language="C#" MasterPageFile="~/View/DevMaster.Master" AutoEventWireup="true" CodeBehind="Settlement.aspx.cs" Inherits="Backstage.View.Dev.Settlement.Settlement" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Header" runat="server">
    <link rel="shortcut icon" href="<%=DomainUrl %>/Css/img/favicon.ico">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Content" runat="server">



    <div class="widget-box">
        <div class="widget-title">
            <span class="icon">
                <i class="icon-shopping-cart"></i>
            </span>
            <h5>结算管理</h5>
        </div>
        <div class="widget-content">
            <ul class="nav nav-tabs" id="j-tab">
                <li class="active"><a href="#">未处理</a></li>
                <li><a href="#">历史记录</a></li>
            </ul>
            <table class="table table-bordered table-striped with-check">
                <thead>
                    <tr>
                        <%--<th>
                            <input type="checkbox" id="j-btn-selectAll" name="title-table-checkbox" /></th>--%>
                        <th style="width: 40px;">编号</th>
                        <th>商户账户</th>
                        <th>金额</th>
                        <th>手续费</th>
                        <th>开户行及支行</th>
                        <th>卡号</th>
                        <th>开户名</th>
                        <th>提现时间</th>
                        <th>打款时间</th>
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

    <!--页面js-->
    <script type="text/javascript" src="<%=DomainUrl %>/Script/js/ue.pager.js"></script>


    <script type="text/jquery-tmpl-x" id="j-tmpl-listitem">
        	{{each(i, v) list}}
	        	<tr data-id="${v.Id}">
					<%--<td><input type="checkbox" class="j-select" /></td>--%>
					<td style="width:40px;">${v.Id}</td>
					<td>${v.UserAccount}</td>
					<td><b class="text-info">${v.Money}</b>元</td>
					<td><b class="text-error">${v.Fee}</b>元</td>
					<td>${v.Bank}</td>
					<td>${v.CardNumber}</td>
					<td>${v.AccountName}</td>
					<td>${v.CreateTime.ToDate().Format("yyyy-MM-dd hh:mm:ss")}</td>
					<td>${v.SendTime.ToDate().Format("yyyy-MM-dd hh:mm:ss")}</td>
                    <td class="j-status">
                    <b class="text-error">
                        {{if v.Status == 0}}未处理
                        {{else v.Status == 1}}已打款
                        {{else v.Status == -1}}未打款
                        {{/if}}
                    </b></td>
					<td style="width:80px;">
						<a class="btn btn-primary btn-mini j-btn-pay" href="javascript:;"><i class="icon-pencil icon-white"></i> 已打款</a>
					</td>
				</tr>
			{{/each}}
        </script>

    <script type="text/javascript">
        var MPage = {
            status: 0, //提现状态
            maxpage: 5, //最多显示的页数
            start: 1, //页码
            limit: 10, //一页条数
            hander: "<%=DomainUrl %>/Handler/Platform/AnnouncementHandler.ashx?action=",

            init: function () {
                var mpage = this;

                //去掉之前选中打开的项 选中产品列表
                $("#sidebar li").removeClass("active open");
                $("#sidebar .sidebar_settlement").addClass("active open");

                mpage.getExtractMoneyList(1, 0);

                //绑定tab
                $('#j-tab a').bind("click", function (e) {
                    var status = $(this).parent().index();
                    $(this).tab('show');
                    mpage.getExtractMoneyList(1, status);
                    return false;
                });
            },

            //p 页码
            //type tab 类型
            getExtractMoneyList: function (p, status) {
                var mpage = this;
                mpage.start = p;
                mpage.status = status;

                $.post(mpage.hander + "getsettlementlist", {
                    status: mpage.status, start: mpage.start - 1, limit: mpage.limit
                }, function (data) {
                    if (!data.error) {
                        $("#j-list").html($("#j-tmpl-listitem").tmpl(data));

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
                            now: mpage.start, //当前页
                            maxPage: mpage.maxpage, //显示的最多页数
                            per: mpage.limit, //每页显示几个
                            count: data.totalcount,
                            onchange: function (page) { //切换页数回调函数
                                mpage.getExtractMoneyList(page, mpage.status);
                            }
                        });

                        if (status == 1) {
                            $("#j-list").parents("table").find("th").last().hide();
                            $("#j-list").find(".j-btn-pay").parents("td").hide();
                        } else {
                            $("#j-list").parents("table").find("th").last().show();
                            $("#j-list").find(".j-btn-pay").parents("td").show();
                        }

                        //绑定提款
                        $("#j-list .j-btn-pay").bind("click", function () {
                            var $item = $(this).parents("tr");
                            var id = $item.attr("data-id");

                            Common.confirm({
                                title: "打款确认提示",
                                content: "您确定更改该提款申请为已处理？",
                                confirm: function () {
                                    //执行确认回调
                                    mpage.updateStatus(id);
                                    //$item.find(".j-status").html('<b class="text-success">已处理</b>');
                                }
                            });
                            return false;
                        });
                    }
                }, "JSON");
            },

            //打款
            updateStatus: function (id) {
                var mpage = this;
                $.post(mpage.hander + "updateextractmoney", { id: id, status: 1 }, function (data) {
                    if (!data.error) {
                        Common.tip({ type: "success", content: data.success });
                        mpage.getExtractMoneyList(mpage.start, mpage.status);
                    } else {
                        Common.tip({ type: "error", content: data.error });
                    }
                }, "JSON");
            }
        };

        $(function () {
            MPage.init();
        });

        </script>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Footer" runat="server">
</asp:Content>
