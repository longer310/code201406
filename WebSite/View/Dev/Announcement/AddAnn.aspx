<%@ Page Title="" Language="C#" MasterPageFile="~/View/DevMaster.Master" AutoEventWireup="true" CodeBehind="AddAnn.aspx.cs" Inherits="Backstage.View.Dev.Announcement.AddAnn" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Header" runat="server">
    <link rel="shortcut icon" href="<%=DomainUrl %>/Css/img/favicon.ico">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Content" runat="server">


    <div class="widget-box" >
				<div class="widget-title">
					<span class="icon">
						<i class="icon-bullhorn"></i>
					</span>
					<h5>新增公告</h5>
				</div>
				<div class="widget-content">
					<div action="#" method="get" class="form-horizontal" id="j-addForm">
						<div class="control-group">
							<label class="control-label">公告内容</label>
							<div class="controls">
								<textarea rows="10" id="j-content"></textarea>
							</div>
						</div>

						<div class="form-actions">
							<%--<button type="reset" class="btn">清空重填</button>
							<button type="submit" class="btn btn-primary">保存修改</button>--%>
                            
                <a href="javascript:void(0);" id="reset" class="btn "><i class="icon-ok icon-white"></i>清除重置</a>
                <a href="javascript:void(0);" id="save" class="btn btn-primary"><i class="icon-ok icon-white"></i>确定添加</a>
						</div>
					</div>
				</div>

				<div class="widget-footer">

				</div>
			</div>

    <script type="text/javascript">
        var MPage = {
            hander: "<%=DomainUrl %>/Handler/Platform/AnnouncementHandler.ashx?action=",
            init: function () {
                var mpage = this;

                //去掉之前选中打开的项 选中产品列表
                $("#sidebar li").removeClass("active open");
                $("#sidebar .sidebar_announcement").addClass("active open").find(".sidebar_addann").addClass("active");
                
                //提交表单
                $("#save").bind("click", function () {
                    var content = $("#j-content").val();
                    if (content == "") {
                        Common.tip({ type: "error", content: "公告内容不能为空" });
                        return false;
                    }
                    $.post(mpage.hander + "addAnnouncemment", { content: content }, function (data) {
                        if (!data.error) {
                            Common.tip({ type: "success", content: data.success });
                        } else {
                            Common.tip({ type: "error", content: data.error });
                        }
                    }, "JSON");
                });
            }
        }

        $(function () {
            MPage.init();
        });

        </script>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Footer" runat="server">
</asp:Content>
