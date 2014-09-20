<%@ Page Title="" Language="C#" MasterPageFile="~/View/merchant.Master" AutoEventWireup="true" CodeBehind="SellerPwdEdit.aspx.cs" Inherits="Backstage.View.System.SellerPwdEdit" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Header" runat="server">
    <link href="../public/kindeditor/themes/default/default.css" type="text/css" rel="stylesheet">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Content" runat="server">
    <div class="widget-box" >
				<div class="widget-title">
					<span class="icon">
						<i class="icon-cog"></i>
					</span>
					<h5>登陆设置</h5>
				</div>
				<div class="widget-content">
					<form action="#" method="get" class="form-horizontal" id="j-sysytem-login-changepassw_form" />
						<div class="control-group">
							<label class="control-label">登陆账号</label>
							<div class="controls">
								<span class="text-error"><%=_UserName %></span>
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
        <script src="../public/js/ue.pager.js"></script>

        <script charset="utf-8" src="../public/kindeditor/kindeditor-min.js"></script>
		<script charset="utf-8" src="../public/kindeditor/lang/zh_CN.js"></script>

        <script type="text/javascript">
            var sellerId = '<%=SellerId%>';
            var MPage = {
                init: function () {
                    var mpage = this;

                    //绑定提交表单
                    $("#j-sysytem-login-changepassw_form").bind("submit", function () {
                        var save_data = {
                            oldpwd: $.trim($("#j-sysytem-login-prepassw").val()),
                            newpwd: $.trim($("#j-sysytem-login-newpassw").val()),
                            confirmpassw: $.trim($("#j-sysytem-login-confirmpassw").val())
                        }
                        if (save_data.newpwd != save_data.confirmpassw)
                        {
                            alert("两次密码输入不一致");
                        }
                        $.ajax({
                            url: "../../Handler/Backstage/SystemHandler.ashx?action=sellerinfo&sellerid=" + sellerId,
                            data: save_data,
                            type: "POST",
                            dataType: "json"
                            //context: document.body
                        }).success(function (data) {
                            alert(data.msg);
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
