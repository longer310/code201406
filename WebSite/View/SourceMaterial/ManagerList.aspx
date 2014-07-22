<%@ Page Title="" Language="C#" MasterPageFile="~/View/Master.Master" AutoEventWireup="true" CodeBehind="ManagerList.aspx.cs" Inherits="WebSite.View.SourceMaterial.ManagerList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Header" runat="server">
    <script type="text/javascript" src="/Script/jquery-bootstrap/jquery.dialog.js"></script>

    <script src="/Script/View/SourceMaterial/managerlist.js" type="text/javascript"></script>



</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Content" runat="server">

    <div style="margin: 0 auto;" class="panel panel-users">
        <div class="panel-heading">
            <h3 class="panel-title">添加素材<span class="pull-right"></span>
                <a title="添加" href="javascript:void(0);" id="clickmymodal" role="button" class="btn btn-primary">
                    <i class="icon-plus-sign red"></i>
                </a>
            </h3>
        </div>
        <div id="managerList"></div>
        <div id="pager" style="margin-top: 10px;"></div>
    </div>
    <div id="source_wrap" style="display: none;">
        <div id="source_form">
            <div class="form-group">
                <label for="logo">素材名称</label>
                <input type="text" class="form-control"
                    id="logo" />
            </div>
            <div class="form-group">
                <label for="logo_ads">素材地址</label>
                <input type="text" class="form-control"
                    id="logo_ads" />
            </div>
            <div class="form-group">
                <label for="remark">备注</label>
                <input type="text" class="form-control"
                    id="remark" />
            </div>
        </div>
    </div>
    <%--数据模板--%>
    <textarea name="template_jst_list" id="template_jst_list" style="display: none" cols="0" rows="0">
    <table width="100%" class="table users-table table-condensed table-hover  ">
        <thead>
        <tr>
			<th width="140px">序号</th>
            <th width="140px">素材名称</th>
            <th width="140px">素材地址</th>
            <th width="140px">备注</th>
        </tr>
        </thead>
        <tbody>
       {for p in list}
        <tr>
        <td>@{page.itemIndex++}</td>
        <td>@{p.Name}</td>
        <td>@{p.Address}</td>
        <td>@{p.Remark}</td>
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
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Footer" runat="server">
</asp:Content>

