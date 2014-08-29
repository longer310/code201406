<%@ Page Title="" Language="C#" MasterPageFile="~/View/DevMaster.Master" AutoEventWireup="true" CodeBehind="PwdEdit.aspx.cs" Inherits="Backstage.View.Dev.UserCenter.PwdEdit" %>
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
                        <li><a href="admin_list.html">管理员列表</a></li>
                        <li class="active"><a href="admin_add.html">添加管理员</a></li>
                        <li><a href="change_pw.html">密码修改</a></li>
                    </ul>
					<form action="#" method="get" class="form-horizontal" id="j-sysytem-login-changepassw_form" />
						<div class="control-group">
							<label class="control-label">登陆账号</label>
							<div class="controls">
								<span class="text-error">czonechan</span>
							</div>
						</div>
						<div class="control-group">
							<label class="control-label">原密码</label>
							<div class="controls">
								<input type="password" id="j-sysytem-login-prepassw" />
							</div>
						</div>
						<div class="control-group">
							<label class="control-label">新密码</label>
							<div class="controls">
								<input type="password" id="j-sysytem-login-newpassw" />
							</div>
						</div>
						<div class="control-group">
							<label class="control-label">确认密码</label>
							<div class="controls">
								<input type="password" id="j-sysytem-login-confirmpassw" />
							</div>
						</div>

						<div class="form-actions">
							<button type="reset" class="btn"><i class="icon-refresh"></i> 清除重置</button>
							<button type="submit" class="btn btn-primary"><i class="icon-ok icon-white"></i> 完成保存</button>
						</div>
					</form>
				</div>
			</div>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Footer" runat="server">
    <!--页面js-->

        <script type="text/javascript">
            var MPage = {
                init: function () {
                    var mpage = this;

                    //绑定提交表单
                    $("#j-sysytem-login-changepassw_form").bind("submit", function () {
                        var save_data = {
                            prepassw: $.trim($("#j-sysytem-login-prepassw").val()),
                            newpassw: $.trim($("#j-sysytem-login-newpassw").val()),
                            confirmpassw: $.trim($("#j-sysytem-login-confirmpassw").val())
                        }
                        if (save_data.newpassw != confirmPassw)
                        {
                            alert("两次密码输入不一致");
                            return;
                        }
                        $.ajax({
                            url: "../../Handler/Backstage/DevSystemHandler.ashx?action=addadmin",
                            type: "POST",
                            data: save_data,
                            dataType: "json"
                            //context: document.body
                        }).success(function (data) {
                            alert("修改成功");
                        }).error(function (data) {
                            alert(data);
                        });
                        return false;
                    });

                    //绑定重置表单
                    $("#j-sysytem-login-changepassw_form").bind("reset", function () {
                        $("#j-sysytem-login-prepassw").val('');
                        $("#j-sysytem-login-newpassw").val('');
                        $("#j-sysytem-login-confirmpassw").val('');
                        return false;
                    });
                }
            }

            $(function () {
                MPage.init();
            });

        </script>

</asp:Content>
