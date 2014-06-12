<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Backstage.Login" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
    <title>用户登录</title>
    <script src="Script/Util/jquery-latest.pack.js" type="text/javascript"></script>
    <link href="Css/login.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <div id="login">
        <div id="top">
            <div id="top_left">
                <img src="Images/login_03.gif" /></div>
            <div id="top_center">
            </div>
        </div>
        <div id="center">
            <div id="center_left">
            </div>
            <div id="center_middle">
                <div id="user">
                    用 户
                    <input type="text" id="userName" name="textfield" />
                </div>
                <div id="password">
                    密 码
                    <input type="password" id="pwd" name="textfield2" />
                </div>
                <div id="btn">
                    <a href="javascript:void(0);" id="btnlogin" onclick="page.login();">登录</a><a href="javascript:void(0);" onclick="page.clear();">清空</a></div>
            </div>
            <div id="center_right">
            </div>
        </div>
        <div id="down">
            <div id="down_left">
                <div id="inf">
                    <span class="inf_text">版本信息</span> <span class="copyright">管理信息系统 2012 v1.0</span>
                </div>
            </div>
            <div id="down_center">
            </div>
        </div>
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
            $("#btnlogin").unbind("click").html("登陆中");
            var userName = $.trim($("#userName").val());
            if (userName == "") {
                alert("用户名不能为空");
                return;
            }

            if (pwd == "") {
                alert("密码不能为空");
                return;
            }
            var pwd = $.trim($("#pwd").val());

            $.post(page.hander + "login", { userName: userName, pwd: pwd }, function (data) {
                if (!data.error) {
                    var rtn = page.getQueryString(top.location.search, "rtn");
                    if (rtn != null && rtn != "") {
                        location.href = rtn; //跳转到指定页面
                    }
                    location.href = "Index.aspx"; //跳转到首页
                }
                else {
                    alert(data.error);
                    $("#btnlogin").bind("click").html("登陆");
                }
            }, "json");
        },

        clear: function () {
            $("#userName").val("");
            $("#pwd").val("")
        },

        getQueryString: function (url, name) {
            var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
            var r = url.substr(1).match(reg);
            if (r != null) return unescape(r[2]); return null;
        }
    }
</script>
</html>
