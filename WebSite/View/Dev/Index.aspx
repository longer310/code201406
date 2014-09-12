<%@ Page Title="" Language="C#" MasterPageFile="~/View/DevMaster.Master" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="WebSite.View.Dev.Index" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Header" runat="server">

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Content" runat="server">
    <div class="widget-box" >
				<div class="widget-title">
					<span class="icon">
						<i class="icon-home"></i>
					</span>
					<h5>首页</h5>
				</div>
				<div class="widget-content">
					<div class="widget-box nest-box" >
						<div class="widget-title">
							<h5>快捷链接</h5>
						</div>
						<div class="widget-content">
							<ul class="home-links clearfix">
                                <%foreach(var item in Fastlinkslist){ %>
								<li>
									<a href="<%=item.Url %>" class="thumbnail">
										<img src="<%=item.ImgUrl %>" alt="" id="j-sysytem-profile-logo">
										<span><%=item.Title %></span>
									</a>
								</li>
								<%} %>
							</ul>
						</div>
					</div>

					<div class="widget-box nest-box" >
						<div class="widget-title">
							<h5>未处理信息</h5>
						</div>
						<div class="widget-content">
							<ul class="site-stats row-fluid">
								<li class="span6"><a href="<%=DomainUrl %>/View/Dev/Settlement/Settlement.aspx"><i class="icon-shopping-cart"></i> <strong class="text-info">3</strong> <small>提现申请</small></a></li>
								<li class="span6"><a href="<%=DomainUrl %>/View/Dev/Merchant/Merlist.aspx"><i class="icon-user"></i> <strong class="text-info">16</strong> <small>即将到期商户</small></a></li>
							</ul>
						</div>
					</div>

					<div class="row-fluid">
						<div class="span3">
							<div class="widget-box nest-box" >
								<div class="widget-title">
									<span class="icon">
										<i class="icon-list-alt"></i>
									</span>
									<h5>商户统计</h5>
								</div>
								<div class="widget-content">
									<ul class="site-stats">
										<%--<li><strong>3家</strong> <small>今日</small></li>
										<li><strong>16家</strong> <small>本月</small></li>
										<li><strong>16家</strong> <small>季度</small></li>--%>
										<li><strong><%=SystemStat.MerchantCount %>家</strong> <small>历史</small></li>
									</ul>
								</div>
							</div>
						</div>

						<div class="span3">
							<div class="widget-box nest-box" >
								<div class="widget-title">
									<span class="icon">
										<i class="icon-shopping-cart"></i>
									</span>
									<h5>用户统计</h5>
								</div>
								<div class="widget-content">
									<ul class="site-stats">
										<li><strong><%=SystemStat.UserCount %>名</strong> <small>历史</small></li>
									</ul>
								</div>
							</div>
						</div>

						<%--<div class="span3">
							<div class="widget-box nest-box" >
								<div class="widget-title">
									<span class="icon">
										<i class="icon-inbox"></i>
									</span>
									<h5>客户端下载统计</h5>
								</div>
								<div class="widget-content">
									<ul class="site-stats">
										<li><strong>3次</strong> <small>今日</small></li>
										<li><strong>16次</strong> <small>本月</small></li>
										<li><strong>16次</strong> <small>季度</small></li>
										<li><strong>259次</strong> <small>历史</small></li>
									</ul>
								</div>
							</div>
						</div>--%>

						<div class="span3">
							<div class="widget-box nest-box" >
								<div class="widget-title">
									<span class="icon">
										<i class="icon-picture"></i>
									</span>
									<h5>交易金额统计</h5>
								</div>
								<div class="widget-content">
									<ul class="site-stats">
										<li><strong><%=SystemStat.MoneyCount %>元</strong> <small>历史</small></li>
									</ul>
								</div>
							</div>
						</div>
					</div>

					<div class="widget-box nest-box" >
						<div class="widget-title">
							<h5>商户分类统计</h5>
						</div>
						<div class="widget-content">
							<ul class="home-links clearfix">
								<li>
									<a href="" class="thumbnail">餐饮类 <b class="text-success">34</b> 家</a>
								</li>
								<li>
									<a href="" class="thumbnail">餐饮类 <b class="text-success">34</b> 家</a>
								</li>
								<li>
									<a href="" class="thumbnail">餐饮类 <b class="text-success">34</b> 家</a>
								</li>
								<li>
									<a href="" class="thumbnail">餐饮类 <b class="text-success">34</b> 家</a>
								</li>
								<li>
									<a href="" class="thumbnail">餐饮类 <b class="text-success">34</b> 家</a>
								</li>
								<li>
									<a href="" class="thumbnail">餐饮类 <b class="text-success">34</b> 家</a>
								</li>
								<li>
									<a href="" class="thumbnail">餐饮类 <b class="text-success">34</b> 家</a>
								</li>
								<li>
									<a href="" class="thumbnail">餐饮类 <b class="text-success">34</b> 家</a>
								</li>
								<li>
									<a href="" class="thumbnail">餐饮类 <b class="text-success">34</b> 家</a>
								</li>
								<li>
									<a href="" class="thumbnail">餐饮类 <b class="text-success">34</b> 家</a>
								</li>
								<li>
									<a href="" class="thumbnail">餐饮类 <b class="text-success">34</b> 家</a>
								</li>
								<li>
									<a href="" class="thumbnail">餐饮类 <b class="text-success">34</b> 家</a>
								</li>
							</ul>
						</div>
					</div>
				</div>
			</div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Footer" runat="server">


</asp:Content>
