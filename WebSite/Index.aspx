﻿<%@ Page Language="C#" AutoEventWireup="true" Inherits="Backstage.Index" Codebehind="index.aspx.cs" %>

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
				<a href="Index.aspx" class="logo"><img src="archon/images/logo.png" alt="Archon Admin" /></a>
				<ul class="nav  nav-list">

					<!-- sidebar input search box -->
					<li class="nav-search">
						<div class="form-group">
							<input type="text" class="form-control nav-search" placeholder="Search through site" />
							<span class="input-icon fui-search"></span>
						</div>
					</li>

					<!-- Sidebar header @add class nav-header for sidebar header -->
					<li class="nav-header">Overview</li>
					<li  class="active"><a href="Index.aspx"><i class="icon-dashboard"></i>Dashboard </a></li>
					<li>
						<a class="dropdown" href="#"><i class="icon-tint"></i> UI Features <span class="label">2</span></a>
						<ul>
							<li><a href="buttons.html"><i class="icon-bullhorn"></i> Buttons &amp; Notifications</a></li>
							<li><a href="slidersnprogress.html"><i class="icon-minus"></i>Sliders &amp; Progress </a></li>
						</ul>	
					</li>
					<li><a href="widgets.html"><i class="icon-group"></i>Widgets</a></li>

					<!-- Sidebar header @add class nav-header for sidebar header -->
					<li class="nav-header">Pages</li>
					<li><a href="calendar.html"><i class="icon-calendar"></i>Calendar</a></li>
					<li><a href="gallery.html"><i class="icon-picture"></i>Gallery</a></li>
					<li><a href="login.html"><i class="icon-signin"></i>Login</a></li>
					<li> <!-- Example for second level menu -->
						<a class="dropdown" href="#"><i class="icon-user"></i> Profile <span class="label">2</span></a>
						<ul>
							<li><a href="profile.html"><i class="icon-usre"></i> Model One</a></li>
							<li><a href="profileTwo.html"><i class="icon-usre"></i> Model Two</a></li>
						</ul>	
					</li>
					<li> <!-- Example for second level menu -->
						<a class="dropdown" href="#"><i class="icon-folder-close-alt"></i> Dropdown menu <span class="label">3</span></a>
						<ul>
							<li><a href="#"><i class="icon-hdd"></i> Submenu item</a></li>
							<li><a href="#"><i class="icon-coffee"></i>Submenu item</a></li>
							<li><a href="#"><i class="icon-crop"></i> Submenu item</a></li>
						</ul>	
					</li>

					<!-- Sidebar header @add class nav-header for sidebar header -->
					<li class="nav-header">Components</li>
					<li><a href="tables.html"><i class="icon-table"></i>Tables</a></li>
					<li> <!-- Example for second level menu -->
						<a class="dropdown" href="#"><i class="icon-folder-close-alt"></i> Charts <span class="label">3</span></a>
						<ul>
							<li><a href="nvd.html"><i class="icon-hdd"></i> NVD</a></li>
							<li><a href="flot.html"><i class="icon-coffee"></i>Flot</a></li>
							<li><a href="knobs.html"><i class="icon-coffee"></i>Knobs</a></li>
						</ul>	
					</li>
					<li><a href="typography.html"><i class="icon-text-width"></i>Typography</a></li>
					<li>
						<a class="dropdown" href="forms.html"><i class="icon-list-alt"></i>Forms  <span class="label">4</span></a>
						<ul>
							<li><a href="form-elements.html"><i class="icon-indent-right"></i> Form Elements</a></li>
							<li><a href="forms.html"><i class="icon-indent-left"></i>Forms</a></li>
							<li><a href="form-wizard.html"><i class="icon-coffee"></i>Form wizard</a></li>
							<li><a href="file-uploads.html"><i class="icon-indent-right"></i> File Upload</a></li>
						</ul>	
					</li>
					<li><a href="icons.html"><i class="icon-truck"></i>Icons</a></li>
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
							<li><a href="#">Logout</a></li>
						</ul>
					</li><!-- / dropdown -->				
				</ul><!-- / Top right user menu -->

			</div><!-- / Navbar-->

			<div id="main-content">
				<div class="row">
					<div class="col-mod-12">
						<ul class="breadcrumb">
							<li><a href="Index.aspx">Archon Admin</a></li>
							<li><a href="Index.aspx">Dashboard</a></li>
							<li class="active">Bread Crumb</li>
						</ul>
					</div>
				</div>

				<div class="row">
					<div class="col-mod-12">
						<div class="alert alert-dismissable alert-success alert-dashboard fade in">
							<button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
							<strong>Hellooo!</strong> Its good to see you. Please check all the features.If you feel something is missing you name it, I will add it in next release
						</div>
					</div>
				</div>

				<!-- Graph -->
				<div class="row">
					<div class="col-md-3">
						<div class="web-stats success">
							<div class="pull-left">
								<h5>2344 </h5>
								<span class="description">Unique Views</span>
							</div>
							<span class="pull-right  mini-graph success"></span>
						</div>
					</div>
					<div class="col-md-3">
						<div class="web-stats info">
							<div class="pull-left">
								<h5>$ 2,69,344 </h5>
								<span class="description">Month Sales</span>
							</div>
							<span class=" pull-right   mini-graph info"></span>
						</div>
					</div>
					<div class="col-md-3">
						<div class="web-stats warning">
							<div class="pull-left">
								<h5>2,34,402 </h5>
								<span class="description">Page Views</span>
							</div>
							<span class=" pull-right  mini-graph pie"></span>
						</div>
					</div>
					<div class="col-md-3">
						<div class="web-stats danger">
							<div class="pull-left">
								<h5>2344 </h5>
								<span class="description">Returns</span>
							</div>
							<span class=" pull-right  mini-graph danger"></span>.
						</div>
					</div>
				</div>

				<!-- Most visited and Traffic sources Graph -->
				<div class="row">
					<div class="col-md-12">
						<div class="panel panel-archon main-graph">
							<div class="panel-heading">
								<h3 class="panel-title">Line and Bar Graphs
									<span class="pull-right">
										<a  href="#" class="panel-minimize"><i class="icon-chevron-up"></i></a>
										<a  href="#"  class="panel-settings"><i class="icon-cog"></i></a>
										<a  href="#"  class="panel-close"><i class="icon-remove"></i></a>
									</span>
								</h3>
							</div>
							<div class="panel-body">
								<div id="chart1" class='with-3d-shadow with-transitions'>
									<svg> </svg>
								</div>
							</div>
						</div>
					</div>
				</div>

				<!-- Knobs -->
				<div class="row">
					<div class="col-md-2 col-sm-4">
						<div class="panel panel-knob">
							<div class="panel-heading">
								<h3 class="panel-title">CPU Usage
									<span class="pull-right">
										<a  href="#" class="panel-refresh"><i class="icon-refresh"></i></a>
									</span>
								</h3>
							</div>
							<div class="panel-body">
								<input class="knob" data-width="150" data-fgColor="#222222" data-thickness=.3 value="47">
							</div>
							<div class="panel-footer">
								some description can be here
							</div>
						</div>
					</div>
					<div class="col-md-2 col-sm-4">
						<div class="panel panel-knob">
							<div class="panel-heading">
								<h3 class="panel-title">Memory Used
									<span class="pull-right">
										<a  href="#" class="panel-refresh"><i class="icon-refresh"></i></a>
									</span>
								</h3>
							</div>
							<div class="panel-body">
								<input class="knob" data-width="150" data-fgColor="#222222" data-thickness=.3 value="86">
							</div>
							<div class="panel-footer">
								some description can be here
							</div>
						</div>
					</div>
					<div class="col-md-2 col-sm-4">
						<div class="panel panel-knob">
							<div class="panel-heading">
								<h3 class="panel-title">Server Load
									<span class="pull-right">
										<a  href="#" class="panel-refresh"><i class="icon-refresh"></i></a>
									</span>
								</h3>
							</div>
							<div class="panel-body">
								<input class="knob" data-width="150" data-fgColor="#222222" data-thickness=.3 value="36">
							</div>
							<div class="panel-footer">
								some description can be here
							</div>
						</div>
					</div>
					<div class="col-md-2 col-sm-4">
						<div class="panel panel-knob">
							<div class="panel-heading">
								<h3 class="panel-title">Active Users
									<span class="pull-right">
										<a  href="#" class="panel-refresh"><i class="icon-refresh"></i></a>
									</span>
								</h3>
							</div>
							<div class="panel-body">
								<input class="knob" data-width="150" data-fgColor="#222222" data-thickness=.3 value="98">
							</div>
							<div class="panel-footer">
								some description can be here
							</div>
						</div>
					</div>
					<div class="col-md-2 col-sm-4">
						<div class="panel panel-knob">
							<div class="panel-heading">
								<h3 class="panel-title">Real Time
								</h3>
							</div>
							<div class="panel-body">
								<input class="knob realtime" data-width="150" data-fgColor="#222222" data-thickness=.3 value="17">
							</div>
							<div class="panel-footer realtime-footer">
								some description can be here
							</div>
						</div>
					</div>
					<div class="col-md-2 col-sm-4">
						<div class="panel panel-knob">
							<div class="panel-heading">
								<h3 class="panel-title">Direct
									<span class="pull-right">
										<a  href="#" class="panel-refresh"><i class="icon-refresh"></i></a>
									</span>
								</h3>
							</div>
							<div class="panel-body">
								<input class="knob" data-width="150" data-fgColor="#222222" data-thickness=.3 value="66">
							</div>
							<div class="panel-footer">
								some description can be here
							</div>
						</div>
					</div>
				</div>	<!-- / knobs -->


				<!-- Summary widget -->
				<div class="row">
					<div class="col-md-3">
						<div class="panel panel-summary">
							<div class="panel-heading">
								<h3 class="panel-title">Account Summary
									<span class="pull-right">
										<a  href="#"  class="panel-settings"><i class="icon-cog"></i></a>
									</span>
								</h3>
							</div>
							<div class="panel-body">
								<div class="up pull-left">
									86% <i class="icon-caret-up text-primary"></i>
								</div>
								<div class="down pull-rgiht">
									23% <i class="icon-caret-down text-danger"></i>
								</div>
								<div class="clearfix"></div>
								<div class="statistics">
									<div class="small">Your account balance</div>
									<div class="available">$48,743</div>
									<a href="#" class="report">View Complete report</a>
								</div>
								<div class="category-summary panel-group" id="accordion">
									<!-- First panel -->
									<div class="panel panel-default">
										<div class="panel-heading">
											<a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion" href="#collapseOne">
												<h4 class="panel-title">
													This Week
													<span class="label label-inverse pull-right text-warning">$1200</span>
												</h4>
											</a>
										</div>
										<div id="collapseOne" class="panel-collapse collapse in">
											<div class="panel-body">
												<ul class="list-unstyled">
													<li class="clearfix">
														<p class="pull-left">Income</p>
														<span class="pull-right">$5600</span>
													</li>
													<li class="clearfix">
														<p class="pull-left">Salaries</p>
														<span class="pull-right">$2000</span>
													</li>
													<li class="clearfix">
														<p class="pull-left">Expenditure</p>
														<span class="pull-right ">$3000</span>
													</li>
													<li class="clearfix">
														<p class="pull-left">Extra income</p>
														<span class="pull-right ">$600</span>
													</li>
												</ul>
											</div>
										</div>
									</div><!-- /First panel -->

									<!-- Second panel -->
									<div class="panel panel-default">
										<div class="panel-heading">
											<a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion" href="#collapseTwo">
												<h4 class="panel-title">
													This Month
													<span class="label label-inverse pull-right text-warning">$3400</span>
												</h4>
											</a>
										</div>
										<div id="collapseTwo" class="panel-collapse collapse">
											<div class="panel-body">
												<ul class="list-unstyled">
													<li class="clearfix">
														<p class="pull-left">Income</p>
														<span class="pull-right">$5600</span>
													</li>
													<li class="clearfix">
														<p class="pull-left">Salaries</p>
														<span class="pull-right">$2000</span>
													</li>
													<li class="clearfix">
														<p class="pull-left">Expenditure</p>
														<span class="pull-right ">$3000</span>
													</li>
													<li class="clearfix">
														<p class="pull-left">Extra income</p>
														<span class="pull-right ">$600</span>
													</li>
												</ul>
											</div>
										</div>
									</div><!-- /First panel -->

									<!-- First panel -->
									<div class="panel panel-default">
										<div class="panel-heading">
											<a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion" href="#collapseThree">
												<h4 class="panel-title">
													Last 3 Months
													<span class="label label-inverse pull-right text-warning">$7900</span>
												</h4>
											</a>
										</div>
										<div id="collapseThree" class="panel-collapse collapse">
											<div class="panel-body">
												<ul class="list-unstyled">
													<li class="clearfix">
														<p class="pull-left">Income</p>
														<span class="pull-right">$5600</span>
													</li>
													<li class="clearfix">
														<p class="pull-left">Salaries</p>
														<span class="pull-right">$2000</span>
													</li>
													<li class="clearfix">
														<p class="pull-left">Expenditure</p>
														<span class="pull-right ">$3000</span>
													</li>
													<li class="clearfix">
														<p class="pull-left">Extra income</p>
														<span class="pull-right ">$600</span>
													</li>
												</ul>
											</div>
										</div>
									</div><!-- /First panel -->

								</div><!-- /Panel Group -->
							</div>
						</div>
					</div>
					<!-- /summary widget -->

					<!-- Users widget -->
					<div class="col-md-9">
						<div class="panel panel-users">
							<div class="panel-heading">
								<h3 class="panel-title">Users Widget
									<span class="pull-right">
										<a  href="#" class="panel-minimize"><i class="icon-chevron-up"></i></a>
										<a  href="#"  class="panel-settings"><i class="icon-cog"></i></a>
										<a  href="#"  class="panel-close"><i class="icon-remove"></i></a>
									</span>
								</h3>
							</div>
							<div class="panel-body">
								<table class="table users-table table-condensed table-hover " >
									<thead>
										<tr>
											<th  class="visible-lg">#</th>
											<th >Avatar</th>
											<th  class="visible-lg">First Name</th>
											<th class="visible-lg">Last Name</th>
											<th class="visible-lg">Email</th>
											<th>Username</th>
											<th>&nbsp;</th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td class="visible-lg">1</td>
											<td><img src="archon/images/theme/avatarOne.png" alt=" " class="avatar"></td>
											<td class="visible-lg">John </td>
											<td class="visible-lg">Deo</td>
											<td class="visible-lg">johndeo@example.com</td>
											<td>@johndeo</td>
											<td>
												<button type="button" class="btn btn-info"><i class="icon-envelope"></i></button>
												<button type="button" class="btn btn-info"><i class="icon-eye-open"></i></button>
												<button type="button" class="btn btn-info"><i class="icon-edit"></i></button>
											</td>
										</tr>
										<tr>
											<td class="visible-lg">2</td>
											<td><img src="archon/images/theme/avatarTwo.png" alt=" " class="avatar"></td>
											<td  class="visible-lg">Jane </td>
											<td class="visible-lg">Doe</td>
											<td class="visible-lg">johndeo@example.com</td>
											<td>@johndeo</td>
											<td>
												<button type="button" class="btn btn-info"><i class="icon-envelope"></i></button>
												<button type="button" class="btn btn-info"><i class="icon-eye-open"></i></button>
												<button type="button" class="btn btn-info"><i class="icon-edit"></i></button>
											</td>
										</tr>
										<tr>
											<td class="visible-lg">3</td>
											<td><img src="archon/images/theme/avatarThree.png" alt=" " class="avatar"></td>
											<td  class="visible-lg">Jump </td>
											<td class="visible-lg">Deo</td>
											<td class="visible-lg">johndeo@example.com</td>
											<td>@johndeo</td>
											<td>
												<button type="button" class="btn btn-info"><i class="icon-envelope"></i></button>
												<button type="button" class="btn btn-info"><i class="icon-eye-open"></i></button>
												<button type="button" class="btn btn-info"><i class="icon-edit"></i></button>
											</td>
										</tr>
										<tr>
											<td  class="visible-lg">4</td>
											<td><img src="archon/images/theme/avatarFour.png" alt=" " class="avatar"></td>
											<td  class="visible-lg">Jump </td>
											<td class="visible-lg">Doe</td>
											<td class="visible-lg">johndeo@example.com</td>
											<td>@johndeo</td>
											<td>
												<button type="button" class="btn btn-info"><i class="icon-envelope"></i></button>
												<button type="button" class="btn btn-info"><i class="icon-eye-open"></i></button>
												<button type="button" class="btn btn-info"><i class="icon-edit"></i></button>
											</td>
										</tr>
										<tr>
											<td class="visible-lg">5</td>
											<td><img src="archon/images/theme/avatarOne.png" alt=" " class="avatar"></td>
											<td class="visible-lg">John </td>
											<td class="visible-lg">Deo</td>
											<td class="visible-lg">johndeo@example.com</td>
											<td>@johndeo</td>
											<td>
												<button type="button" class="btn btn-info"><i class="icon-envelope"></i></button>
												<button type="button" class="btn btn-info"><i class="icon-eye-open"></i></button>
												<button type="button" class="btn btn-info"><i class="icon-edit"></i></button>
											</td>
										</tr>
										<tr>
											<td class="visible-lg">6</td>
											<td><img src="archon/images/theme/avatarTwo.png" alt=" " class="avatar"></td>
											<td  class="visible-lg">Jane </td>
											<td class="visible-lg">Doe</td>
											<td class="visible-lg">johndeo@example.com</td>
											<td>@johndeo</td>
											<td>
												<button type="button" class="btn btn-info"><i class="icon-envelope"></i></button>
												<button type="button" class="btn btn-info"><i class="icon-eye-open"></i></button>
												<button type="button" class="btn btn-info"><i class="icon-edit"></i></button>
											</td>
										</tr>
										<tr>
											<td class="visible-lg">7</td>
											<td><img src="archon/images/theme/avatarThree.png" alt=" " class="avatar"></td>
											<td  class="visible-lg">Jump </td>
											<td class="visible-lg">Deo</td>
											<td class="visible-lg">johndeo@example.com</td>
											<td>@johndeo</td>
											<td>
												<button type="button" class="btn btn-info"><i class="icon-envelope"></i></button>
												<button type="button" class="btn btn-info"><i class="icon-eye-open"></i></button>
												<button type="button" class="btn btn-info"><i class="icon-edit"></i></button>
											</td>
										</tr>
										<tr>
											<td  class="visible-lg">8</td>
											<td><img src="archon/images/theme/avatarFour.png" alt=" " class="avatar"></td>
											<td  class="visible-lg">Jump </td>
											<td class="visible-lg">Doe</td>
											<td class="visible-lg">johndeo@example.com</td>
											<td>@johndeo</td>
											<td>
												<button type="button" class="btn btn-info"><i class="icon-envelope"></i></button>
												<button type="button" class="btn btn-info"><i class="icon-eye-open"></i></button>
												<button type="button" class="btn btn-info"><i class="icon-edit"></i></button>
											</td>
										</tr>
										<tr>
											<td class="visible-lg">9</td>
											<td><img src="archon/images/theme/avatarOne.png" alt=" " class="avatar"></td>
											<td class="visible-lg">John </td>
											<td class="visible-lg">Deo</td>
											<td class="visible-lg">johndeo@example.com</td>
											<td>@johndeo</td>
											<td>
												<button type="button" class="btn btn-info"><i class="icon-envelope"></i></button>
												<button type="button" class="btn btn-info"><i class="icon-eye-open"></i></button>
												<button type="button" class="btn btn-info"><i class="icon-edit"></i></button>
											</td>
										</tr>
										<tr>
											<td class="visible-lg">10</td>
											<td><img src="archon/images/theme/avatarTwo.png" alt=" " class="avatar"></td>
											<td  class="visible-lg">Jane </td>
											<td class="visible-lg">Doe</td>
											<td class="visible-lg">johndeo@example.com</td>
											<td>@johndeo</td>
											<td>
												<button type="button" class="btn btn-info"><i class="icon-envelope"></i></button>
												<button type="button" class="btn btn-info"><i class="icon-eye-open"></i></button>
												<button type="button" class="btn btn-info"><i class="icon-edit"></i></button>
											</td>
										</tr>
										<tr>
											<td class="visible-lg">11</td>
											<td><img src="archon/images/theme/avatarThree.png" alt=" " class="avatar"></td>
											<td  class="visible-lg">Jump </td>
											<td class="visible-lg">Deo</td>
											<td class="visible-lg">johndeo@example.com</td>
											<td>@johndeo</td>
											<td>
												<button type="button" class="btn btn-info"><i class="icon-envelope"></i></button>
												<button type="button" class="btn btn-info"><i class="icon-eye-open"></i></button>
												<button type="button" class="btn btn-info"><i class="icon-edit"></i></button>
											</td>
										</tr>
										<tr>
											<td  class="visible-lg">12</td>
											<td><img src="archon/images/theme/avatarFour.png" alt=" " class="avatar"></td>
											<td  class="visible-lg">Jump </td>
											<td class="visible-lg">Doe</td>
											<td class="visible-lg">johndeo@example.com</td>
											<td>@johndeo</td>
											<td>
												<button type="button" class="btn btn-info"><i class="icon-envelope"></i></button>
												<button type="button" class="btn btn-info"><i class="icon-eye-open"></i></button>
												<button type="button" class="btn btn-info"><i class="icon-edit"></i></button>
											</td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
					</div>
				</div>	<!-- / Users widget-->

				<!-- Chat and todo list -->
				<div class="row">
					<!-- Chat Box -->
					<div class="col-md-9">
						<div class="panel panel-archon panel-chat ">
							<div class="panel-heading">
								<h3 class="panel-title">Chat Box
									<span class="pull-right">
										<a  href="#" class="panel-minimize"><i class="icon-chevron-up"></i></a>
										<a  href="#"  class="panel-settings"><i class="icon-cog"></i></a>
										<a  href="#"  class="panel-close"><i class="icon-remove"></i></a>
									</span>
								</h3>
							</div>
							<div class="panel-body">
								<div class="users-column">
									<ul class="list-unstyled">
										<li class="unread">
											<img src="archon/images/theme/avatarOne.png" alt="" class="avatar">
											<span class="username">Anusha</span> 
											<i class="icon-circle text-success"></i>
										</li>
										<li>
											<img src="archon/images/theme/avatarTwo.png" alt="" class="avatar">
											<span class="username">Vijay Kumar</span> 
											<i class="icon-circle text-success"></i>
										</li>
										<li>
											<img src="archon/images/theme/avatarThree.png" alt="" class="avatar">
											<span class="username">Veerendhra</span> 
											<i class="icon-circle text-danger"></i>
										</li >
										<li class=" clearfix">
											<img src="archon/images/theme/avatarFour.png" alt="" class="avatar">
											<span class="username">Srikanth</span> 
											<i class="icon-circle text-success"></i>
										</li>
										<li>
											<img src="archon/images/theme/avatarFive.png" alt="" class="avatar">
											<span class="username">Sanjana</span> 
											<i class="icon-circle text-warning"></i>
										</li>
										<li>
											<img src="archon/images/theme/avatarSix.png" alt="" class="avatar">
											<span class="username">Pravallika</span> 
											<i class="icon-circle text-warning"></i>
										</li>
										<li>
											<img src="archon/images/theme/avatarSevene.png" alt="" class="avatar">
											<span class="username">Akhil</span> 
											<i class="icon-circle text-danger"></i>
										</li>
										<li>
											<img src="archon/images/theme/avatarEight.png" alt="" class="avatar">
											<span class="username">Akash</span> 
											<i class="icon-circle text-danger"></i>
										</li>
										<li>
											<img src="archon/images/theme/avatarThree.png" alt="" class="avatar">
											<span class="username">Veerendhra</span> 
											<i class="icon-circle text-danger"></i>
										</li >
										<li class=" clearfix">
											<img src="archon/images/theme/avatarFour.png" alt="" class="avatar">
											<span class="username">Srikanth</span> 
											<i class="icon-circle text-success"></i>
										</li>
										<li>
											<img src="archon/images/theme/avatarFive.png" alt="" class="avatar">
											<span class="username">Sanjana</span> 
											<i class="icon-circle text-warning"></i>
										</li>
										<li>
											<img src="archon/images/theme/avatarSix.png" alt="" class="avatar">
											<span class="username">Pravallika</span> 
											<i class="icon-circle text-warning"></i>
										</li>
										<li>
											<img src="archon/images/theme/avatarSevene.png" alt="" class="avatar">
											<span class="username">Akhil</span> 
											<i class="icon-circle text-danger"></i>
										</li>
										<li>
											<img src="archon/images/theme/avatarEight.png" alt="" class="avatar">
											<span class="username">Akash</span> 
											<i class="icon-circle text-danger"></i>
										</li>
										<li>
											<img src="archon/images/theme/avatarOne.png" alt="" class="avatar">
											<span class="username">Kumar</span> 
											<i class="icon-circle text-danger"></i>
										</li>
									</ul>
								</div><!-- / Users Column -->
								<div class="message-column">
									<div class="user-block">
										<img src="archon/images/theme/avatarOne.png" alt="" class="avatar">
										<span class="username">Jane Deo
											<i class="icon-circle text-success"></i>
										</span>
									</div><!-- /User Block -->
									<div class="messages">
										<ul class="list-unstyled">
											<li>
												<img src="archon/images/theme/avatarOne.png" alt="" class="avatar">
												<div class="message">
													<span class="username">
														Tupakula kumar
													</span>
													<span class="time pull-right">
														06:58 pm
													</span>
													<p>
														Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's ... 
													</p>
												</div>
											</li>
											<li class="sender">
												<img src="archon/images/theme/avatarTwo.png" alt="" class="avatar">
												<div class="message">
													<span class="username">
														Jane Deo
													</span>
													<span class="time pull-right">
														06:58 pm
													</span>
													<p>
														Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's ... 
													</p>
												</div>
											</li>
											<li>
												<img src="archon/images/theme/avatarOne.png" alt="" class="avatar">
												<div class="message">
													<span class="username">
														Tupakula kumar
													</span>
													<span class="time pull-right">
														06:58 pm
													</span>
													<p>
														Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's ... 
													</p>
												</div>
											</li>
											<li class="sender">
												<img src="archon/images/theme/avatarTwo.png" alt="" class="avatar">
												<div class="message">
													<span class="username">
														Jane Deo
													</span>
													<span class="time pull-right">
														06:58 pm
													</span>
													<p>
														Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's ... 
													</p>
												</div>
											</li>
											<li>
												<img src="archon/images/theme/avatarOne.png" alt="" class="avatar">
												<div class="message">
													<span class="username">
														Tupakula kumar
													</span>
													<span class="time pull-right">
														a minute ago
													</span>
													<p>
														Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's ... 
													</p>
												</div>
											</li>
											<li class="sender">
												<img src="archon/images/theme/avatarTwo.png" alt="" class="avatar">
												<div class="message">
													<span class="username">
														Jane Deo
													</span>
													<span class="time pull-right">
														06:58 pm
													</span>
													<p>
														Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's ... 
													</p>
												</div>
											</li>
										</ul>
									</div>
									<div class="composer">
										<form method="post">
											<div class="input-group">
												<input type="text" class="form-control text-input" placeholder="Please type your message">
												<span class="input-group-btn">
													<button class="btn btn-info message-send" type="button">Send</button>
												</span>
											</div><!-- /input-group -->
										</form>
									</div>
								</div><!-- /Message column -->
							</div><!-- / Panel Body -->
						</div><!-- /Panel -->
					</div><!-- /Chat Box -->

					<!-- Todo list -->
					<div class="col-md-3">
						<div class="panel panel-archon panel-todo">
							<div class="panel-heading">
								<h3 class="panel-title">Todo List 
									<span class="pull-right">
										<a  href="#" class="panel-minimize"><i class="icon-chevron-up"></i></a>
										<a  href="#"  class="panel-settings"><i class="icon-cog"></i></a>
										<a  href="#"  class="panel-close"><i class="icon-remove"></i></a>
									</span>
								</h3>
							</div>
							<div class="panel-body">
								<ul class="list-unstyled todo-list sortable">
									<li>
										<input type="checkbox" value="1" class="finish-task">
										<span class="description">Click and drag to sort</span>
										<span class="time">Tomorrow</span>
									</li>
									<li class="finish">
										<input type="checkbox" value="1" class="finish-task">
										<span class="description">Pick up granny on the airport</span>
										<span class="time">Evening</span>
									</li>
									<li>
										<input type="checkbox" value="1" class="finish-task">
										<span class="description">Feed the dog with milk</span>
										<span class="time">Night</span>
									</li>
									<li>
										<input type="checkbox" value="1" class="finish-task">
										<span class="description">Body workout for 2 hours</span>
										<span class="time">Evening</span>
									</li>
									<li>
										<input type="checkbox" value="1" class="finish-task">
										<span class="description">Meeting with Charlie about his new idea</span>
										<span class="time">Saturday</span>
									</li>
									<li>
										<input type="checkbox" value="1" class="finish-task">
										<span class="description">Watch Cricket match Team A vs Team B</span>
										<span class="time">Morning</span>
									</li>
									<li>
										<input type="checkbox" value="1" class="finish-task">
										<span class="description">Collect the mobile from repair shop</span>
										<span class="time">2 days later</span>
									</li>
									<li>
										<input type="checkbox" value="1" class="finish-task">
										<span class="description">Dinner with my Girl friend tonight</span>
										<span class="time">12/25/2013</span>
									</li>
									<li>
										<input type="checkbox" value="1" class="finish-task">
										<span class="description">Install more plugins </span>
										<span class="time">later</span>
									</li>
									<li>
										<input type="checkbox" value="1" class="finish-task">
										<span class="description">Indentation with 2 spaces</span>
										<span class="time">now</span>
									</li>
									<li>
										<input type="checkbox" value="1" class="finish-task">
										<span class="description">Clean up clode</span>
										<span class="time">Next hour</span>
									</li>
									<li>
										<input type="checkbox" value="1" class="finish-task">
										<span class="description">Call with a customer for resolution</span>
										<span class="time">Afternoon</span>
									</li>
									<li>
										<input type="checkbox" value="1" class="finish-task">
										<span class="description">Visit Doc for dental check up</span>
										<span class="time">when possible</span>
									</li>
									<li>
										<input type="checkbox" value="1" class="finish-task">
										<span class="description">One more todo </span>
										<span class="time">Today</span>
									</li>
									<li>
										<input type="checkbox" value="1" class="finish-task">
										<span class="description">Nothing else for now</span>
										<span class="time">ok</span>
									</li>
								</ul>
							</div>
						</div>
					</div><!-- /Todo list -->
				</div><!-- /Chat and todo list -->

				<!-- Most visited and Traffic sources Graph -->
				<div class="row">
					<div class="col-md-8">
						<div class="panel panel-primary panel-map">
							<div class="panel-heading">
								<h3 class="panel-title">Most Visited
									<span class="pull-right">
										<a  href="#" class="panel-minimize"><i class="icon-chevron-up"></i></a>
										<a  href="#"  class="panel-settings"><i class="icon-cog"></i></a>
										<a  href="#"  class="panel-close"><i class="icon-remove"></i></a>
									</span>
								</h3>
							</div>
							<div class="panel-body">
								<div id="map-canvas" class="graph"></div><!-- /Map holder -->
							</div>
							<div class="panel-footer">
								<p>Some footer text for summary or statistics or buttons </p>
							</div>
						</div>
					</div>

					<div class="col-md-4">
						<div class="panel panel-primary">
							<div class="panel-heading">
								<h3 class="panel-title">Traffic Source 
									<span class="pull-right">
										<a  href="#" class="btn btn-inverse "><i class="icon-cog"></i></a>
									</span>
								</h3>
							</div>
							<div class="panel-body graph realtime-bar">
								<svg> </svg>
							</div>
							<div class="panel-footer">
								<button type="button" class="btn btn-danger btn-block" id="start-stop-button">Stop Live Stream</button>
							</div>
						</div>
					</div>
				</div>	<!-- / Most visited and Traffic sources Graph -->

				<!-- Latest Activities -->
				<div class="row">
					<div class="col-md-6">
						<div class="panel panel-plain latest-activities">
							<div class="panel-heading">
								<h3 class="panel-title">Latest Activities
									<span class="pull-right">
										<a  href="#" class="panel-minimize"><i class="icon-chevron-up"></i></a>
										<a  href="#"  class="panel-settings"><i class="icon-cog"></i></a>
										<a  href="#"  class="panel-close"><i class="icon-remove"></i></a>
									</span>
								</h3>
							</div>
							<div class="panel-body">
								<ul class="list-unstyled">
									<li>
										<img src="archon/images/icons/clocks.svg" class="activity-icon" alt="">
										<p>content goes here for small description of the latest activity  activity ... 
											<span class="time">10/09/2013</span>
											<a href="#" class="pull-right activity-link"><i class=" icon-arrow-right"></i></a>
										</p>
									</li>
									<li>
										<img src="archon/images/icons/cup.svg" class="activity-icon" alt="">
										<p>content goes here for small description of the latest activity  activity ... 
											<span class="time">10/09/2013</span>
											<a href="#" class="pull-right activity-link"><i class=" icon-arrow-right"></i></a>
										</p>
									</li>
									<li>
										<img src="archon/images/icons/dj.svg" class="activity-icon" alt="">
										<p>content goes here for small description of the latest activity  activity ... 
											<span class="time">10/09/2013</span>
											<a href="#" class="pull-right activity-link"><i class=" icon-arrow-right"></i></a>
										</p>
									</li>
									<li>
										<img src="archon/images/icons/flag.svg" class="activity-icon" alt="">
										<p>content goes here for small description of the latest activity  activity ... 
											<span class="time">10/09/2013</span>
											<a href="#" class="pull-right activity-link"><i class=" icon-arrow-right"></i></a>
										</p>
									</li>
									<li>
										<img src="archon/images/icons/fit.svg" class="activity-icon" alt="">
										<p>content goes here for small description of the latest activity  activity ... 
											<span class="time">10/09/2013</span>
											<a href="#" class="pull-right activity-link"><i class=" icon-arrow-right"></i></a>
										</p>
									</li>
									<li>
										<img src="archon/images/icons/clocks.svg" class="activity-icon" alt="">
										<p>content goes here for small description of the latest activity  activity ... 
											<span class="time">10/09/2013</span>
											<a href="#" class="pull-right activity-link"><i class=" icon-arrow-right"></i></a>
										</p>
									</li>
									<li>
										<img src="archon/images/icons/games.svg" class="activity-icon" alt="">
										<p>content goes here for small description of the latest activity  activity ... 
											<span class="time">10/09/2013</span>
											<a href="#" class="pull-right activity-link"><i class=" icon-arrow-right"></i></a>
										</p>
									</li>
									<li>
										<img src="archon/images/icons/google.html" class="activity-icon" alt="">
										<p>content goes here for small description of the latest activity  activity ... 
											<span class="time">10/09/2013</span>
											<a href="#" class="pull-right activity-link"><i class=" icon-arrow-right"></i></a>
										</p>
									</li>
									<li>
										<img src="archon/images/icons/graph.svg" class="activity-icon" alt="">
										<p>content goes here for small description of the latest activity  activity ... 
											<span class="time">10/09/2013</span>
											<a href="#" class="pull-right activity-link"><i class=" icon-arrow-right"></i></a>
										</p>
									</li>
									<li>
										<img src="archon/images/icons/android.svg" class="activity-icon" alt="">
										<p>content goes here for small description of the latest activity  activity ... 
											<span class="time">10/09/2013</span>
											<a href="#" class="pull-right activity-link"><i class=" icon-arrow-right"></i></a>
										</p>
									</li>
								</ul>
							</div>
							<div class="panel-footer">
								Some description here <a href="#" class="pull-right">View All</a>
							</div>
						</div>
					</div><!-- / Latest Activities-->

					<!--  Installed Plugins -->
					<div class="col-md-6">
						<div class="panel panel-plain installed-plugins">
							<div class="panel-heading">
								<h3 class="panel-title">Installed plugins
									<span class="pull-right">
										<a  href="#" class="panel-minimize"><i class="icon-chevron-up"></i></a>
										<a  href="#"  class="panel-settings"><i class="icon-cog"></i></a>
										<a  href="#"  class="panel-close"><i class="icon-remove"></i></a>
									</span>
								</h3>
							</div>
							<div class="panel-body">
								<ul class="list-inline">
									<li class="primary">
										<i class="icon-cog"></i>
										<h5>Settings</h5>
									</li>
									<li class="success">
										<i class="icon-file"></i>
										<h5>Files</h5>
									</li>
									<li class="orange">
										<i class="icon-dropbox"></i>
										<h5>Dropbox</h5>
									</li>
									<li class="blue">
										<i class="icon-android"></i>
										<h5>Android</h5>
									</li>
									<li class="pink">
										<i class="icon-bug"></i>
										<h5>Bug</h5>
									</li>
									<li class="success">
										<i class="icon-linux"></i>
										<h5>Linux</h5>
									</li>
									<li class="thickblue">
										<i class="icon-weibo"></i>
										<h5>Weibo</h5>
									</li>
									<li class="blue">
										<i class="icon-bitbucket"></i>
										<h5>Bit Buck</h5>
									</li>
									<li class="green">
										<i class="icon-flickr"></i>
										<h5>Flickr</h5>
									</li>
									<li class="primary">
										<i class="icon-youtube-sign"></i>
										<h5>Youtube</h5>
									</li>
									<li class="primary">
										<i class="icon-cog"></i>
										<h5>Settings</h5>
									</li>
									<li class="success">
										<i class="icon-file"></i>
										<h5>Files</h5>
									</li>
									<li class="orange">
										<i class="icon-dropbox"></i>
										<h5>Dropbox</h5>
									</li>
									<li class="blue">
										<i class="icon-android"></i>
										<h5>Android</h5>
									</li>
									<li class="pink">
										<i class="icon-bug"></i>
										<h5>Bug</h5>
									</li>
									<li class="success">
										<i class="icon-linux"></i>
										<h5>Linux</h5>
									</li>
									<li class="thickblue">
										<i class="icon-weibo"></i>
										<h5>Weibo</h5>
									</li>
									<li class="blue">
										<i class="icon-bitbucket"></i>
										<h5>Bit Buck</h5>
									</li>
									<li class="green">
										<i class="icon-flickr"></i>
										<h5>Flickr</h5>
									</li>
									<li class="primary">
										<i class="icon-youtube-sign"></i>
										<h5>Youtube</h5>
									</li>
									<li class="primary">
										<i class="icon-cog"></i>
										<h5>Settings</h5>
									</li>
									<li class="success">
										<i class="icon-file"></i>
										<h5>Files</h5>
									</li>
									<li class="orange">
										<i class="icon-dropbox"></i>
										<h5>Dropbox</h5>
									</li>
									<li class="blue">
										<i class="icon-android"></i>
										<h5>Android</h5>
									</li>
									<li class="pink">
										<i class="icon-bug"></i>
										<h5>Bug</h5>
									</li>
									<li class="success">
										<i class="icon-linux"></i>
										<h5>Linux</h5>
									</li>
									<li class="thickblue">
										<i class="icon-weibo"></i>
										<h5>Weibo</h5>
									</li>
									<li class="blue">
										<i class="icon-bitbucket"></i>
										<h5>Bit Buck</h5>
									</li>
									<li class="green">
										<i class="icon-flickr"></i>
										<h5>Flickr</h5>
									</li>
									<li class="primary">
										<i class="icon-youtube-sign"></i>
										<h5>Youtube</h5>
									</li>
								</ul>
							</div>
							<div class="panel-footer">
								Installed apps : <span class="text-info">30</span> <a href="#" class="pull-right">Explore All</a>
							</div>
						</div>
					</div>
				</div>	<!-- / Installed Plugins -->

				<!-- Real time Graph -->
				<div class="row  visible-lg">
					<div class="col-md-12">
						<div class="panel panel-archon">
							<div class="panel-heading">
								<h3 class="panel-title">
									Real Time Visitors
									<span class="pull-right">
										<a  href="#" class="panel-minimize"><i class="icon-chevron-up"></i></a>
										<a  href="#"  class="panel-settings"><i class="icon-cog"></i></a>
										<a  href="#"  class="panel-close"><i class="icon-remove"></i></a>
									</span>
								</h3>
							</div>
							<div class="panel-body">
								<div id="placeholder" class="realtime graph"></div>
							</div>
							<div class="panel-footer">
								<p>Time between updates: <input id="updateInterval" type="text" value="" > milliseconds</p>
							</div>
						</div>
					</div>
				</div>

				<!-- Modal -->
				<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
								<h5 class="modal-title">Panel Settings</h5>
								<span class="small">Some sort of settings with a form</span>
							</div>
							<div class="modal-body">
								<form class="form-horizontal" role="form">
									<div class="form-group">
										<label for="inputEmail1" class="col-lg-2 control-label">Label</label>
										<div class="col-lg-10">
											<input type="email" class="form-control" id="inputEmail1" placeholder="Label">
										</div>
									</div>
									<div class="form-group">
										<label for="inputPassword1" class="col-lg-2 control-label">Second Label</label>
										<div class="col-lg-10">
											<input type="text" class="form-control" id="inputPassword1" placeholder="Label two">
										</div>
									</div>
								</form>
							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
								<button type="button" class="btn btn-primary">Save changes</button>
							</div>
						</div><!-- /.modal-content -->
					</div><!-- /.modal-dialog -->
				</div><!-- /.modal -->

			</div><!-- /Main Content  @7 -->

		</div><!-- / Content @5 -->

		<div class="row footer">
			<div class="col-md-12 text-center">
				© 2013 <a href="http://bootstrapguru.com/">Bootstrap Guru</a>
			</div>
		</div>
	</div> <!-- Frame -->


	<!-- Load JS here for greater good =============================-->
	<script src="js/jquery-1.8.3.min.js"></script>
	<script src="js/jquery-ui-1.10.3.custom.min.js"></script>
	<script src="js/jquery.ui.touch-punch.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<script src="js/bootstrap-select.js"></script>
	<script src="js/bootstrap-switch.js"></script>
	<script src="js/jquery.tagsinput.js"></script>
	<script src="js/jquery.placeholder.js"></script>
	<script src="js/bootstrap-typeahead.js"></script>
	<script src="js/application.js"></script>
	<script src="js/moment.min.js"></script>
	<script src="js/jquery.dataTables.min.js"></script>
	<script src="js/jquery.sortable.js"></script>
	<script type="text/javascript" src="js/jquery.gritter.js"></script>

	<!-- Charts  =============================-->
	<script src="js/charts/jquery.flot.js"></script>
	<script src="js/charts/jquery.flot.resize.js"></script>
	<script src="js/charts/jquery.flot.stack.js"></script>
	<script src="js/charts/jquery.flot.pie.min.js"></script>	
	<script src="js/charts/jquery.sparkline.min.js"></script>	
	<script src="js/jquery.knob.js"></script>


	<!-- NVD3 graphs  =============================-->
	<script src="js/nvd3/lib/d3.v3.js"></script>
	<script src="js/nvd3/nv.d3.js"></script>
	<script src="js/nvd3/src/models/legend.js"></script>
	<script src="js/nvd3/src/models/pie.js"></script>
	<script src="js/nvd3/src/models/pieChart.js"></script>
	<script src="js/nvd3/src/utils.js"></script>
	<script src="js/nvd3/sample.nvd3.js"></script>

	<!-- Map and icons on map-->
	<script src="https://maps.googleapis.com/maps/api/js?v=3.exp&amp;sensor=false"></script>
	<script src="js/map-icons.js"></script>

	<!-- Archon JS =============================-->
	<script src="js/archon.js"></script>
	<script src="js/knobs-custom.js"></script>
	<script src="js/sparkline-custom.js"></script>
	<script src="js/dashboard-custom.js"></script>
</body>
</html>
