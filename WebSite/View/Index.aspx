﻿<%@ Page Title="" Language="C#" MasterPageFile="~/View/merchant.Master" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="Backstage.View.Index" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Header" runat="server">
    <!--页面样式-->
    <link href="../script/kindeditor/themes/default/default.css" type="text/css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Content" runat="server">
    <div class="widget-box">
        <div class="widget-title">
            <span class="icon">
                <i class="icon-home"></i>
            </span>
            <h5>首页</h5>
        </div>
        <div class="widget-content">
            <div class="alert alert-info alert-block">
                <h4 class="alert-heading">公告</h4>
                <%=MerchantStat.AnnouncementContent %>
            </div>

            <div class="widget-box nest-box">
                <div class="widget-title">
                    <h5>快捷链接</h5>
                </div>
                <div class="widget-content">
                    <ul class="home-links clearfix">
								<li>
									<a href="<%=DomainUrl %>/View/Active/Add.aspx?sellerId=<%=SellerId%>"" class="thumbnail">
										<span>新增活动</span>
									</a>
								</li>
								<li>
									<a href="<%=DomainUrl %>/View/Goods/Item.aspx?sellerId=<%=SellerId%>" class="thumbnail">
										<span>新增产品 </span>
									</a>
								</li>
								<li>
									<a href="<%=DomainUrl %>/View/Goods/Categroy.aspx?sellerId=<%=SellerId%>" class="thumbnail">
										<span>分类管理</span>
									</a>
								</li>
								<li>
									<a href="<%=DomainUrl %>/View/SourceMaterial/Add.aspx?sellerId=<%=SellerId%>" class="thumbnail">
										<span>新增图片墙</span>
									</a>
								</li>
								<li>
									<a href="<%=DomainUrl %>/View/Coupon/Add.aspx?sellerId=<%=SellerId%>" class="thumbnail">
										<span>新增电子券</span>
									</a>
								</li>
								<li>
									<a href="<%=DomainUrl %>/View/Cash/List.aspx" class="thumbnail">
										<span>提现管理</span>
									</a>
								</li>
							</ul>
                </div>
            </div>

            <div class="row-fluid">
                <div class="span3">
                    <div class="widget-box nest-box">
                        <div class="widget-title">
                            <span class="icon">
                                <i class="icon-list-alt"></i>
                            </span>
                            <h5>商户统计信息</h5>
                        </div>
                        <div class="widget-content">
                            <ul class="site-stats">
                                <li><i class="icon-user"></i><strong><%=MerchantStat.UserCount %></strong> <small>会员数量</small></li>
                                <li><i class="icon-gift"></i><strong><%=MerchantStat.ActiveCount %></strong> <small>活动数量</small></li>
                                <li><i class="icon-tint"></i><strong><%=MerchantStat.GoodsCount %></strong> <small>商品数量</small></li>
                                <li><i class="icon-picture"></i><strong><%=MerchantStat.ImgCount %></strong> <small>图片墙数量</small></li>
                            </ul>
                        </div>
                    </div>
                </div>

                <div class="span3">
                    <div class="widget-box nest-box">
                        <div class="widget-title">
                            <span class="icon">
                                <i class="icon-shopping-cart"></i>
                            </span>
                            <h5>成交订单统计</h5>
                        </div>
                        <div class="widget-content">
                            <ul class="site-stats">
                                <li><strong><%=MerchantStat.OrderNumber %>单</strong> <small>历史</small></li>
                                <li><strong><%=MerchantStat.MoneyCount %>元</strong> <small>历史</small></li>
                            </ul>
                        </div>
                    </div>
                </div>

                <%--<div class="span3">
                    <div class="widget-box nest-box">
                        <div class="widget-title">
                            <span class="icon">
                                <i class="icon-inbox"></i>
                            </span>
                            <h5>成交金额统计</h5>
                        </div>
                        <div class="widget-content">
                            <ul class="site-stats">
                                <li><strong>3元</strong> <small>今日</small></li>
                                <li><strong>16元</strong> <small>本月</small></li>
                                
                            </ul>
                        </div>
                    </div>
                </div>

                <div class="span3">
                    <div class="widget-box nest-box">
                        <div class="widget-title">
                            <span class="icon">
                                <i class="icon-picture"></i>
                            </span>
                            <h5>图片墙统计</h5>
                        </div>
                        <div class="widget-content">
                            <ul class="site-stats">
                                <li><strong>3MB</strong> <small>素材库总量</small></li>
                                <li><strong>16MB</strong> <small>已使用</small></li>
                                <li><strong>259MB</strong> <small>剩余空间</small></li>
                            </ul>
                        </div>
                    </div>
                </div>--%>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Footer" runat="server">
    
        <script type="text/javascript">
            var MPage = {
                init: function () {
                    var mpage = this;


                }
            }

            $(function () {
                MPage.init();
            });

        </script>
</asp:Content>
