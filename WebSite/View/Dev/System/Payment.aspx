<%@ Page Title="" Language="C#" MasterPageFile="~/View/DevMaster.Master" AutoEventWireup="true" CodeBehind="Payment.aspx.cs" Inherits="Backstage.View.Dev.System.Payment" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Header" runat="server">
    <link rel="shortcut icon" href="<%=DomainUrl %>/Css/img/favicon.ico">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Content" runat="server">

    <div class="widget-box">
        <div class="widget-title">
            <span class="icon">
                <i class="icon-cog"></i>
            </span>
            <h5>支付接口</h5>
        </div>
        <div class="widget-content">
            <ul class="nav nav-tabs">
                <li class="active"><a href="<%=DomainUrl %>/View/Dev/System/Payment.aspx">支付接口列表</a></li>
                <li><a href="<%=DomainUrl %>/View/Dev/System/AddPayment.aspx">添加支付接口</a></li>
            </ul>

            <div class="list-2col list-4col">
                <ul class="list-in" id="j-list">
                </ul>
            </div>
        </div>
    </div>

    <!--页面js-->
    <script type="text/javascript" src="<%=DomainUrl %>/Script/js/ue.pager.js"></script>

    <!--活动列表模版-->
    <script type="text/jquery-tmpl-x" id="j-tmpl-listitem">
        	{{each(i, v) list}}
	        	<li class="item" data-id="${v.Id}">
					<div class="item-in">
						<h3 class="post-title" sty>${v.Name}</h3>
						<div class="article-thumb" style="width:100px;height:100px;">
							<img width="100" height="100"  alt="User" src="${v.ImgUrl}" />
						</div>
						<div class="article-post">
							<div class="post-action">
								{{if v.Status == 1}}
									<a href="javascript:;" class="btn btn-danger btn-mini j-btn-status" data-status="0"><i class="icon-pause icon-white"></i> 停用</a>
								{{else}}
									<a href="javascript:;" class="btn btn-success btn-mini j-btn-status" data-status="1"><i class="icon-play icon-white"></i> 启用</a>
								{{/if}}
								
								<a href="<%=DomainUrl %>/view/dev/system/editpayment.aspx?id=${v.Id}" class="btn btn-primary btn-mini"><i class="icon-pencil icon-white"></i> 编辑</a>
								<a href="javascript:;" class="btn btn-danger btn-mini j-btn-del"><i class="icon-remove icon-white"></i> 删除</a>
							</div>
						</div>
					</div>
				</li>
			{{/each}}
        </script>

    <script type="text/javascript">
        var MPage = {
            hander: "<%=DomainUrl %>/Handler/Platform/AnnouncementHandler.ashx?action=",
                init: function () {
                    var mpage = this;

                    //去掉之前选中打开的项 选中产品列表
                    $("#sidebar li").removeClass("active open");
                    $("#sidebar .sidebar_sys").addClass("active open").find(".sidebar_payment").addClass("active");

                    mpage.getPaymentList(1);
                },

                getPaymentList: function () {
                    var mpage = this;

                    $.post(mpage.hander + "getpaymentlist", {}, function (data) {
                        if (!data.error) {
                            $("#j-list").html($("#j-tmpl-listitem").tmpl(data));

                            //绑定单个删除
                            $("#j-list .j-btn-del").bind("click", function () {
                                var $item = $(this).parents("li");
                                var id = $item.attr("data-id");

                                Common.confirm({
                                    title: "删除确认提示",
                                    content: "您确定要删除当前支付方式？",
                                    confirm: function () {
                                        //执行确认回调
                                        mpage.delPayment(id);
                                    }
                                });
                                return false;
                            });

                            //绑定启用改变
                            $("#j-list .j-btn-status").bind("click", function () {
                                var $btn = $(this),
                                    status = $btn.attr("data-status"),
                                    $item = $btn.parents("li"),
                                    id = $item.attr("data-id");

                                Common.confirm({
                                    title: "删除确认提示",
                                    content: "您确定要" + (status == 1 ? "启用" : "停用") + "该支付方式？",
                                    confirm: function () {
                                        //执行确认回调
                                        mpage.updatePaymentStatus(id, status);
                                    }
                                });
                                return false;
                            });
                        }
                    }, "JSON");
                },

                delPayment: function (id) {
                    var mpage = this;
                    $.post(mpage.hander + "delpayment", { id: id }, function (data) {
                        if (!data.error) {
                            Common.tip({ type: "success", content: data.success });
                            mpage.getPaymentList();
                        } else {
                            Common.tip({ type: "error", content: data.error });
                        }
                    }, "JSON");
                },

                updatePaymentStatus: function (id, status) {
                    var mpage = this;
                    $.post(mpage.hander + "updatepaymentstatus", { id: id, status: status }, function (data) {
                        if (!data.error) {
                            Common.tip({ type: "success", content: data.success });
                            mpage.getPaymentList();
                        } else {
                            Common.tip({ type: "error", content: data.error });
                        }
                    }, "JSON");
                },

            };

            $(function () {
                MPage.init();
            });
        </script>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Footer" runat="server">
</asp:Content>
