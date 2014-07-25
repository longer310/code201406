<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Backstage.Login" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="content-type" content="text/html; charset=gb2312" />
    <title>�ҵ�վ��</title>
    <link rel="stylesheet" href="/css/css/bootstrap.min.css" />
    <link rel="stylesheet" href="/css/css/bootstrap-responsive.min.css" />
    <link rel="stylesheet" href="/css/css/unicorn.main.css" />
    <link rel="stylesheet" href="/css/css/unicorn.grey.css" />
    <!--ҳ����ʽ-->
    <link rel="stylesheet" href="/css/css/unicorn.login.css" />
</head>
<body>
    <div id="logo">
        APP �̻�����ϵͳ
    </div>
    <div id="loginbox">
        <form id="loginform" class="form-vertical" action="index.html" />
        <p>�������û���������</p>
        <div class="control-group">
            <div class="controls">
                <div class="input-prepend">
                    <span class="add-on"><i class="icon-user"></i></span>
                    <input type="text" placeholder="�û���" />
                </div>
            </div>
        </div>
        <div class="control-group">
            <div class="controls">
                <div class="input-prepend">
                    <span class="add-on"><i class="icon-lock"></i></span>
                    <input type="password" placeholder="����" />
                </div>
            </div>
        </div>
        <div class="form-actions">
            <span class="pull-left"><a href="#" class="flip-link" id="to-recover">�һ�����?</a></span>
            <span class="pull-right">
                <label class="checkbox inline">
                    <input type="checkbox">
                    ��ס��</label>
                <input type="submit" class="btn btn-inverse" value="��½" />
            </span>
        </div>
        </form>
            <form id="recoverform" action="#" class="form-vertical" />
        <p>��������ע��ʱ��д�������ַ��</p>
        <div class="control-group">
            <div class="controls">
                <div class="input-prepend">
                    <span class="add-on"><i class="icon-envelope"></i></span>
                    <input type="text" placeholder="����" />
                </div>
            </div>
        </div>
        <div class="form-actions">
            <span class="pull-left"><a href="#" class="flip-link" id="to-login">&lt; ���ص�½</a></span>
            <span class="pull-right">
                <input type="submit" class="btn btn-inverse" value="�ύ" /></span>
        </div>
        </form>
    </div>
    <!--����js-->
    <script src="/Script/js/jquery.min.js"></script>
    <script src="/Script/js/jquery.ui.custom.js"></script>
    <script src="/Script/js/bootstrap.min.js"></script>
    <script src="/Script/js/unicorn.js"></script>
    <script src="/Script/js/jquery.tmpl.min.js"></script>
    <script src="/Script/js/common.js"></script>

    <!--ҳ��js-->
    <script src="/Script/js/unicorn.login.js"></script>
</body>

</html>
