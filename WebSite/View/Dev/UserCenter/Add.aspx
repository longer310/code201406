<%@ Page Title="" Language="C#" MasterPageFile="~/View/DevMaster.Master" AutoEventWireup="true" CodeBehind="Add.aspx.cs" Inherits="Backstage.View.Dev.UserCenter.Add" %>

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
                <li class="active"><a href="Add.aspx">添加管理员</a></li>
                <li><a href="PwdEdit.aspx">密码修改</a></li>
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
                            <option value="2">普通管理员</option>
                            <option value="1">超级管理员</option>
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
                    <label class="control-label">密码</label>
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


                //提交表单
                $("#j-addForm").bind("submit", function () {
                    var save_data = {
                        nickname: $("#j-name").val(),
                        roletype: $("#j-level-list").val(),
                        username: $("#j-login_name").val(),
                        pwd: $("#j-password").val()
                    }
                    $.ajax({
                        url: "../../../Handler/Backstage/DevSystemHandler.ashx?action=addadmin",
                        type: "POST",
                        data: save_data,
                        dataType: "json"
                        //context: document.body
                    }).success(function (data) {
                        alert("新增成功");
                        window.location.href = "List.aspx";
                    });
                });


            }
        }

        $(function () {
            MPage.init();
        });

        </script>

</asp:Content>
