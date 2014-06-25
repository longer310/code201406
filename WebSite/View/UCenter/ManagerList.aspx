<%@ Page Language="C#" AutoEventWireup="true" Inherits="Backstage.ManagerList" Codebehind="ManagerList.aspx.cs" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
    <meta http-equiv="content-type" content="text/html; charset=gb2312" />
    <title>管理员管理页面</title>
    <link rel="stylesheet" href="../../Script/jquery-pagination/lib/jquery_pagination/pagination.css" />

	<link href="../../archon/bootstrap/css/bootstrap.css" rel="stylesheet">
	<link href="../../archon/css/archon.css" rel="stylesheet">
	<link href="../../archon/css/responsive.css" rel="stylesheet">
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
                <a title="添加" href="javascript:void(0);" id="clickmymodal" class="btn btn-primary">
                    <i class="icon-plus-sign red"></i>
                </a>
		    </h3>
        </div>
        <div id="managerList"></div>
        <div id="pager" style="margin-top:10px;"></div>
    </div>
    <div id="alertbody" class="hide">
	    <form class="form-horizontal" style="width: 400px;" role="form">
		    <div style="padding-left: 10px;" class="form-group">
			    <label for="username" class="col-lg-3 control-label">用户名</label>
			    <div class="col-lg-9">
				    <input type="username" class="form-control" id="username" placeholder="输入登录名">
			    </div>
		    </div>
            <div style="padding-left: 10px;" class="form-group">
			    <label for="pwd" class="col-lg-3 control-label">密码</label>
			    <div class="col-lg-9">
				    <input type="pwd" class="form-control" id="pwd" placeholder="输入密码">
			    </div>
		    </div>
		    <div style="padding-left: 10px;" class="form-group">
			    <label for="roletype"  class="col-lg-3 control-label">权限</label>
			    <div class="col-lg-9">
				    <select class="form-control" id="roletype">
					    <option>二级管理员</option>
					    <option>一级管理员</option>
				    </select>
			    </div>
		    </div>
		    <a style="margin-left: 10px;margin-top: 25px;" href="javascript:void(0);" onclick="page.closealert();" class="btn btn-default">取消</a>
            <a style="margin-top: 25px;margin-left: 20px;" href="javascript:void(0);" onclick="page.updatedata()" class="btn btn-primary">保存</a>
	    </form>
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
        <tr class="managerow">
        <td>@{page.itemIndex++}</td>
        <td class="username">@{p.UserName}</td>
        <td class="pwd">@{p.Pwd}</td>
        <td class="roletype">@{p.RoleType - 1}</td>
        <td>
		   <a title="删除" href="javascript:void(0);" onclick="page.deldataalert(@{p.Id});"  class="btn btn-info"><i class="icon-remove-sign"></i></a>
           <a title="编辑" href="javascript:void(0);" onclick="page.updatedataalert(@{p.Id});"  class="btn btn-info"><i class="icon-edit"></i></a>
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
