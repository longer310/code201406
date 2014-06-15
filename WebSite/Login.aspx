<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Backstage.Login" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="content-type" content="text/html; charset=gb2312" />
    <title>�ҵ�վ��</title>
    <script src="Script/Util/jquery-latest.pack.js" type="text/javascript"></script>
	<script type="text/javascript" src="archon/js/jquery.gritter.js"></script>
    <%--<link href="Css/login.css" rel="stylesheet" type="text/css" />--%>
    
	<title>Archon Admin Template</title>
	<meta name="viewport" content="width=device-width, initial-scale=1.0">

	<!-- Loading Bootstrap -->
	<link href="archon/bootstrap/css/bootstrap.css" rel="stylesheet">

	<!-- Loading Stylesheets -->    
	<link href="archon/css/archon.css" rel="stylesheet">
	<link href="archon/css/responsive.css" rel="stylesheet">
	<link href="archon/css/login.css" rel="stylesheet">
	<!-- Loading Custom Stylesheets -->    
	<link href="archon/css/custom.css" rel="stylesheet">

	<!-- Loading Custom Stylesheets -->    
	<link href="archon/css/custom.css" rel="stylesheet">

	<link rel="shortcut icon" href="archon/images/favicon.ico">
	<link href="archon/css/jquery.gritter.css" rel="stylesheet">
</head>
<body>
    <div class="box-holder row">
		<!-- Title -->
		<h1>Archon</h1><hr>
		<!-- Login Form -->
		<form class="form-horizontal" id="center_middle" role="form">
			<div class="form-group">
				<label for="userName" class="col-lg-4 control-label">�û���</label>
				<div class="col-lg-8">
					<div class="input-group">
						<span class="input-group-addon"><i class="icon-envelope"></i></span>
						<input type="text" class="form-control" id="userName" placeholder="�û���">
					</div>					  
				</div>
			</div>
			<div class="form-group">
				<label for="pwd" class="col-lg-4 control-label">����</label>
				<div class="col-lg-8">
					<div class="input-group">
						<span class="input-group-addon"><i class="icon-lock"></i></span>
						<input type="text" class="form-control" id="pwd" placeholder="����">
					</div>					  
				</div>
			</div>
			<div class="form-group">
				<div class="col-lg-offset-2 col-lg-10">
					<div class="checkbox">
						<label>
							<input type="checkbox"> ��ס��
						</label>
					</div>
				</div>
			</div>
			<div class="form-group">
				<div class="col-lg-offset-2 col-lg-10" id="center_middle">
					<a href="javascript:void(0);" onclick="page.login();" id="btnlogin" class="btn btn-default">��¼</a>
				</div>
			</div>
		</form>
		<hr>
		<!-- Create and forget links -->
		<ul class="list-inline"><li><a href="archon/signup.html">ע�� </a></li>
			<li>&nbsp;&nbsp;</li>
			<li><a href="archon/forgot.html">��������?</a></li>
		</ul><!-- /Create and forget links -->
	</div>
</body>
<script type="text/javascript">
    $(document).ready(function () {
        page.init();
    });
    var page = {
        hander: "Handler/LoginHandler.ashx?action=",

        init: function () {
            $("#center_middle input").bind("keyup", function (event) {
                if (event.keyCode == 13) {
                    $(this).blur();
                    page.login();
                }
            });
        },

        login: function () {
            $("#btnlogin").unbind("click").html("��¼��");
            var userName = $.trim($("#userName").val());
            if (userName == "") {
                //alert("�û�������Ϊ��");
                $.gritter.add({
                    position: 'center', // possibilities: bottom-left, bottom-right, top-left, top-right
                    // (string | mandatory) the heading of the notification
                    title: '��¼ʧ��',
                    // (string | mandatory) the text inside the notification
                    text: '�û�������Ϊ��',
                    // (int | optional) the time you want it to be alive for before fading out
                    time: '2000',
                    // (string | optional) the class name you want to apply to that specific message
                    class_name: 'warning'
                });
                $("#btnlogin").html("��¼");
                return;
            }

            var pwd = $.trim($("#pwd").val());
            if (pwd == "") {
                //alert("���벻��Ϊ��");
                $.gritter.add({
                    position: 'center', // possibilities: bottom-left, bottom-right, top-left, top-right
                    // (string | mandatory) the heading of the notification
                    title: '��¼ʧ��',
                    // (string | mandatory) the text inside the notification
                    text: '���벻��Ϊ��',
                    // (int | optional) the time you want it to be alive for before fading out
                    time: '2000',
                    // (string | optional) the class name you want to apply to that specific message
                    class_name: 'warning'
                });
                $("#btnlogin").html("��¼");
                return;
            }

            $.post(page.hander + "login", { userName: userName, pwd: pwd }, function (data) {
                if (!data.error) {
                    var rtn = page.getQueryString(top.location.search, "rtn");
                    if (rtn != null && rtn != "") {
                        location.href = rtn; //��ת��ָ��ҳ��
                    }
                    location.href = "Index.aspx"; //��ת����ҳ
                }
                else {
                    //alert(data.error);
                    $.gritter.add({
                        position: 'center', // possibilities: bottom-left, bottom-right, top-left, top-right
                        // (string | mandatory) the heading of the notification
                        title: '��¼ʧ��',
                        // (string | mandatory) the text inside the notification
                        text: data.error,
                        // (int | optional) the time you want it to be alive for before fading out
                        time: '2000',
                        // (string | optional) the class name you want to apply to that specific message
                        class_name: 'warning'
                    });
                    $("#userName").val("");
                    $("#pwd").val("");
                    $("#btnlogin").bind("click").html("��½");
                }
            }, "json");
        },

        clear: function () {
            $("#userName").val("");
            $("#pwd").val("");
        },

        getQueryString: function (url, name) {
            var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
            var r = url.substr(1).match(reg);
            if (r != null) return unescape(r[2]); return null;
        }
    }
</script>
</html>
