﻿<%@ Page Title="" Language="C#" MasterPageFile="~/View/merchant.Master" AutoEventWireup="true" CodeBehind="Add.aspx.cs" Inherits="Backstage.View.Goods.Add" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Header" runat="server">
    <link href="<%=DomainUrl %>/Script/kindeditor/themes/default/default.css" type="text/css" rel="stylesheet">
    <link rel="shortcut icon" href="<%=DomainUrl %>/Css/img/favicon.ico">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Content" runat="server">
    <div class="widget-box">
        <div class="widget-title">
            <span class="icon">
                <i class="icon-gift"></i>
            </span>
            <h5>新增商品</h5>
        </div>
        <div class="widget-content">
            <div action="#" method="post" class="form-horizontal" id="j-goods-addForm" />
            <div class="control-group">
                <label class="control-label">商品名称</label>
                <div class="controls">
                    <input type="text" id="j-goods-title" />
                </div>
            </div>
            <div class="control-group">
                <label class="control-label">推荐和热销</label>
                <div class="controls">
                    <label class="checkbox">
                        <input type="checkbox" id="j-goods-isrecommend">
                        推荐</label>
                    <label class="checkbox">
                        <input type="checkbox" id="j-goods-ishot">
                        热销</label>
                </div>
            </div>

            <div class="control-group">
                <label class="control-label">商品图片</label>
                <div class="controls">

                    <a class="btn btn-info" href="javascript:;" id="j-btn-imageUpload"><i class="icon-folder-open icon-white"></i>本地上传</a>
                    <a class="btn btn-success" href="javascript:;" id="j-btn-imageManager"><i class="icon-picture icon-white"></i>素材库选择</a>
                    <span class="help-inline">上传过的图片可以直接从素材库选择</span>
                    <ul class="thumbnails" id="j-goods-thumbnails" style="display: none; margin-top: 10px;">
                    </ul>
                </div>
            </div>

            <div class="control-group">
                <label class="control-label">现价</label>
                <div class="controls">
                    <input type="text" class="input-small" id="j-goods-price" /><span style="padding: 0 20px;">原价</span><input type="text" class="input-small" id="j-goods-preprice" />
                </div>
            </div>

            <div class="control-group">
                <label class="control-label">标签</label>
                <div class="controls">
                    <ul id="j-goods-tags" class="inline" style="display: none;"></ul>
                    <a href="" class="btn" id="j-btn-addTag"><i class="icon-plus"></i>添加标签</a>
                </div>
            </div>

            <div class="control-group">
                <label class="control-label">所属分类</label>
                <div class="controls">
                    <select id="j-categroy-list">
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
                    <textarea name="content" style="height: 400px; visibility: hidden;"></textarea>
                </div>
            </div>
            <div class="form-actions">
                <button type="reset" class="btn"><i class="icon-refresh"></i>清除重置</button>
                <button type="submit" class="btn btn-primary"><i class="icon-ok icon-white"></i>完成保存</button>
            </div>
        </div>
    </div>
    </div>

    <!--页面js-->
    <script type="text/javascript" src="<%=DomainUrl %>/Script/js/ue.pager.js"></script>
    <script type="text/javascript" src="<%=DomainUrl %>/Script/kindeditor/kindeditor-min.js"></script>
    <script type="text/javascript" src="<%=DomainUrl %>/Script/kindeditor/lang/zh_CN.js"></script>
    <!--产品图片缩略图模版-->
    <script type="text/jquery-tmpl-x" id="j-tmpl-goods-thumbnail">
	{{each(i, v) thumbnails}}
	    <li class="span">
			<span class="thumbnail">
				<img src="${v.url}" style="max-width:45px;min-width:45px;max-height:45px;min-height:45px;"  alt="" class="j-goods-thumbnail">
			</span>
			<div class="clearfix" style="margin-top:5px;">
				<label class="radio pull-left"><input type="radio" name="islogo" class="j-goods-islogo" {{if v.islogo}}checked="checked"{{/if}}> 设为logo</label>
				<a title="删除图片" href="javascript:;" class="pull-right j-btn-delThumbnail"><i class="icon-remove"></i></a>
			</div>
		</li>
	{{/each}}
</script>
    <!--标签输入框模版-->
    <script type="text/jquery-tmpl-x" id="j-tmpl-goods-tag">
    {{each(i, v) tags}}
        <li style="margin-bottom:5px;"><input type="text" class="input-small j-goods-tag" {{if v}}value="${v}"{{/if}} /> <a href="javascript:;" class="icon-remove j-btn-delTag"></a></li>
    {{/each}}
</script>

    <!--分类下拉框模版-->
    <script type="text/jquery-tmpl-x" id="j-tmpl-categroy-listitem">
    {{each(i, v) list}}
        <option value="${v.Id}">${v.Name}</option>
    {{/each}}
</script>

    <script type="text/javascript">
        var MPage = {
            hander: "<%=DomainUrl %>/Handler/Goods/GoodsHandler.ashx?action=",
        init: function () {
            var mpage = this;

            //去掉之前选中打开的项 选中产品列表
            $("#sidebar li").removeClass("active open");
            $("#sidebar .sidebar_goods").addClass("active open").find(".sidebar_goodsadd").addClass("active");

            var text_editor,
        		image_editor;

            KindEditor.ready(function (K) {
                mpage.text_editor = text_editor = K.create('textarea[name="content"]', {
                    uploadJson: '<%=DomainUrl %>/Handler/FileManager/UploadHandler.ashx?type=3',
                    allowFileManager: true
                });

                //图片上传编辑
                mpage.image_editor = image_editor = K.editor({
                    uploadJson: '<%=DomainUrl %>/Handler/FileManager/UploadHandler.ashx?type=3',
                    fileManagerJson: '<%=DomainUrl %>/Handler/FileManager/FileManagerHandler.ashx?type=3',
                });

                //从资料库选择图片
                K('#j-btn-imageManager').click(function () {
                    image_editor.loadPlugin('filemanager', function () {
                        image_editor.plugin.filemanagerDialog({
                            viewType: 'VIEW',
                            dirName: 'image',
                            clickFn: function (url, title) {
                                mpage.addThumbnail([{
                                    url: url,
                                    islogo: 0
                                }]);
                                image_editor.hideDialog();
                            }
                        });
                    });
                });

                //图片上传绑定
                K('#j-btn-imageUpload').click(function () {
                    image_editor.loadPlugin('image', function () {
                        image_editor.plugin.imageDialog({
                            showRemote: false,
                            imageUrl: K('#j-img-placehold').attr("src"),
                            clickFn: function (url, title, width, height, border, align) {
                                mpage.addThumbnail([{
                                    url: url,
                                    islogo: 0
                                }]);
                                image_editor.hideDialog();
                            }
                        });
                    });
                });

                //解析url中的id
                var goods_id = /\?id=(\d+)/.test(document.location.href);
                if (goods_id) {
                    mpage.getGoodsDetail(goods_id);
                } else {
                    //alert("该活动不存在");
                    //window.history.back();
                }
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
                mpage.addTag(['']);
                return false;
            });

            mpage.getCategroyList(1);

            //提交表单
            $("#j-goods-addForm").bind("submit", function () {

                var thumbnails = [],
					tags = [];

                //获取所有的产品图片
                $("#j-goods-thumbnails li").each(function () {
                    var $item = $(this);

                    thumbnails.push({
                        url: $item.find(".j-goods-thumbnail").attr("src"),
                        islogo: $item.find(".j-goods-islogo").attr("checked") ? 1 : 0
                    });
                });

                //获取所有的标签

                $("#j-goods-tags .j-goods-tag").each(function () {
                    var tag = $.trim($(this).val());
                    if (tag != "") {
                        tags.push(tag);
                    }
                });

                console.log(thumbnails, tags);

                //获取产品简介
                alert(text_editor.html());

                //获取所属分类
                alert($("#j-categroy-list").val());
                return false;
            });

            //重置表单
            $("#j-goods-addForm").bind("reset", function () {
                mpage.setGoodsFormData();
                return false;
            });
        },

        getGoodsDetail: function (goods_id) {
            var mpage = this;

            //$.getJSON("", { id: goods_id}， function(json){
            var json = {
                code: 0,
                msg: "",
                result: {
                    title: "活动主题",
                    ishot: 1,
                    isrecommend: 0,
                    thumbnails: [
                        {
                            islogo: 1,
                            url: "/public/kindeditor/attached/image/20140723/20140723161001_48669.jpg"
                        }, {
                            islogo: 0,
                            url: "/public/kindeditor/attached/image/20140723/20140723161001_48669.jpg"
                        }, {
                            islogo: 0,
                            url: "/public/kindeditor/attached/image/20140723/20140723161001_48669.jpg"
                        }, {
                            islogo: 0,
                            url: "/public/kindeditor/attached/image/20140723/20140723161001_48669.jpg"
                        }
                    ],

                    price: 35,
                    preprice: 44,
                    tags: ["标签1", "标签2", "标签3"],
                    cid: 2,//分类id
                    content: "活动简介活动简介"
                }
            }

            mpage.goodsDetailData = json.result;
            mpage.setGoodsFormData();
        },

        setGoodsFormData: function () {
            var mpage = this,
        		detail = mpage.goodsDetailData;

            $("#j-goods-title").val(detail.title);
            $("#j-goods-ishot").removeAttr("checked");
            if (detail.ishot) {
                $("#j-goods-ishot").attr("checked", 'checked');
            }

            $("#j-goods-isrecommend").removeAttr("checked");
            if (detail.isrecommend) {
                $("#j-goods-isrecommend").attr("checked", 'checked');
            }

            $("#j-goods-thumbnails").html("").hide();
            mpage.addThumbnail(detail.thumbnails);

            $("#j-goods-price").val(detail.price);
            $("#j-goods-preprice").val(detail.preprice);

            $("#j-goods-tags").html("").hide();
            mpage.addTag(detail.tags);
            mpage.text_editor.html(detail.content);
            $("#j-categroy-list").val(detail.cid);
        },

        getCategroyList: function () {
            var mpage = this;
            $.post(mpage.hander + "getGoodsCategoriesList", {}, function (data) {
                if (!data.error) {
                    $("#j-categroy-list").html($("#j-tmpl-categroy-listitem").tmpl(data));
                }
            });
        },

        addThumbnail: function (thumbnails) {
            $("#j-goods-thumbnails").append($("#j-tmpl-goods-thumbnail").tmpl({
                thumbnails: thumbnails
            })).show();
        },

        addTag: function (tags) {
            $("#j-goods-tags").append($("#j-tmpl-goods-tag").tmpl({ tags: tags })).show();
        }
    }

    $(function () {
        MPage.init();
    });

</script>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Footer" runat="server">
</asp:Content>


