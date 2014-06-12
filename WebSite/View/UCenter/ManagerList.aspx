<%@ Page Language="C#" AutoEventWireup="true" Inherits="Backstage.ManagerList" Codebehind="ManagerList.aspx.cs" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
    <title>管理员管理页面</title>
    <link href="Css/style.css" type="text/css" rel="stylesheet">
    <link href="Css/default.css" type="text/css" rel="stylesheet">
    <link rel="stylesheet" href="Script/jquery-pagination/lib/jquery_pagination/pagination.css" />
    <script src="Script/Util/jquery-latest.pack.js" type="text/javascript"></script>
    <script src="Script/menu.js" type="text/javascript"></script>
    <script src="Script/utility.js" type="text/javascript"></script>
    <script src="Script/View/UCenter/ManagerList.js" type="text/javascript"></script>
    <script type="text/javascript" src="/Script/jquery-pagination/lib/jquery_pagination/jquery.pagination.js"></script>
    <script type="text/javascript" src="/Script/template/trimpath-template.js"></script>
</head>
<body onload="javascript:border_left('left_tab1','left_menu_cnt1');">
    <form id="form1" runat="server">
        <div style="margin:0 auto;width:960px;">
            <div id="managerList"></div>
            <div id="pager" style="margin-top:10px;"></div>
        </div>
    </form>
</body>
</html>
<%--数据模板--%>
<textarea name="template_jst_list" id="template_jst_list" style="display: none" cols="0" rows="0">
    <table width="100%" class="niceTab">
        <tr>
        <th width="30px">ID</th><th width="80px">名称</th><th width="80px">创建时间</th><th width="80px">维护人</th>
        </tr>
       {for p in list}
        <tr class="{if (page.itemIndex++)%2==0 }odd{/if}">
        <td>@{p.Id}</td>
        <td>@{p.Title}</td>
        <td>@{p.CreateTime.ToDate().Format('yyyy-MM-dd hh:mm:ss')}</td>
        <td>@{p.UserName}</td>
        </tr>
        {forelse}
        <tr><td colspan="6"><div class="info">暂时管理员列表数据</div></td></tr>
        {/for}
    </table>
</textarea>
