<%@ Page Title="" Language="C#" MasterPageFile="~/View/Master.Master" AutoEventWireup="true" CodeBehind="ManagerList.aspx.cs" Inherits="WebSite.View.SourceMaterial.ManagerList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Header" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Content" runat="server">
    <div class="widget-box">
        <div class="widget-title">
            <span class="icon">
                <i class="icon-gift"></i>
            </span>
            <h5>活动列表</h5>
            <div class="buttons">
                <a href="#" class="btn btn-primary btn-mini" id="j-btn-selectAll">全选</a>
                <a href="#" class="btn btn-danger btn-mini" id="j-btn-delSelected">删除</a>
            </div>
        </div>
        <div class="widget-content nopadding">
            <div class="list-2col">
                <ul class="list-in" id="j-list">
                </ul>
            </div>
        </div>

        <div class="widget-footer">
            <div class="pagination alternate" id="j-pagination">
                <ul class="page-main">
                    <li class="disabled"><a href="#">首页</a></li>
                    <li class="disabled"><a href="#">上一页</a></li>
                    <li class="active">
                        <a href="#">1</a>
                    </li>
                    <li><a href="#">2</a></li>
                    <li><a href="#">3</a></li>
                    <li><a href="#">4</a></li>
                    <li><a href="#">下一页</a></li>
                    <li><a href="#">末页</a></li>
                    <li class="page-info"><b class="text-info">1</b>/8页 共<b class="text-info">18</b>条记录</li>
                </ul>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Footer" runat="server">
    <script type="text/javascript" src="/Script/jquery-bootstrap/jquery.dialog.js"></script>
    <%--<script src="/Script/View/SourceMaterial/managerlist.js" type="text/javascript"></script>--%>
</asp:Content>

