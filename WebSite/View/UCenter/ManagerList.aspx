<%@ Page Language="C#" AutoEventWireup="true" Inherits="Backstage.ManagerList" Codebehind="ManagerList.aspx.cs" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
    <meta http-equiv="content-type" content="text/html; charset=gb2312" />
    <title>管理员管理页面</title>
    <link rel="stylesheet" href="../../Script/jquery-pagination/lib/jquery_pagination/pagination.css" />

	<link href="../../archon/bootstrap/css/bootstrap.css" rel="stylesheet">
	<link href="../../archon/bootstrap/css/bootstrap-responsive.css" rel="stylesheet">
	<link href="../../archon/css/archon.css" rel="stylesheet">
	<link href="../../archon/css/custom.css" rel="stylesheet">
   
    <script src="../../archon/js/jquery-1.8.3.min.js"></script>
    <script src="../../Script/utility.js" type="text/javascript"></script>
    <script type="text/javascript" src="../../Script/jquery-pagination/lib/jquery_pagination/jquery.pagination.js"></script>
    <script type="text/javascript" src="../../Script/template/trimpath-template.js"></script>
    <script type="text/javascript" src="../../Script/layer/layer.min.js"></script>
    <script src="../../Script/View/UCenter/ManagerList.js" type="text/javascript"></script>
</head>
<body>
	<div style="margin:0 auto;" class="panel panel-users">
	    <div class="panel-heading">
	        <h3 class="panel-title">添加管理员<span class="pull-right"></span>
                <a title="添加" href="javascript:void(0);" onclick="page.alertBox();" data-target="#manmanager" data-backdrop="false" id="clickmymodal" role="button" class="btn btn-primary" data-toggle="modal"><i class="icon-plus-sign red"></i></a>
		    </h3>
        </div>
        <div id="managerList"></div>
        <div id="pager" style="margin-top:10px;"></div>
    </div>
    <div id="manmanager"  class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button><%--&times;--%>
        <h3 id="myModalLabel">对话框标题</h3>
      </div>
      <div class="modal-body">
        <p>这里是主体内容…</p>
      </div>
      <div class="modal-footer">
        <a class="btn" data-dismiss="modal" aria-hidden="true">关闭</a>
        <a class="btn btn-primary">保存修改</a>
      </div>
    </div>
<%--数据模板--%>
<textarea name="template_jst_list" id="template_jst_list" style="display: none" cols="0" rows="0">
    <table width="100%" class="table users-table table-condensed table-hover  ">
        <thead>
        <tr>
			<th width="140px">序号</th>
            <th width="140px">用户名</th>
            <th width="140px">密码</th>
            <th width="220px">管理员级别</th>
            <th width="140px">操作</th>
        </tr>
        </thead>
        <tbody>
       {for p in list}
        <tr>
        <td>@{page.itemIndex++}</td>
        <td>@{p.UserName}</td>
        <td>@{p.Pwd}</td>
        <td>@{p.RoleType - 1}</td>
        <td>
		   <button type="button" title="删除" class="btn btn-info"><i class="icon-remove-sign"></i></button>
           <button type="button" title="编辑" class="btn btn-info"><i class="icon-edit"></i></button>
        </td>
        </tr>
        {forelse}
        <tr><td colspan="6"><div class="info">暂时无管理员列表数据</div></td></tr>
        {/for}
        </tbody>
    </table>
</textarea>
</body>
</html>
