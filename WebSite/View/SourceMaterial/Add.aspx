<%@ Page Title="" Language="C#" MasterPageFile="~/View/merchant.Master" AutoEventWireup="true" CodeBehind="Add.aspx.cs" Inherits="Backstage.View.SourceMaterial.Add" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Header" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Content" runat="server">
    <div class="widget-box">
        <div class="widget-title">
            <span class="icon">
                <i class="icon-picture"></i>
            </span>
            <h5>新增图片墙</h5>
        </div>
        <div class="widget-content">
            <form action="#" method="get" class="form-horizontal" id="j-image-addForm" />
            <div class="control-group">
                <label class="control-label">名称</label>
                <div class="controls">
                    <input type="text" id="j-image-title" />
                </div>
            </div>

            <div class="control-group">
                <label class="control-label">活动图片</label>
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
                <label class="control-label">内容</label>
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
    <script src="../../script//js/ue.pager.js"></script>

    <script charset="utf-8" src="../../script/kindeditor/kindeditor-min.js"></script>
    <script charset="utf-8" src="../../script/kindeditor/lang/zh_CN.js"></script>

    <!--图片缩略图模版-->
    <script type="text/jquery-tmpl-x" id="j-tmpl-image-thumbnail">
            {{each(i, v) thumbnails}}
	        	<li class="span">
					<span class="thumbnail">
						<img src="${v.url}" alt="" class="j-image-thumbnail">
					</span>
					<div class="clearfix" style="margin-top:5px;">
						<label class="radio pull-left"><input type="radio" name="islogo" class="j-image-islogo" {{if v.islogo}}checked="checked"{{/if}}> 设为logo</label>
						<a title="删除图片" href="javascript:;" class="pull-right j-btn-delThumbnail"><i class="icon-remove"></i></a>
					</div>
				</li>
			{{/each}}
        </script>

    <script type="text/javascript">
        var sellerId = '<%=SellerId%>';
        var MPage = {
            init: function () {
                var mpage = this;

                var text_editor,
                    image_editor;

                KindEditor.ready(function (K) {
                    //文本编辑器
                    mpage.text_editor = text_editor = K.create('textarea[name="content"]', {
                        uploadJson: '<%=DomainUrl %>/Handler/FileManager/UploadHandler.ashx?type=101&sellerid=' + sellerId,
                        allowFileManager: true
                    });

                    //图片上传编辑
                    mpage.image_editor = image_editor = K.editor({
                        uploadJson: '<%=DomainUrl %>/Handler/FileManager/UploadHandler.ashx?type=101&sellerid=' + sellerId,
                        fileManagerJson: '<%=DomainUrl %>/Handler/FileManager/FileManagerHandler.ashx?type=101&sellerid=' + sellerId,
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


                $("#j-image-thumbnails").delegate(".j-btn-delThumbnail", "click", function () {
                    $(this).parents("li").remove();
                    if ($("#j-image-thumbnails li").length == 0) {
                        $("#j-image-thumbnails").hide();
                    }
                    return false;
                });

                //绑定提交表单
                $("#j-image-addForm").bind("submit", function () {

                    var save_data = {
                        title: $.trim($("#j-image-title").val()),
                        thumbnail: $('#j-img-placehold').attr("src"),
                        content: text_editor.html()
                    }

                    $.ajax({
                        url: "../../Handler/Backstage/SourceMaterialHandler.ashx?action=add&sellerid=" + sellerId,
                        data: save_data,
                        type: "POST",
                        dataType: "json"
                        //context: document.body
                    }).success(function (data) {
                        alert("添加成功");
                        window.setTimeout(function () {
                            window.location.reload();
                        }, 2000);
                    });
                    return false;
                });

                //绑定重置表单
                $("#j-image-addForm").bind("reset", function () {
                    $("#j-image-title").val('');
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
