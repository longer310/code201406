<%@ Page Title="" Language="C#" MasterPageFile="~/View/merchant.Master" AutoEventWireup="true" CodeBehind="Add.aspx.cs" Inherits="Backstage.View.Goods.Add" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Header" runat="server">
    <link rel="shortcut icon" href="../../Css/img/favicon.ico">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Content" runat="server">
<div class="widget-box" >
	<div class="widget-title">
		<span class="icon">
			<i class="icon-gift"></i>
		</span>
		<h5>新增商品</h5>
	</div>
	<div class="widget-content">
		<form action="#" method="post" class="form-horizontal" id="j-goods-addForm" />
			<div class="control-group">
				<label class="control-label">商品名称</label>
				<div class="controls">
					<input type="text" />
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">推荐和热销</label>
				<div class="controls">
					<label class="checkbox"><input type="checkbox" class="j-isrecommend"> 推荐</label>
					<label class="checkbox"><input type="checkbox" class="j-ishot"> 热销</label>
				</div>
			</div>

			<div class="control-group">
				<label class="control-label">商品图片</label>
				<div class="controls">
								
					<a class="btn btn-info" href="javascript:;" id="j-btn-imageUpload"><i class="icon-folder-open icon-white"></i> 本地上传</a>
					<a class="btn btn-success" href="javascript:;" id="j-btn-imageManager"><i class="icon-picture icon-white"></i> 素材库选择</a>
					<span class="help-inline">上传过的图片可以直接从素材库选择</span>
					<ul class="thumbnails" id="j-goods-thumbnails" style="display:none;margin-top:10px;">
						</ul>
				</div>
			</div>

			<div class="control-group">
				<label class="control-label">现价</label>
				<div class="controls">
					<input type="text" class="input-small" /><span style="padding:0 20px;">原价</span><input type="text" class="input-small" />
				</div>
			</div>

			<div class="control-group">
				<label class="control-label">标签</label>
				<div class="controls">
					<ul id="j-goods-tags" class="inline" style="display:none;"></ul>
					<a href="" class="btn" id="j-btn-addTag"><i class="icon-plus"></i> 添加标签</a>
				</div>
			</div>

			<div class="control-group">
				<label class="control-label">所属分类</label>
				<div class="controls">
					<select id="j-category-list">
						<option>1</option>
						<option>2</option>
						<option>3</option>
						<option>4</option>
						<option>5</option>
					</select>
				</div>
			</div>

			<div class="control-group">
				<label class="control-label">商品简介</label>
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

    <!--页面js-->
    <script type="text/javascript" src="../../Script/js/ue.pager.js"></script>
    <script type="text/javascript" src="../../Script/js/json2.js"></script>
    <!--页面js-->
        <script type="text/javascript" src="../../Script/js/ue.pager.js"></script>
        <script type="text/javascript" charset="utf-8" src="../public/kindeditor/kindeditor-min.js"></script>
		<script type="text/javascript" charset="utf-8" src="../public/kindeditor/lang/zh_CN.js"></script>

		<!--产品图片缩略图模版-->
		<script type="text/jquery-tmpl-x" id="j-tmpl-goods-thumbnail">
        	<li class="span">
				<span class="thumbnail">
					<img src="${thumbnail}" alt="" class="j-thumbnail">
				</span>
				<div class="clearfix" style="margin-top:5px;">
					<label class="radio pull-left"><input type="radio" name="ishot" class="j-islogo"> 设为logo</label>
					<a title="删除图片" href="javascript:;" class="pull-right j-btn-delThumbnail"><i class="icon-remove"></i></a>
				</div>
			</li>
        </script>
        <!--标签输入框模版-->
        <script type="text/jquery-tmpl-x" id="j-tmpl-goods-tag">
        	{{each(i, v) tags}}
        		<li style="margin-bottom:5px;"><input type="text" class="input-small j-tag" /> <a href="javascript:;" class="icon-remove j-btn-delTag"></a></li>
        	{{/each}}
        </script>

        <!--分类下拉框模版-->
        <script type="text/jquery-tmpl-x" id="j-tmpl-category-listitem">
        	{{each(i, v) list}}
        		<option value="${v.id}">${v.title}</option>
        	{{/each}}
        </script>
        <script type="text/javascript">
            var MPage = {
                init: function () {
                    var mpage = this;

                    var text_editor,
        				image_editor;
                    KindEditor.ready(function (K) {
                        //文本编辑器
                        text_editor = K.create('textarea[name="content"]', {
                            uploadJson: '../public/kindeditor/php/upload_json.php',
                            allowFileManager: true
                        });

                        //图片上传编辑
                        image_editor = K.editor({
                            uploadJson: '../public/kindeditor/php/upload_json.php',
                            fileManagerJson: '../public/kindeditor/php/file_manager_json.php'
                        });

                        //图片上传绑定
                        K('#j-btn-imageManager').click(function () {
                            image_editor.loadPlugin('filemanager', function () {
                                image_editor.plugin.filemanagerDialog({
                                    viewType: 'VIEW',
                                    dirName: 'image',
                                    clickFn: function (url, title) {
                                        mpage.addThumbnail(url);
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
                                        mpage.addThumbnail(url);
                                        image_editor.hideDialog();
                                    }
                                });
                            });
                        });
                    });

                    $("#j-goods-thumbnails").delegate(".j-btn-delThumbnail", "click", function () {
                        $(this).parents("li").remove();
                        if ($("#j-goods-thumbnails li").length == 0) {
                            $("#j-goods-thumbnails").hide();
                        }
                        return false;
                    });

                    $("#j-goods-tags").delegate(".j-btn-delTag", "click", function () {
                        $(this).parents("li").remove();
                        if ($("#j-goods-tags li").length == 0) {
                            $("#j-goods-tags").hide();
                        }
                        return false;
                    });

                    $("#j-btn-addTag").bind("click", function () {
                        mpage.addTag(1);
                        return false;
                    });

                    mpage.addTag(2);
                    mpage.getCategoryList(1);

                    //提交表单
                    $("#j-goods-addForm").bind("submit", function () {

                        var thumbnails = [],
							tags = [];

                        //获取所有的产品图片
                        $("#j-goods-thumbnails li").each(function () {
                            var $item = $(this);

                            thumbnails.push({
                                url: $item.find(".j-thumbnail").attr("src"),
                                islogo: $item.find(".j-islogo").attr("checked") ? 1 : 0
                            });
                        });

                        //获取所有的标签

                        $("#j-goods-tags .j-tag").each(function () {
                            var tag = $.trim($(this).val());
                            if (tag != "") {
                                tags.push(tag);
                            }
                        });

                        console.log(thumbnails, tags);

                        //获取产品简介
                        alert(text_editor.html());

                        //获取所属分类
                        alert($("#j-category-list").val());
                        return false;
                    });

                    //重置表单
                    $("#j-goods-addForm").bind("reset", function () {
                        $("#j-goods-thumbnails").html('').hide();
                    });
                },

                getCategoryList: function (p) {
                    var mpage = this;

                    //$.getJSON("", { p: p}， function(json){
                    var json = {
                        code: 0,
                        msg: "",
                        result: {
                            count: 59,
                            list: [
                                {
                                    id: 1,
                                    title: "分类1"
                                },
                                {
                                    id: 2,
                                    title: "分类2"
                                },
                                {
                                    id: 3,
                                    title: "分类3"
                                },
                                {
                                    id: 4,
                                    title: "分类4"
                                }
                            ]
                        }
                    };

                    $("#j-category-list").html($("#j-tmpl-category-listitem").tmpl(json.result));
                    //});
                },

                addThumbnail: function (url) {
                    $("#j-goods-thumbnails").append($("#j-tmpl-goods-thumbnail").tmpl({ thumbnail: url })).show();
                },

                addTag: function (num) {
                    num = num || 1;
                    $("#j-goods-tags").append($("#j-tmpl-goods-tag").tmpl({ tags: new Array(num) })).show();
                }
            }

            $(function () {
                MPage.init();
            });

        </script>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Footer" runat="server">
</asp:Content>


