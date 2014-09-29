<%@ Page Title="" Language="C#" MasterPageFile="~/View/merchant.Master" AutoEventWireup="true" CodeBehind="Add.aspx.cs" Inherits="Backstage.View.Position.Add" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Header" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Content" runat="server">
    <div class="widget-box">
        <div class="widget-title">
            <span class="icon">
                <i class="icon-gift"></i>
            </span>
            <h5>新增包厢</h5>
        </div>
        <div class="widget-content">
            <form action="#" method="get" class="form-horizontal" id="j-pkg-addForm" />
            <div class="control-group">
                <label class="control-label">包厢号</label>
                <div class="controls">
                    <input type="text" id="j-pkg-title" />
                </div>
            </div>

            <div class="control-group">
                <label class="control-label">包厢分类</label>
                <div class="controls">
                    <select id="select-boxType">
                        <%foreach(var type in BoxTypes){ %>
                            <option value="<%=type.Id %>"><%=type.Title %></option>
                        <%} %>
                    </select>
                </div>
            </div>

            <div class="control-group">
                <label class="control-label">包厢图片</label>
                <div class="controls">

                    <a class="btn btn-info" href="javascript:;" id="j-btn-imageUpload"><i class="icon-folder-open icon-white"></i>本地上传</a>
                    <a class="btn btn-success" href="javascript:;" id="j-btn-imageManager"><i class="icon-picture icon-white"></i>素材库选择</a>
                    <span class="help-inline">上传过的图片可以直接从素材库选择</span>
                    <div class="clearfix" style="margin-top: 10px;">
                        <span class="thumbnail pull-left">
                            <img src="http://placehold.it/128x128" alt="" id="j-img-placehold">
                        </span>
                    </div>
                </div>
            </div>

            <div class="control-group">
                <label class="control-label">包厢介绍</label>
                <div class="controls">
                    <textarea name="content" style="height: 400px; visibility: hidden;"></textarea>
                </div>
            </div>
            <div class="form-actions">
                <button type="reset" class="btn"><i class="icon-refresh"></i>清除重置</button>
                <button type="submit" class="btn btn-primary"><i class="icon-ok icon-white"></i>完成保存</button>
            </div>
            </form>
			
        </div>
    </div>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Footer" runat="server">
    <!--页面js-->
    <script src="<%=DomainUrl %>/Script/js/ue.pager.js"></script>

    <script charset="utf-8" src="<%=DomainUrl %>/Script/kindeditor/kindeditor-min.js"></script>
    <script charset="utf-8" src="<%=DomainUrl %>/Script/kindeditor/lang/zh_CN.js"></script>

    <script type="text/javascript">
        var sellerId = '<%=SellerId%>';
        var MPage = {
            init: function () {
                //去掉之前选中打开的项 选中产品列表
                $("#sidebar li").removeClass("active open");
                $("#sidebar .sidebar_pms").addClass("active open").find(".sidebar_pms_add").addClass("active");

                var mpage = this;

                var text_editor,
                    image_editor;

                KindEditor.ready(function (K) {
                    //文本编辑器
                    mpage.text_editor = text_editor = K.create('textarea[name="content"]', {
                        uploadJson: '<%=DomainUrl %>/Handler/FileManager/UploadHandler.ashx?type=112&sellerid=' + sellerId,
                        allowFileManager: true
                    });

                    //图片上传编辑
                    mpage.image_editor = image_editor = K.editor({
                        uploadJson: '<%=DomainUrl %>/Handler/FileManager/UploadHandler.ashx?type=112&sellerid=' + sellerId,
                        fileManagerJson: '<%=DomainUrl %>/Handler/FileManager/FileManagerHandler.ashx?type=0&sellerid=' + sellerId,
                    });


                    //图片上传绑定
                    K('#j-btn-imageManager').click(function () {
                        image_editor.loadPlugin('filemanager', function () {
                            image_editor.plugin.filemanagerDialog({
                                viewType: 'VIEW',
                                dirName: 'image',
                                clickFn: function (url, title) {
                                    K('#j-img-placehold').attr("src", url);
                                    image_editor.hideDialog();
                                }
                            });
                        });
                    });

                    //从资料库选择图片
                    K('#j-btn-imageUpload').click(function () {
                        image_editor.loadPlugin('image', function () {
                            image_editor.plugin.imageDialog({
                                showRemote: false,
                                imageUrl: K('#j-img-placehold').attr("src"),
                                clickFn: function (url, title, width, height, border, align) {
                                    K('#j-img-placehold').attr("src", url);
                                    image_editor.hideDialog();
                                }
                            });
                        });
                    });
                });

                //绑定提交表单
                $("#j-pkg-addForm").bind("submit", function () {

                    var save_data = {
                        box: $.trim($("#j-pkg-title").val()),
                        imgurls: $('#j-img-placehold').attr("src"),
                        description: text_editor.html(),
                        boxType: $('#select-boxType').val()
                    }
                    $.ajax({
                        url: "../../Handler/Backstage/PositionHandler.ashx?action=add&sellerId=" + sellerId,
                        type: "POST",
                        data: save_data,
                        dataType: "json"
                        //context: document.body
                    }).success(function (data) {
                        //$.getJSON("", { p: p, type : type, status : status}， function(json){
                        alert("新增成功！");
                        window.location.href = "/List.aspx?sellerId=" + sellerId;
                    });
                    return false;
                });

                //绑定重置表单
                $("#j-pkg-addForm").bind("reset", function () {
                    $("#j-pkg-title").val('');
                    $('#j-img-placehold').attr("src", 'http://placehold.it/128x128');
                    mpage.text_editor.html('');
                    return false;
                });
            }
        }

        $(function () {
            MPage.init();
        });

        </script>
</asp:Content>
