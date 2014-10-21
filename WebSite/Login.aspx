<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Backstage.Login" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Unicorn Admin</title>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="<%=DomainUrl %>/css/css/bootstrap.min.css" />
    <link rel="stylesheet" href="<%=DomainUrl %>/css/css/bootstrap-responsive.min.css" />
    <link rel="stylesheet" href="<%=DomainUrl %>/css/css/unicorn.main.css" />
    <link rel="stylesheet" href="<%=DomainUrl %>/css/css/unicorn.grey.css" />
    <!--页面样式-->
    <link rel="stylesheet" href="<%=DomainUrl %>/css/css/unicorn.login.css" />
</head>
<body>
    <div id="logo">
        <h1>APP 商户管理系统</h1>
    </div>
    <div id="loginbox">
        <form id="loginform" class="form-vertical" action="get">

            <div class="control-group">
                <div class="controls">
                    <div class="user-input">
                        <input id="txt-username" type="text" placeholder="用户名" />
                    </div>
                </div>
            </div>
            <div class="control-group">
                <div class="controls">
                    <div class="pw-input">
                        <input id="txt-pwd" type="password" placeholder="密码" />
                    </div>
                </div>
            </div>
            <div class="actions clearfix">
                <span class="pull-left"><a href="#" class="flip-link" id="to-recover">找回密码?</a></span>
                <span class="tip-error flip-link" style="display: none;color:red;">请输入正确帐号和密码</span>
                <span class="pull-right">
                    <a href="#" id="login-submit" class="s-btn">登陆</a>
                </span>
            </div>
        </form>

        <form id="recoverform" action="#" class="form-vertical">
            <div class="control-group">
                <div class="controls">
                    <div class="phone-input">
                        <input id="txt-getusername" type="text" placeholder="输入用户名" />
                    </div>
                </div>
            </div>
            <div class="control-group">
                <div class="controls">
                    <a class="btn-g" id="getcode-submit" href="#">手机获取验证码</a>
                </div>
            </div>
            <div class="control-group">
                <div class="controls">
                    <div class="user-input">
                        <input id="txt-code" type="text" placeholder="输入验证码" />
                    </div>
                </div>
            </div>
            <div class="actions clearfix">

                <span class="pull-left"><a href="#" class="flip-link" id="to-login">返回登陆？</a></span>
                <span class="pull-right"><a href="#" class="s-btn" id="to-reset">下一步</a></span>
            </div>
        </form>

        <form id="resetform" action="#" class="form-vertical">
            <div class="control-group">
                <div class="controls">
                    <div class="pw-input">
                        <input type="text" id="txt-newpwd" placeholder="新密码" />
                    </div>
                </div>
            </div>
            <div class="control-group">
                <div class="controls">
                    <div class="pw-input">
                        <input type="text" id="txt-confirmpwd" placeholder="确认新密码" />
                    </div>
                </div>
            </div>
            <div class="actions clearfix">
                <span class="pull-left"><a href="#" class="s-btn" id="back-recover">上一步</a></span>
                <span class="pull-right">
                    <a href="#" id="updatepwd-submit" class="s-btn">提交</a>
                </span>
            </div>
        </form>
    </div>
    <div id="footer"></div>
    <!--公用js-->
    <script type="text/javascript" src="<%=DomainUrl %>/script/js/jquery.min.js"></script>
    <script type="text/javascript" src="<%=DomainUrl %>/script/js/jquery.ui.custom.js"></script>
    <script type="text/javascript" src="<%=DomainUrl %>/script/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="<%=DomainUrl %>/script/js/unicorn.js"></script>
    <script type="text/javascript" src="<%=DomainUrl %>/script/js/jquery.tmpl.min.js"></script>
    <script type="text/javascript" src="<%=DomainUrl %>/script/js/common.js"></script>

    <!--页面js-->
    <script type="text/javascript" src="<%=DomainUrl %>/script/js/unicorn.login.js"></script>
    <script type="text/javascript">

        

    </script>
</body>

</html>
