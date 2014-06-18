<%@ Page Language="C#" AutoEventWireup="true" Inherits="Backstage.ManagerList" Codebehind="ManagerList.aspx.cs" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
    <title>管理员管理页面</title>
    <link href="/Css/style.css" type="text/css" rel="stylesheet">
    <link href="/Css/default.css" type="text/css" rel="stylesheet">
    <link rel="stylesheet" href="/Script/jquery-pagination/lib/jquery_pagination/pagination.css" />
   
    <script src="/Script/utility.js" type="text/javascript"></script>
    <script type="text/javascript" src="/Script/jquery-pagination/lib/jquery_pagination/jquery.pagination.js"></script>
    <script type="text/javascript" src="/Script/template/trimpath-template.js"></script>
    <%--<script src="/Script/View/UCenter/ManagerList.js" type="text/javascript"></script>--%>
</head>
<body>
	<div style="margin:0 auto;">
	    <a href="javascript:void(0);" onclick="page.getList();" id="btnlodgin" class="btn btn-default">df</a>
        <div id="managerList"></div>
        <div id="pager" style="margin-top:10px;"></div>
    </div>
<%--数据模板--%>
<textarea name="template_jst_list" id="template_jst_list" style="display: none" cols="0" rows="0">
    <table width="100%" class="niceTab">
        <tr>
        <th width="30px">ID</th><th width="80px">用户名</th><th width="80px">密码</th><th width="80px">管理员级别</th>
        </tr>
       {for p in list}
        <tr>
        <td>@{p.Id}</td>
        <td>@{p.UserName}</td>
        <td>@{p.Pwd}</td>
        <td>@{p.RoleType - 1}</td>
        </tr>
        {forelse}
        <tr><td colspan="6"><div class="info">暂时管理员列表数据</div></td></tr>
        {/for}
    </table>
</textarea>

 <script type="text/javascript">
     var page = {
         url: "Handler/UCenter/DefaultHandler.ashx?action=",
         pageSize: 10,
         pageIndex: 0,
         itemIndex: 0,
         dataType: "json",
         type: "post",

         getList: function () {//得到列表
             if (typeof pageIndex != 'undefined') {
                 page.pageIndex = pageIndex;
             }
             page.itemIndex = 0;
             alert(page.url + "getManagerList");
             $.post(page.url + "getManagerList", { pageSize: page.pageSize, pageIndex: page.pageIndex + 1 }, function (data) {

                 alert(3);
                 page.showData(data);
                 if (page.pageIndex == 0) {
                     page.showPaper(data.count);
                 }
             }, "json");
         }
     }
    </script>
</body>
</html>
