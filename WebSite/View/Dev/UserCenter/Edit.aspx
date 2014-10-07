<%@ Page Title="" Language="C#" MasterPageFile="~/View/DevMaster.Master" AutoEventWireup="true" CodeBehind="Edit.aspx.cs" Inherits="Backstage.View.Dev.UserCenter.Edit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Header" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Content" runat="server">
    <div class="widget-box">
        <div class="widget-title">
            <span class="icon">
                <i class="icon-cog"></i>
            </span>
            <h5>账户设置</h5>
        </div>
        <div class="widget-content">
            <ul class="nav nav-tabs">
                <li><a href="List.aspx">管理员列表</a></li>
                <li><a href="Add.aspx">添加管理员</a></li>
                <li><a href="PwdEdit.aspx">密码修改</a></li>
            </ul>
            <div method="post" class="form-horizontal" id="j-editform">
                <div class="control-group">
                    <label class="control-label">管理员名称</label>
                    <div class="controls">
                        <input type="text" id="j-name" value="<%=account.NickName %>" />
                    </div>
                </div>

                <div class="control-group">
                    <label class="control-label">管理级别</label>
                    <div class="controls">
                        <select id="j-level-list">
                            <%if (account.RoleType == Backstage.Core.RoleType.SuperManage)
                              { %>
                            <option value="1">超级管理员</option>
                            <option value="2">普通管理员</option>
                            <%}
                              else
                              { %>
                            <option value="2">普通管理员</option>
                            <option value="1">超级管理员</option>
                            <%} %>
                        </select>
                    </div>
                </div>

                <div class="control-group">
                    <label class="control-label">登陆名称</label>
                    <div class="controls">
                        <input type="text" id="j-login_name" value="<%=account.UserName %>" />
                    </div>
                </div>



                <div class="form-actions">
                    <button type="reset" class="btn">清空重填</button>
                    <button type="input" id="save_form" class="btn btn-primary">保存修改</button>
                </div>
            </div>
        </div>

        <div class="widget-footer">
        </div>
    </div>


</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Footer" runat="server">
    <script type="text/javascript">
        var id = '<%=Id%>';
        var MPage = {
            init: function () {
                var mpage = this;


                //解析url中的id
                /\?id=(\d+)/.test(document.location.href);
                var admin_id = RegExp.$1;



                //提交表单
                $("#save_form").bind("click", function () {
                    var save_data = {
                        id:id,
                        nickname: $("#j-name").val(),
                        roletype: $("#j-level-list").val(),
                        username: $("#j-login_name").val()
                    }
                    $.ajax({
                        url: "../../../Handler/Backstage/DevSystemHandler.ashx?action=updateadmin",
                        type: "POST",
                        data: save_data,
                        dataType: "json"
                        //context: document.body
                    }).success(function (data) {
                        alert("修改成功");
                    });
                });
            }
        }

        $(function () {
            MPage.init();
        });

        </script>

</asp:Content>
