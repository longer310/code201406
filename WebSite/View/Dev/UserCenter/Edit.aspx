<%@ Page Title="" Language="C#" MasterPageFile="~/View/DevMaster.Master" AutoEventWireup="true" CodeBehind="Edit.aspx.cs" Inherits="Backstage.View.Dev.UserCenter.Edit" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Header" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Content" runat="server">
    <div class="widget-box" >
				<div class="widget-title">
					<span class="icon">
						<i class="icon-cog"></i>
					</span>
					<h5>账户设置</h5>
				</div>
				<div class="widget-content">
					<ul class="nav nav-tabs">
                        <li class="active"><a href="admin_list.html">管理员列表</a></li>
                        <li><a href="admin_add.html">添加管理员</a></li>
                        <li><a href="change_pw.html">密码修改</a></li>
                    </ul>
					<form action="#" method="get" class="form-horizontal" id="j-addForm">
						<div class="control-group">
							<label class="control-label">管理员名称</label>
							<div class="controls">
								<input type="text" id="j-name" />
							</div>
						</div>

						<div class="control-group">
							<label class="control-label">管理级别</label>
							<div class="controls">
								<select id="j-level-list">
									<option>普通管理员</option>
									<option>超级管理员</option>
								</select>
							</div>
						</div>

						<div class="control-group">
							<label class="control-label">登陆名称</label>
							<div class="controls">
								<input type="text" id="j-login_name" />
							</div>
						</div>

						<div class="control-group">
							<label class="control-label">管理员名称</label>
							<div class="controls">
								<input type="password" id="j-password" />
							</div>
						</div>

						<div class="form-actions">
							<button type="reset" class="btn">清空重填</button>
							<button type="submit" class="btn btn-primary">保存修改</button>
						</div>
					</form>
				</div>

				<div class="widget-footer">

				</div>
			</div>


</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Footer" runat="server">
     <script type="text/javascript">
         var MPage = {
             init: function () {
                 var mpage = this;


                 //解析url中的id
                 /\?id=(\d+)/.test(document.location.href);
                 var admin_id = RegExp.$1;

                 if (admin_id) {
                     mpage.getDetail(admin_id);
                 } else {
                     alert("该商户不存在");
                     window.history.back();
                 }

                 //提交表单
                 $("#j-addForm").bind("submit", function () {
                     var save_data = {
                         name: $("#j-name").val(),
                         level: $("#j-level-list").val(),
                         login_name: $("#j-login_name").val(),
                         password: $("#j-password").val()
                     }

                     return false;
                 });
             },

             getDetail: function (admin_id) {

             }
         }

         $(function () {
             MPage.init();
         });

        </script>

</asp:Content>
