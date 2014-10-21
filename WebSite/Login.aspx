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
    <!--ҳ����ʽ-->
    <link rel="stylesheet" href="<%=DomainUrl %>/css/css/unicorn.login.css" />
</head>
<body>
    <div id="logo">
        <h1>APP �̻�����ϵͳ</h1>
    </div>
    <div id="loginbox">
        <form id="loginform" class="form-vertical" action="get">

            <div class="control-group">
                <div class="controls">
                    <div class="user-input">
                        <input id="txt-username" type="text" placeholder="�û���" />
                    </div>
                </div>
            </div>
            <div class="control-group">
                <div class="controls">
                    <div class="pw-input">
                        <input id="txt-pwd" type="password" placeholder="����" />
                    </div>
                </div>
            </div>
            <div class="actions clearfix">
                <span class="pull-left"><a href="#" class="flip-link" id="to-recover">�һ�����?</a></span>
                <span class="tip-error flip-link" style="display: none;color:red;">��������ȷ�ʺź�����</span>
                <span class="pull-right">
                    <a href="#" id="login-submit" class="s-btn">��½</a>
                </span>
            </div>
        </form>

        <form id="recoverform" action="#" class="form-vertical">
            <div class="control-group">
                <div class="controls">
                    <div class="phone-input">
                        <input id="txt-getusername" type="text" placeholder="�����û���" />
                    </div>
                </div>
            </div>
            <div class="control-group">
                <div class="controls">
                    <a class="btn-g" id="getcode-submit" href="#">�ֻ���ȡ��֤��</a>
                </div>
            </div>
            <div class="control-group">
                <div class="controls">
                    <div class="user-input">
                        <input id="txt-code" type="text" placeholder="������֤��" />
                    </div>
                </div>
            </div>
            <div class="actions clearfix">

                <span class="pull-left"><a href="#" class="flip-link" id="to-login">���ص�½��</a></span>
                <span class="pull-right"><a href="#" class="s-btn" id="to-reset">��һ��</a></span>
            </div>
        </form>

        <form id="resetform" action="#" class="form-vertical">
            <div class="control-group">
                <div class="controls">
                    <div class="pw-input">
                        <input type="text" id="txt-newpwd" placeholder="������" />
                    </div>
                </div>
            </div>
            <div class="control-group">
                <div class="controls">
                    <div class="pw-input">
                        <input type="text" id="txt-confirmpwd" placeholder="ȷ��������" />
                    </div>
                </div>
            </div>
            <div class="actions clearfix">
                <span class="pull-left"><a href="#" class="s-btn" id="back-recover">��һ��</a></span>
                <span class="pull-right">
                    <a href="#" id="updatepwd-submit" class="s-btn">�ύ</a>
                </span>
            </div>
        </form>
    </div>
    <div id="footer"></div>
    <!--����js-->
    <script type="text/javascript" src="<%=DomainUrl %>/script/js/jquery.min.js"></script>
    <script type="text/javascript" src="<%=DomainUrl %>/script/js/jquery.ui.custom.js"></script>
    <script type="text/javascript" src="<%=DomainUrl %>/script/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="<%=DomainUrl %>/script/js/unicorn.js"></script>
    <script type="text/javascript" src="<%=DomainUrl %>/script/js/jquery.tmpl.min.js"></script>
    <script type="text/javascript" src="<%=DomainUrl %>/script/js/common.js"></script>

    <!--ҳ��js-->
    <script type="text/javascript" src="<%=DomainUrl %>/script/js/unicorn.login.js"></script>
    <script type="text/javascript">

        

    </script>
</body>

</html>
