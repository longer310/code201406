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
					<li class="nav-header">Overview</li>
					<li  class="active"><a href="archon/Index.aspx"><i class="icon-dashboard"></i>Dashboard </a></li>
					<li>
						<a class="dropdown" href="#"><i class="icon-tint"></i> UI Features <span class="label">2</span></a>
						<ul>
							<li><a href="archon/buttons.html"><i class="icon-bullhorn"></i> Buttons &amp; Notifications</a></li>
							<li><a href="archon/slidersnprogress.html"><i class="icon-minus"></i>Sliders &amp; Progress </a></li>
						</ul>	
					</li>
					<li><a href="archon/widgets.html"><i class="icon-group"></i>Widgets</a></li>

					<!-- Sidebar header @add class nav-header for sidebar header -->
					<li class="nav-header">Pages</li>
					<li><a href="archon/calendar.html"><i class="icon-calendar"></i>Calendar</a></li>
					<li><a href="archon/gallery.html"><i class="icon-picture"></i>Gallery</a></li>
					<li><a href="archon/login.html"><i class="icon-signin"></i>Login</a></li>
					<li> <!-- Example for second level menu -->
						<a class="dropdown" href="#"><i class="icon-user"></i> Profile <span class="label">2</span></a>
						<ul>
							<li><a href="archon/profile.html"><i class="icon-usre"></i> Model One</a></li>
							<li><a href="archon/profileTwo.html"><i class="icon-usre"></i> Model Two</a></li>
						</ul>	
					</li>
					<li> <!-- Example for second level menu -->
						<a class="dropdown" href="#"><i class="icon-folder-close-alt"></i> Dropdown menu <span class="label">3</span></a>
						<ul>
							<li><a href="archon/#"><i class="icon-hdd"></i> Submenu item</a></li>
							<li><a href="archon/#"><i class="icon-coffee"></i>Submenu item</a></li>
							<li><a href="archon/#"><i class="icon-crop"></i> Submenu item</a></li>
						</ul>	
					</li>

					<!-- Sidebar header @add class nav-header for sidebar header -->
					<li class="nav-header">Components</li>
					<li><a href="archon/tables.html"><i class="icon-table"></i>Tables</a></li>
					<li> <!-- Example for second level menu -->
						<a class="dropdown" href="#"><i class="icon-folder-close-alt"></i> Charts <span class="label">3</span></a>
						<ul>
							<li><a href="archon/nvd.html"><i class="icon-hdd"></i> NVD</a></li>
							<li><a href="archon/flot.html"><i class="icon-coffee"></i>Flot</a></li>
							<li><a href="archon/knobs.html"><i class="icon-coffee"></i>Knobs</a></li>
						</ul>	
					</li>
					<li><a href="archon/typography.html"><i class="icon-text-width"></i>Typography</a></li>
					<li>
						<a class="dropdown" href="forms.html"><i class="icon-list-alt"></i>Forms  <span class="label">4</span></a>
						<ul>
							<li><a href="archon/form-elements.html"><i class="icon-indent-right"></i> Form Elements</a></li>
							<li><a href="archon/forms.html"><i class="icon-indent-left"></i>Forms</a></li>
							<li><a href="archon/form-wizard.html"><i class="icon-coffee"></i>Form wizard</a></li>
							<li><a href="archon/file-uploads.html"><i class="icon-indent-right"></i> File Upload</a></li>
						</ul>	
					</li>
					<li><a href="archon/icons.html"><i class="icon-truck"></i>Icons</a></li>
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
					<!-- First nav user item -->
					<li class="dropdown hidden-xs">
						<a class="dropdown-toggle" data-toggle="dropdown"><i class="icon-envelope-alt"></i></a>
						<ul class="dropdown-menu right inbox">
							<li class="dropdown-menu-title">
								INBOX <span>(25)</span>
							</li>
							<li>
								<img src="archon/images/theme/avatarTwo.png" alt="" class="avatar">
								<div class="message">
									<span class="username">Anusha</span> 
									<span class="mini-details">(6) <i class="icon-paper-clip"></i></span>
									<span class="time pull-right"> 06:58 PM</span>
									<p>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's ... </p>
								</div>
							</li>
							<li>
								<img src="archon/images/theme/avatarFive.png" alt="" class="avatar">
								<div class="message">
									<span class="username">Veeru</span> 
									<span class="mini-details">(2) <i class="icon-paper-clip"></i></span>
									<span class="time pull-right"> 09:58 AM</span>
									<p>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's ... </p>
								</div>
							</li>
							<li>
								<img src="archon/images/theme/avatarSix.png" alt="" class="avatar">
								<div class="message">
									<span class="username">Nag</span> 
									<span class="mini-details">(6) <i class="icon-paper-clip"></i></span>
									<span class="time pull-right">Yesterday</span>
									<p>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's ... </p>
								</div>
							</li>
							<li>
								<img src="archon/images/theme/avatarSeven.png" alt="" class="avatar">
								<div class="message">
									<span class="username">Harish</span> 
									<span class="mini-details"> <i class="icon-picture"></i></span>
									<span class="time pull-right">14/12/2013</span>
									<p>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's ... </p>
								</div>
							</li>
							<li class="dropdown-menu-footer">
								<a href="#">View All Messages</a>
							</li>
						</ul>
					</li><!-- /dropdown -->

					<!-- Second nav user item -->
					<li class="dropdown hidden-xs">
						<a class="dropdown-toggle" data-toggle="dropdown"><i class="icon-bell"></i></a>
						<ul class="dropdown-menu right notifications">
							<li class="dropdown-menu-title">
								Notifications
							</li>
							<li>
								<i class="icon-cog avatar text-success"></i>
								<div class="message">
									<span class="username text-success">New settings activated</span> 
									<span class="time pull-right"> 06:58 PM</span>
								</div>
							</li>
							<li>
								<i class="icon-shopping-cart avatar text-danger"></i>
								<div class="message">
									<span class="username text-danger">You have 2 returns</span> 
									<span class="time pull-right"> 04:29 PM</span>
								</div>
							</li>
							<li>
								<i class="icon-user avatar text-success"></i>
								<div class="message">
									<span class="username text-success">New User registered</span> 
									<span class="time pull-right"> Yesterday</span>
								</div>
							</li>
							<li>
								<i class="icon-comment avatar text-info"></i>
								<div class="message">
									<span class="username text-info">New Comment received</span> 
									<span class="time pull-right"> Yesterday</span>
								</div>
							</li>
							<li>
								<i class="icon-cog avatar text-warning"></i>
								<div class="message">
									<span class="username text-warning">User deleted</span> 
									<span class="time pull-right"> 2 days ago</span>
								</div>
							</li>
							<li>
								<i class="icon-dollar avatar"></i>
								<div class="message">
									<span class="username">Earned 200 points</span> 
									<span class="time pull-right">3 days ago</span>
								</div>
							</li>
							<li>
								<i class="icon-hdd avatar text-danger"></i>
								<div class="message">
									<span class="username text-danger">Memory size exceeded </span> 
									<span class="time pull-right"> 1 week ago</span>
								</div>
							</li>

							<li class="dropdown-menu-footer">
								<a href="#">View All Notifications</a>
							</li>
						</ul>
					</li><!-- / dropdown -->

					<li class="dropdown user-name">
						<a class="dropdown-toggle" data-toggle="dropdown"><img src="archon/images/theme/avatarSeven.png" class="user-avatar" alt="" />Admin</a>
							<ul class="dropdown-menu right inbox user">
								<li class="user-avatar">
									<img src="archon/images/theme/avatarSeven.png" class="user-avatar" alt="" />
									Vijay Kumar
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

		</div><!-- / Content @5 -->

	</div> <!-- Frame -->


	<!-- Load JS here for greater good =============================-->
	<script src="archon/js/jquery-1.8.3.min.js"></script>
	<script src="archon/js/jquery-ui-1.10.3.custom.min.js"></script>
	<script src="archon/js/jquery.ui.touch-punch.min.js"></script>
	<script src="archon/js/bootstrap.min.js"></script>
	<script src="archon/js/bootstrap-select.js"></script>
	<script src="archon/js/bootstrap-switch.js"></script>
	<script src="archon/js/jquery.tagsinput.js"></script>
	<script src="archon/js/jquery.placeholder.js"></script>
	<script src="archon/js/bootstrap-typeahead.js"></script>
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
	<script src="archon/js/nvd3/lib/d3.v3.js"></script>
	<script src="archon/js/nvd3/nv.d3.js"></script>
	<script src="archon/js/nvd3/src/models/legend.js"></script>
	<script src="archon/js/nvd3/src/models/pie.js"></script>
	<script src="archon/js/nvd3/src/models/pieChart.js"></script>
	<script src="archon/js/nvd3/src/utils.js"></script>
	<script src="archon/js/nvd3/sample.nvd3.js"></script>

	<!-- Map and icons on map
	<script src="https://maps.googleapis.com/maps/api/js?v=3.exp&amp;sensor=false"></script>-->
	<script src="archon/js/map-icons.js"></script>

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
            }
        }
    </script>
</body>
</html>
