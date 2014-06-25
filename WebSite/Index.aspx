<%@ Page Language="C#" AutoEventWireup="true" Inherits="Backstage.Index" Codebehind="index.aspx.cs" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
	<meta http-equiv="content-type" content="text/html; charset=gb2312" />
    <title>麦霸KTV后台管理系统</title>

	<!-- Loading Bootstrap -->
	<link href="archon/bootstrap/css/bootstrap.css" rel="stylesheet">

	<!-- Loading Stylesheets -->    
	<link href="archon/css/archon.css" rel="stylesheet">
	<link href="archon/css/responsive.css" rel="stylesheet">
	<link href="archon/css/prettify.css" rel="stylesheet">

	<!-- Loading Custom Stylesheets -->    
	<link href="archon/css/custom.css" rel="stylesheet">

	<link rel="shortcut icon" href="archon/images/favicon.ico">
</head>
<body>
	<div class="frame">
		<div class="sidebar">
			<div class="wrapper">

				<!-- Replace the src of the image with your logo -->
				<ul class="nav  nav-list">

					<!-- sidebar input search box -->

					<!-- Sidebar header @add class nav-header for sidebar header -->
					<li class="nav-header">管理者</li>
					<li  class="active"><a href="javascript:void(0);" onclick="page.setiframe('View/UCenter/ManagerList.aspx')"><i class="icon-dashboard"></i>管理员管理 </a></li>

					<!-- Sidebar header @add class nav-header for sidebar header -->
					<li class="nav-header">开发者后台</li>
					<li>
						<a class="dropdown" href="#"><i class="icon-tint"></i> 数据管理 <span class="label">2</span></a>
						<ul>
							<li><a href="#"><i class="icon-bullhorn"></i> 消息管理</a></li>
							<li><a href="#"><i class="icon-minus"></i>数据统计 </a></li>
						</ul>	
					</li>
					<li><a href="#"><i class="icon-group"></i>商户管理</a></li>
					<li><a href="#"><i class="icon-calendar"></i>结算管理</a></li>
					<li><a href="#"><i class="icon-picture"></i>系统设置</a></li>

					<!-- Sidebar header @add class nav-header for sidebar header -->
					<li class="nav-header">后台管理</li>
					<li><a href="#"><i class="icon-table"></i>活动管理</a></li>
					<li><a href="#"><i class="icon-text-width"></i>产品管理</a></li>
					<li><a href="#"><i class="icon-truck"></i>订单管理</a></li>
					<li><a href="#"><i class="icon-truck"></i>图墙管理</a></li>
					<li><a href="#"><i class="icon-truck"></i>会员管理</a></li>
					<li><a href="#"><i class="icon-truck"></i>留言管理</a></li>
					<li><a href="#"><i class="icon-truck"></i>电子券管理</a></li>
					<li><a href="#"><i class="icon-truck"></i>广告管理</a></li>
					<li><a href="#"><i class="icon-truck"></i>数据管理</a></li>
					<li><a href="#"><i class="icon-truck"></i>系统管理</a></li>
					<li><a href="#"><i class="icon-truck"></i>位置管理</a></li>
				</ul>

			</div><!-- /Wrapper -->
		</div><!-- /Sidebar -->

		<!-- Main content starts here-->
		<div class="content">
			<div class="navbar">
				<a href="#" onclick="return false;" class="btn pull-left toggle-sidebar"><i class="icon-list"></i></a>
				<a class="navbar-brand" href="Index.aspx">Archon</a>

				<!-- Top right user menu -->
				<ul class="nav navbar-nav user-menu pull-right">
                    <li class="rolename"><%=RoleName %></li>
					<li class="dropdown user-name">
						<a class="dropdown-toggle" data-toggle="dropdown"><img src="archon/images/theme/avatarSeven.png" class="user-avatar" alt="" /><%=UserName %></a>
							<ul class="dropdown-menu right inbox user">
								<li class="user-avatar">
									<img src="archon/images/theme/avatarSeven.png" class="user-avatar" alt="" />
									<%=UserName %>
								</li>
							<li>
								<i class="icon-user avatar"></i>
								<div class="message">
									<span class="username">Profile</span> 
								</div>
							</li>
							<li>
								<i class="icon-cogs avatar"></i>
								<div class="message">
									<span class="username">Settings </span> 
								</div>
							</li>
							<li>
								<i class="icon-book avatar"></i>
								<div class="message">
									<span class="username">Help </span> 
								</div>
							</li>
							<li><a href="javascript:void(0);" onclick="page.logout();">Logout</a></li>
						</ul>
					</li><!-- / dropdown -->				
				</ul><!-- / Top right user menu -->

			</div><!-- / Navbar-->
<!-- /Main Content  @7 -->
            <div id="main-content">
                <iframe width=1030px height=800px frameborder=0 scrolling="no"  src="View/UCenter/ManagerList.aspx"></iframe>
             </div>
		</div><!-- / Content @5 -->

	</div> <!-- Frame -->

    
	<!-- Load JS here for greater good =============================-->
	<script src="archon/js/jquery-1.8.3.min.js"></script>
	<script src="archon/js/jquery-ui-1.10.3.custom.min.js"></script>
	<script src="archon/js/jquery.ui.touch-punch.min.js"></script>

	<script src="archon/js/bootstrap-select.js"></script>
	<script src="archon/js/bootstrap-switch.js"></script>
	<script src="archon/js/bootstrap-typeahead.js"></script>
	<script src="archon/js/jquery.tagsinput.js"></script>
	<script src="archon/js/jquery.placeholder.js"></script>
	<script src="archon/js/application.js"></script>
	<script src="archon/js/moment.min.js"></script>
	<script src="archon/js/jquery.dataTables.min.js"></script>
	<script src="archon/js/jquery.sortable.js"></script>
	<script type="text/javascript" src="archon/js/jquery.gritter.js"></script>

	<!-- Charts  =============================-->
	<script src="archon/js/charts/jquery.flot.js"></script>
	<script src="archon/js/charts/jquery.flot.resize.js"></script>
	<script src="archon/js/charts/jquery.flot.stack.js"></script>
	<script src="archon/js/charts/jquery.flot.pie.min.js"></script>	
	<script src="archon/js/charts/jquery.sparkline.min.js"></script>	
	<script src="archon/js/jquery.knob.js"></script>


	<!-- NVD3 graphs  =============================-->
	<%--<script src="archon/js/nvd3/lib/d3.v3.js"></script>
	<script src="archon/js/nvd3/nv.d3.js"></script>
	<script src="archon/js/nvd3/src/models/legend.js"></script>
	<script src="archon/js/nvd3/src/models/pie.js"></script>
	<script src="archon/js/nvd3/src/models/pieChart.js"></script>
	<script src="archon/js/nvd3/src/utils.js"></script>
	<script src="archon/js/nvd3/sample.nvd3.js"></script>

	<!-- Map and icons on map
	<script src="https://maps.googleapis.com/maps/api/js?v=3.exp&amp;sensor=false"></script>-->
	<script src="archon/js/map-icons.js"></script>--%>

	<!-- Archon JS =============================-->
	<script src="archon/js/archon.js"></script>
	<script src="archon/js/knobs-custom.js"></script>
	<script src="archon/js/sparkline-custom.js"></script>
	<script src="archon/js/dashboard-custom.js"></script>
    
    <script type="text/javascript">
        var page = {
            hander: "Handler/LoginHandler.ashx?action=",

            logout: function () {
                $.post(page.hander + "logout", {}, function (data) {
                    if (!data.error) {
                        location.href = "Login.aspx";
                    }
                }, "json");
            },
            setiframe: function (page) {
                alert(page);
                $("#main-content iframe").src = page;
            }
        }
    </script>
</body>
</html>
