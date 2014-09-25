<%@ Page Title="" Language="C#" MasterPageFile="~/View/merchant.Master" AutoEventWireup="true" CodeBehind="Edit.aspx.cs" Inherits="Backstage.View.SourceMaterial.Edit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Header" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Content" runat="server">
    			<div class="widget-box" >
				<div class="widget-title">
					<span class="icon">
						<i class="icon-picture"></i>
					</span>
					<h5>修改图片墙</h5>
				</div>
				<div class="widget-content">
					<form action="#" method="get" class="form-horizontal" id="j-image-editForm" />
						<div class="control-group">
							<label class="control-label">名称</label>
							<div class="controls">
								<input type="text" id="j-image-title" />
							</div>
						</div>

						<div class="control-group">
							<label class="control-label">活动图片</label>
							<div class="controls">
								
								<a class="btn btn-info" href="javascript:;" id="j-btn-imageUpload"><i class="icon-folder-open icon-white"></i> 本地上传</a>
								<a class="btn btn-success" href="javascript:;" id="j-btn-imageManager"><i class="icon-picture icon-white"></i> 素材库选择</a>
								<span class="help-inline">上传过的图片可以直接从素材库选择</span>
								<div class="clearfix" style="margin-top:10px;">
									<span class="thumbnail pull-left">
										<img src="http://placehold.it/128x128" alt="" id="j-img-placehold">
									</span>
								</div>
							</div>
						</div>

						<div class="control-group">
							<label class="control-label">内容</label>
							<div class="controls">
								<textarea name="content" style="height:400px;visibility:hidden;"></textarea>
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
    <script src="../../script/js/ue.pager.js"></script>

    <script charset="utf-8" src="../../script/kindeditor/kindeditor-min.js"></script>
    <script charset="utf-8" src="../../script/kindeditor/lang/zh_CN.js"></script>

    <script type="text/javascript">
        var sellerId = '<%=SellerId%>';
        var image_id = '<%=Id%>';
        var MPage = {
            init: function () {
                var mpage = this;

                var text_editor,
                    image_editor;

                KindEditor.ready(function (K) {
                    mpage.text_editor = text_editor = K.create('textarea[name="content"]', {
                        uploadJson: '../../Handler/FileManager/UploadHandler.ashx?type=101&sellerid=' + sellerId,
                        allowFileManager: true
                    });

                    //图片上传编辑
                    image_editor = image_editor = K.editor({
                        uploadJson: '../../Handler/FileManager/UploadHandler.ashx?type=101&sellerid=' + sellerId,
                        fileManagerJson: '../../Handler/FileManager/FileManagerHandler.ashx?type=101&sellerid=' + sellerId,
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


                    //解析url中的id
                    //var image_id = /\?id=(\d+)/.exec(document.location.href);
                    //if (image_id) {
                    mpage.getImageDetail();

                });
                //绑定重置表单
                $("#j-image-editForm").bind("reset", function () {
                    mpage.setEditFormData();
                    return false;
                });

                //绑定提交表单
                $("#j-image-editForm").bind("submit", function () {
                    if (mpage.detailData) {
                        var save_data = {
                            title: $.trim($("#j-image-title").val()),
                            thumbnail: $('#j-img-placehold').attr("src"),
                            content: text_editor.html()

                        }
                        //console.log(save_data);
                        $.ajax({
                            url: "../../Handler/Backstage/SourceMaterialHandler.ashx?action=update&id=" + image_id,
                            data: save_data,
                            type: "POST",
                            dataType: "json"
                            //context: document.body
                        }).success(function (data) {
                            alert('更新成功');
                            //return false;
                        });
                    }
                });



                
            },

            getImageDetail: function () {
                var mpage = this;

                //$.getJSON("", { id: image_id}， function(json){
                var json = {
                    code: 0,
                    msg: "",
                    result: {
                        title: "活动主题",
                        thumbnail: "/public/kindeditor/attached/image/20140723/20140723161001_48669.jpg",
                        content: "活动简介活动简介"
                    }
                }
                $.ajax({
                    url: "../../Handler/Backstage/SourceMaterialHandler.ashx?action=getitem&pid=" + image_id,
                    type: "GET",
                    dataType: "json"
                    //context: document.body
                }).success(function (data) {
                    //console.log(data.data.description);
                    json.result.title = data.data.title;
                    json.result.thumbnail = data.data.url;
                    json.result.content = data.data.description;
                    mpage.detailData = json.result;
                    mpage.setEditFormData();
                });

                //});
            },

            setEditFormData: function () {
                var mpage = this,
                    detail = mpage.detailData;

                $("#j-image-title").val(detail.title);
                $("#j-image-thumbnails").html("").hide();
                $('#j-img-placehold').attr("src", detail.thumbnail);
                mpage.text_editor.html(detail.content);
            }
        }

        $(function () {
            MPage.init();
        });

        </script>
</asp:Content>
