<%@ Page Title="" Language="C#" MasterPageFile="~/View/DevMaster.Master" AutoEventWireup="true" CodeBehind="SystemInfo.aspx.cs" Inherits="Backstage.View.Dev.System.SystemInfo" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Header" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Content" runat="server">
    <div class="widget-box" >
				<div class="widget-title">
					<span class="icon">
						<i class="icon-cog"></i>
					</span>
					<h5>资料设置</h5>
				</div>
				<div class="widget-content">
					<ul class="nav nav-tabs">
                        <li class="active"><a href="profile.html">基本资料</a></li>
                        <li><a href="profile_service.html">服务协议</a></li>
                        <li><a href="profile_other.html">特别说明</a></li>
                    </ul>
					<form action="#" method="get" class="form-horizontal" id="j-profile-form" />
						<div class="control-group">
							<label class="control-label">企业全称</label>
							<div class="controls">
								<input type="text" id="j-site_name" />
							</div>
						</div>

						<div class="control-group">
							<label class="control-label">后台网站标题</label>
							<div class="controls">
								<input type="text" id="j-site_title" />
							</div>
						</div>

						<div class="control-group">
							<label class="control-label">LOGO</label>
							<div class="controls">
								
								<a class="btn btn-info" href="javascript:;" id="j-btn-imageUpload_logo"><i class="icon-folder-open icon-white"></i> 本地上传</a>
								<a class="btn btn-success" href="javascript:;" id="j-btn-imageManager_logo"><i class="icon-picture icon-white"></i> 素材库选择</a>
								<span class="help-inline">上传过的图片可以直接从素材库选择</span>
								<div class="clearfix" style="margin-top:10px;">
									<span class="thumbnail pull-left">
										<img src="http://placehold.it/128x128" alt="" id="j-site_logo">
									</span>
								</div>
							</div>
						</div>

						<div class="control-group">
							<label class="control-label">地址</label>
							<div class="controls">
								<input type="text" id="j-address" />
							</div>
						</div>


						<div class="control-group">
							<label class="control-label">联系电话</label>
							<div class="controls">
								<input type="text" id="j-phone" />
							</div>
						</div>

						<div class="control-group">
							<label class="control-label">QQ</label>
							<div class="controls">
								<input type="text" id="j-qq" />
							</div>
						</div>

						<div class="control-group">
							<label class="control-label">域名</label>
							<div class="controls">
								<input type="text" id="j-site_url" />
							</div>
						</div>

			            <div class="control-group">
							<label class="control-label">数据库地址</label>
							<div class="controls">
								<input type="text" id="j-db" />
							</div>
						</div>

						<div class="control-group">
							<label class="control-label">备案号</label>
							<div class="controls">
								<input type="text" id="j-record_num" />
							</div>
						</div>

						<div class="control-group">
							<label class="control-label">404错误跳转页</label>
							<div class="controls">
								<input type="text" id="j-error_404" />
							</div>
						</div>

						<div class="control-group">
							<label class="control-label">最大上传文件</label>
							<div class="controls">
								<input type="text" class="input-medium" id="j-max_filesize" /> KB
							</div>
						</div>

						<div class="control-group">
							<label class="control-label">支持的文件类型</label>
							<div class="controls">
								<input type="text" class="input-medium" id="j-allow_ext" />
							</div>
						</div>

						<div class="control-group">
							<label class="control-label">版权信息</label>
							<div class="controls">
								<textarea rows="4" id="j-copyright"></textarea>
							</div>
						</div>

						<div class="control-group">
							<label class="control-label">简介</label>
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

    
        <!--页面js-->
        <script charset="utf-8" src="../public/kindeditor/kindeditor-min.js"></script>
		<script charset="utf-8" src="../public/kindeditor/lang/zh_CN.js"></script>

        <script type="text/javascript">
            var MPage = {
                init: function () {
                    var mpage = this;

                    var text_editor,
        				image_editor;
                    KindEditor.ready(function (K) {
                        //文本编辑器
                        mpage.text_editor = text_editor = K.create('textarea[name="content"]', {
                            uploadJson: '../public/kindeditor/php/upload_json.php',
                            allowFileManager: true
                        });

                        //图片上传编辑
                        mpage.image_editor = image_editor = K.editor({
                            uploadJson: '../public/kindeditor/php/upload_json.php',
                            fileManagerJson: '../public/kindeditor/php/file_manager_json.php'
                        });

                        //图片上传绑定
                        K('#j-btn-imageManager_logo,#j-btn-imageManager_qrcode').click(function () {
                            var $btn = $(this);

                            image_editor.loadPlugin('filemanager', function () {
                                image_editor.plugin.filemanagerDialog({
                                    viewType: 'VIEW',
                                    dirName: 'image',
                                    clickFn: function (url, title) {
                                        $btn.parents(".controls").find(".thumbnail img").attr("src", url);
                                        image_editor.hideDialog();
                                    }
                                });
                            });
                        });

                        //从资料库选择图片
                        K('#j-btn-imageUpload_logo,#j-btn-imageUpload_qrcode').click(function () {
                            var $btn = $(this);
                            image_editor.loadPlugin('image', function () {
                                image_editor.plugin.imageDialog({
                                    showRemote: false,
                                    clickFn: function (url, title, width, height, border, align) {
                                        $btn.parents(".controls").find(".thumbnail img").attr("src", url);
                                        image_editor.hideDialog();
                                    }
                                });
                            });
                        });
                    });


                    //绑定提交表单
                    $("#j-profile-form").bind("submit", function () {
                        var save_data = {
                            logo: $('#j-img-placehold').attr("src"),
                            content: text_editor.html()
                        }

                        console.log(save_data);
                        alert('提交数据')
                        return false;
                    });

                    //绑定重置表单
                    $("#j-profile-form").bind("reset", function () {
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
