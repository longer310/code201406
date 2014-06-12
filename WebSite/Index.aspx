<%@ Page Language="C#" AutoEventWireup="true" Inherits="Backstage.Index" Codebehind="index.aspx.cs" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
    <title>暗黑魔王后台管理系统</title>
    <link href="Css/style.css" type="text/css" rel="stylesheet">
    <link href="Css/default.css" type="text/css" rel="stylesheet">
    <script src="Script/Util/jquery-latest.pack.js" type="text/javascript"></script>
    <script src="Script/menu.js" type="text/javascript"></script>
</head>
<body onload="javascript:border_left('left_tab1','left_menu_cnt1');">
    <form id="form1" runat="server">
    <table id="indextablebody" cellpadding="0">
        <thead>
            <tr>
                <th>
                    <div id="logo" title="游戏管理后台">
                    </div>
                </th>
                <th>
                    <a style="color: #16547E">用户 ：<%=CurrentUser.UserName %></a>&nbsp;&nbsp; <a style="color: #16547E">
                        身份 ：<%=RoleName %></a>&nbsp;&nbsp; <a href="javascript:void(0);" target="content3">隐藏工作台</a>&nbsp;&nbsp;|&nbsp;&nbsp;
                    <a href="javascript:void(0);" target="content3" onclick="page.showPage(0);">管理首页</a>&nbsp;&nbsp;|&nbsp;&nbsp;
                    <a href="javascript:void(0);" target="content3">使用帮助</a>
                </th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td class="menu">
                    <ul class="bigbtu">
                        <li id="now01"><a title="安全退出" href="javascript:void(0);" onclick="page.logout();">安全退出</a></li>
                        <li id="now02"><a title="更新缓冲" href="javascript:void(0)" runat="server" id="lnkresetcache" OnServerClick="ResetCache">更新缓冲</a></li>
                    </ul>
                </td>
                <td class="tab">
                    <ul id="tabpage1">
                        <li id="tab1" title="管理首页"><span id="spanTitle">管理首页</span></li>
                    </ul>
                </td>
            </tr>
            <tr>
                <td class="t1">
                    <div id="contents">
                        <table cellpadding="0">
                            <tr class="t1">
                                <td>
                                    <div class="menu_top">
                                    </div>
                                </td>
                            </tr>
                            <tr class="t2">
                                <td>
                                    <div id="menu" class="menu">
                                        <ul class="tabpage2">
                                            <li id="left_tab1" title="操作菜单" onclick="javascript:border_left('left_tab1','left_menu_cnt1');">
                                                <span>系统</span></li>
                                        </ul>
                                        <div id="left_menu_cnt1" class="left_menu_cnt">
                                            <ul id="dleft_tab1">
                                                <li id="now11"><a title="注册统计" href="javascript:void(0);" target="content3" onclick="page.showPage(1);"><span>注册统计</span></a></li>
                                                <li id="now12"><a title="在线数统计" href="javascript:void(0);" target="content3" onclick="page.showPage(2);"><span>在线数统计</span></a></li>
                                                <li id="now13"><a title="消费统计" href="javascript:void(0)" target="content3" onclick="page.showPage(3);"><span>消费统计</span></a></li>
                                                <li id="now14"><a title="充值信息" href="javascript:void(0)" target="content3" onclick="page.showPage(4);"><span>充值信息</span></a></li>
                                                <li id="now17" runat="Server"><a title="参数配置" href="javascript:void(0)" target="content3" onclick="page.showPage(5);"><span>参数配置</span></a></li>
                                                <li id="now18"><a title="公告" href="javascript:void(0)" target="content3" onclick="page.showPage(6);"><span>公告</span></a></li>
                                                <li id="now19"><a title="用户信息" href="javascript:void(0)" target="content3" onclick="page.showPage(7);"><span>用户信息</span></a></li>
                                                <li id="now12"><a title="用户留存率" href="javascript:void(0)" target="content3" onclick="page.showPage(8);"><span>用户留存率</span></a></li>
                                                <li id="now14"><a title="用户消费情况" href="javascript:void(0);" target="content3" onclick="page.showPage(10);"><span>用户消费情况</span></a></li>
                                                <li id="now11"><a title="用户充值统计" href="javascript:void(0);" target="content3" onclick="page.showPage(11);"><span>用户充值统计</span></a></li>
                                                <li id="now11"><a title="服务器钻石情况" href="javascript:void(0);" target="content3" onclick="page.showPage(12);"><span>服务器钻石情况</span></a></li>
                                                <li id="now11"><a title="流失统计" href="javascript:void(0);" target="content3" onclick="page.showPage(14);"><span>流失统计</span></a></li>
                                                <li id="now11"><a title="流失详情" href="javascript:void(0);" target="content3" onclick="page.showPage(15);"><span>流失详情</span></a></li>
                                                <li id="now11"><a title="全服加钱" href="javascript:void(0);" target="content3" onclick="page.showPage(18);"><span>全服加钱</span></a></li>
                                                <li id="now18"><a title="充值活动" href="javascript:void(0)" target="content3" onclick="page.showPage(19);"><span>充值活动</span></a></li>
                                            </ul>
                                        </div>
                                        <div class="clear">
                                        </div>
                                    </div>
                                    <tr class="t3">
                                        <td>
                                            <div class="menu_end">
                                            </div>
                                        </td>
                                    </tr>
                        </table>
                    </div>
                </td>
                <td class="t2">
                    <div id="cnt">
                        <div id="dtab1">
                            <iframe name="content3" id="pageName" src="main.aspx" frameborder="0"></iframe>
                        </div>
                    </div>
                </td>
            </tr>
        </tbody>
    </table>
    <script type="text/javascript">
        var page = {
            hander: "Handler/LoginHandler.ashx?action=",

            logout: function () {
                $.post(page.hander + "logout", {}, function (data) {
                    if (data.key == 1) {
                        location.href = "Login.aspx";
                    }
                }, "json");
            },

            showPage: function (index) {
                var title = "";
                var pageName = "";
                switch (index) {
                    case 0:
                        title = "管理首页";
                        pageName = "Main.aspx";
                        break;
                    case 1:
                        title = "注册统计";
                        pageName = "RegStat.aspx";
                        break;
                    case 2:
                        title = "在线数统计";
                        pageName = "OnlineStat.aspx";
                        break;
                    case 3:
                        title = "消费统计";
                        pageName = "ConsumeStat.aspx";
                        break;
                    case 4:
                        title = "充值信息";
                        pageName = "UserChargeQuery.aspx";
                        break;
                    case 5:
                        title = "参数配置";
                        pageName = "ParamDict.aspx";
                        break;
                    case 6:
                        title = "公告";
                        pageName = "Announcement.aspx";
                        break;
                    case 7:
                        title = "用户信息";
                        pageName = "UserInfoQuery.aspx";
                        break;
                    case 8:
                        title = "用户留存率";
                        pageName = "UserRetentionStat.aspx";
                        break;
                    case 9:
                        title = "媒体礼包";
                        pageName = "MediaPackage.aspx";
                        break;
                    case 10:
                        title = "用户消费情况";
                        pageName = "UserConsumeQuery.aspx";
                        break;
                    case 11:
                        title = "用户充值统计";
                        pageName = "UserChargeStat.aspx";
                        break;
                    case 12:
                        title = "服务器钻石情况";
                        pageName = "ServerMoneyStat.aspx";
                        break;
                    case 13:
                        title = "设备号查询";
                        pageName = "UniqueIdQuery.aspx";
                        break;
                    case 14:
                        title = "流失统计";
                        pageName = "LostStat.aspx";
                        break;
                    case 15:
                        title = "流失详情";
                        pageName = "LostUserStat.aspx";
                        break;
                    case 16:
                        title = "充值渠道统计";
                        pageName = "twstat.aspx";
                        break;
                    case 17:
                        title = "活动案";
                        pageName = "Activity.aspx";
                        break;
                    case 18:
                        title = "全服加钱";
                        pageName = "AllServerTask.aspx";
                        break;
                    case 19:
                        title = "充值活动";
                        pageName = "cActivity.aspx";
                        break;
                    default: break;
                }
                $("#spanTitle").html(title).parent().attr("title", title);
                $("#pageName").attr("src", pageName);
            }
        }
    </script>
    </form>
</body>
</html>
