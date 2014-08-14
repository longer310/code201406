<%@ Page Title="" Language="C#" MasterPageFile="~/View/merchant.Master" AutoEventWireup="true" CodeBehind="Ad.aspx.cs" Inherits="Backstage.View.Ad.Ad" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Header" runat="server">
    <link rel="shortcut icon" href="<%=DomainUrl %>/Css/img/favicon.ico">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Content" runat="server">
    
		<div class="widget-box" >
			<div class="widget-title">
				<span class="icon">
					<i class="icon-user"></i>
				</span>
				<h5>广告设置</h5>
			</div>
			<div class="widget-content">

				<div class="widget-box" >
					<div class="widget-title">
						<h5>登录页大图广告</h5>
					</div>
					<div class="widget-content">
						<form action="#" method="get" class="form-horizontal" id="j-ad-addForm" />
							<div class="control-group">
								<label class="control-label">广告图片</label>
								<div class="controls">
										
									<a class="btn btn-info j-btn-imageUpload" href="javascript:;"><i class="icon-folder-open icon-white"></i> 本地上传</a>
									<a class="btn btn-success j-btn-imageManager" href="javascript:;"><i class="icon-picture icon-white"></i> 素材库选择</a>
									<span class="help-inline">上传过的图片可以直接从素材库选择</span>
									<div class="clearfix" style="margin-top:10px;">
										<span class="thumbnail pull-left">
											<img src="http://placehold.it/128x128" alt="" class="j-img-placehold">
										</span>
									</div>
								</div>
							</div>

							<div class="control-group">
								<label class="control-label">停留时间：</label>
								<div class="controls">
									<input type="text" class="input-small j-ad-delay" /> 秒
								</div>
							</div>

							<div class="form-actions">
								<button type="submit" class="btn btn-primary"><i class="icon-ok icon-white"></i> 完成保存</button>
							</div>
						</form>
					</div>
				</div>

				<div class="widget-box" >
					<div class="widget-title">
						<h5>wifi设备广告</h5>
					</div>
					<div class="widget-content">
						<form action="#" method="get" class="form-horizontal" id="j-wifi-addForm" />
								
							<div class="control-group">
								<div class="controls">
									<label class="inline">广告个数</label>
									<input type="text" value="2" class="input-small" readonly="readonly" id="j-wifi_count" /> 个
									<a href="javascript:;" title="增加一个" class="icon icon-plus-sign" id="j-add_ad"></a>
									<a href="javascript:;" title="减少一个" class="icon icon-minus-sign" id="j-remove_ad"></a>
									<label class="inline" style="margin-left:20px;">停留时间</label>
									<input type="text" class="input-small" id="j-wifi-delay" value="1" /> 秒
								</div>
							</div>

							<div id="j-wifi-ad">
									
							</div>

							<div class="form-actions">
								<button type="submit" class="btn btn-primary"><i class="icon-ok icon-white"></i> 完成保存</button>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>

    <div id="footer">
        <p>关于淘宝合作伙伴营销中心廉正举报联系客服开放平台诚征英才联系我们网站地图法律声明© 2003-2014 Taobao.com 版权所有</p>
        <p>网络文化经营许可证：文网文[2010]040号|增值电信业务经营许可证：浙B2-20080224-1|信息网络传播视听节目许可证：1109364号 </p>
    </div>

    <!--页面js-->
    <script src="<%=DomainUrl %>/Script/js/ue.pager.js"></script>
    <script type="text/javascript"  charset="utf-8" src="<%=DomainUrl %>/Script/kindeditor/kindeditor-min.js"></script>
    <script type="text/javascript"  charset="utf-8" src="<%=DomainUrl %>/Script/kindeditor/lang/zh_CN.js"></script>

	<script type="text/jquery-tmpl-x" id="j-tmpl-wifi-ad-item">
		{{each(i, v) list}}
			<div style="border:1px solid #cdcdcd; background-color:#efefef;position:relative; margin-bottom:10px;" class="j-wifi-ad_item" data-id="${v.id}">
				<div class="control-group">
					<label class="control-label">广告图片</label>
					<div class="controls">
						<div class="clearfix">
							<span class="thumbnail pull-left" style="margin-right:10px;">
								<img src="${v.avatar}" height="128" width="128" alt="" class="j-img-placehold">
							</span>
							<p><a class="btn btn-info j-btn-imageUpload" href="javascript:;"><i class="icon-folder-open icon-white"></i> 本地上传</a></p>
							<p><a class="btn btn-success j-btn-imageManager" href="javascript:;"><i class="icon-picture icon-white"></i> 素材库选择</a></p>
							<span class="help-inline">上传过的图片可以直接从素材库选择</span>
						</div>
					</div>
				</div>

				<div class="control-group">
					<label class="control-label">跳转至</label>
					<div class="controls">
							<input class="j-wifi-goto" type="text" value="${v.url}">
						</div>
					</div>
				</div>
			</div>
		{{/each}}
	</script>

	<script>
		var MPage = {
		    init: function () {
		        var mpage = this;

		        mpage.initForm();
		    },

		    initForm: function () {
		        var mpage = this;

		        //去掉之前选中打开的项 选中产品列表
		        $("#sidebar li").removeClass("active open");
		        $("#sidebar .sidebar_ad").addClass("active open");

		        var ad_data = {
		            wifi_ads: {
		                delay: 1,
		                list: [
							{
								id: 1,
								avatar: "http://placehold.it/128x128",
								url: "http://www.baidu.com"
							},

							{
								id: 2,
								avatar: "http://placehold.it/128x128",
								url: "http://www.baidu.com"
							},

							{
								id: 3,
								avatar: "http://placehold.it/128x128",
								url: "http://www.baidu.com"
							}
		                ]
		            }
		        }

		        console.log(ad_data.wifi_ads);
		        mpage.addLevel(ad_data.wifi_ads);
		        $("#j-wifi-delay").val(ad_data.wifi_ads.delay);
		        $("#j-wifi_count").val(ad_data.wifi_ads.list.length);
		        mpage.bindForm();
		    },

		    bindForm: function () {
		        var mpage = this;

		        var image_editor;
		        KindEditor.ready(function (K) {

		            //图片上传编辑
		            mpage.image_editor = image_editor = K.editor({
		                uploadJson: '../public/kindeditor/php/upload_json.php',
		                fileManagerJson: '../public/kindeditor/php/file_manager_json.php'
		            });

		            //图片上传绑定
		            K('.j-btn-imageManager').click(function () {
		                var $item = $(this).parents(".controls");

		                image_editor.loadPlugin('filemanager', function () {
		                    image_editor.plugin.filemanagerDialog({
		                        viewType: 'VIEW',
		                        dirName: 'image',
		                        clickFn: function (url, title) {
		                            $item.find('.j-img-placehold').attr("src", url);
		                            image_editor.hideDialog();
		                        }
		                    });
		                });
		            });

		            //从资料库选择图片
		            K('.j-btn-imageUpload').click(function () {
		                var $item = $(this).parents(".controls");

		                image_editor.loadPlugin('image', function () {
		                    image_editor.plugin.imageDialog({
		                        showRemote: false,
		                        clickFn: function (url, title, width, height, border, align) {
		                            $item.find('.j-img-placehold').attr("src", url);
		                            image_editor.hideDialog();
		                        }
		                    });
		                });
		            });
		        });

		        $("#j-add_ad").bind("click", function () {
		            var count = parseInt($("#j-wifi_count").val()) || 0;

		            count++;
		            $("#j-wifi_count").val(count);
		            mpage.addLevel({
		                list: [
        					{
        						avatar: "http://placehold.it/128x128"
        					}
		                ]
		            });
		        });

		        $("#j-remove_ad").bind("click", function () {
		            var count = parseInt($("#j-wifi_count").val()) || 0;
		            count--;
		            if (count < 0) {
		                count = 0;
		            }
		            $("#j-wifi_count").val(count);
		            mpage.removeLevel();
		        });

		        //绑定提交表单
		        $("#j-ad-addForm").bind("submit", function () {

		            alert('提交数据');
		            return false;
		        });
		    },

		    addLevel: function (data) {
		        console.log(data);
		        $("#j-wifi-ad").append($("#j-tmpl-wifi-ad-item").tmpl(data));
		    },

		    removeLevel: function () {
		        $("#j-wifi-ad .j-wifi-ad_item").last().remove();
		    }
		}

		$(function () {
		    MPage.init();
		});

    </script>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Footer" runat="server">
</asp:Content>


