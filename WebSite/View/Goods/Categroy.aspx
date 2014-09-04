<%@ Page Title="" Language="C#" MasterPageFile="~/View/merchant.Master" AutoEventWireup="true" CodeBehind="Categroy.aspx.cs" Inherits="Backstage.View.Goods.Categroy" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Header" runat="server">
    <link href="<%=DomainUrl %>/Script/kindeditor/themes/default/default.css" type="text/css" rel="stylesheet">
    <link rel="stylesheet" href="<%=DomainUrl %>//Css/css/colorpicker.css" />
    <link rel="shortcut icon" href="<%=DomainUrl %>/Css/img/favicon.ico">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Content" runat="server">
    <div class="widget-box">
        <div class="widget-title">
            <span class="icon">
                <i class="icon-gift"></i>
            </span>
            <h5>添加分类</h5>
        </div>
        <div class="widget-content">
            <div action="#" method="post" class="form-horizontal" id="j-categroy-addForm" />
            <div class="control-group">
                <label class="control-label">分类名称</label>
                <div class="controls">
                    <input type="text" id="j-categroy-title" />
                </div>
            </div>
            
			<div class="control-group">
				<label class="control-label">分类背景色</label>
				<div class="controls">
					<input type="text" data-color="#000000" value="#000000" id="j-categroy-color" class="colorpicker input-small" />
					<span style="background:#000000;width:30px;height:30px; display:inline-block; vertical-align:top;" id="j-categroy-color-preview"></span>
				</div>
			</div>
            <div class="control-group">
                <label class="control-label">分类图片</label>
                <div class="controls">
                    <a class="btn btn-info" href="javascript:;" id="j-btn-imageUpload"><i class="icon-folder-open icon-white"></i>本地上传</a>
                    <a class="btn btn-success" href="javascript:;" id="j-btn-imageManager"><i class="icon-picture icon-white"></i>素材库选择</a>
                    <span class="help-inline">上传过的图片可以直接从素材库选择</span>
                    <div class="clearfix" style="margin-top: 10px;">
                        <span class="thumbnail pull-left">
                            <img style="max-width: 128px; min-width: 128px; max-height: 128px; min-height: 128px;" src="http://placehold.it/128x128" alt="" id="j-img-placehold">
                        </span>
                    </div>
                </div>
            </div>

            <div class="form-actions">
                <a href="javascript:void(0);" id="reset" class="btn"><i class="icon-refresh"></i>清除重置</a>
                <a href="javascript:void(0);" id="save" class="btn btn-primary"><i class="icon-ok icon-white"></i>完成保存</a>
            </div>
        </div>
    </div>
    </div><%--不能删除--%>
    <div class="widget-box">
        <div class="widget-title">
            <span class="icon">
                <i class="icon-gift"></i>
            </span>
            <h5>分类列表</h5>
            <div class="buttons">
                <a href="javascript:void(0);" class="btn btn-primary btn-mini" id="j-btn-saveAll"><i class="icon-ok icon-white"></i>保存分类列表</a>
                <a href="javascript:void(0);" class="btn btn-danger btn-mini" id="j-btn-delSelected"><i class="icon-remove icon-white"></i>删除</a>
            </div>
        </div>
        <div class="widget-content">
            <table class="table table-bordered table-striped with-check">
                <thead>
                    <tr>
                        <th>
                            <input type="checkbox" id="j-btn-selectAll" name="title-table-checkbox" /></th>
                        <th>序号</th>
                        <th>分类图片</th>
                        <th>名称</th>
						<th>色块</th>
                        <th>商品数量</th>
                        <th>操作</th>
                    </tr>
                </thead>
                <tbody id="j-categroy-list">
                </tbody>
            </table>
        </div>
    </div>

    <!--页面js-->
    <script type="text/javascript" src="<%=DomainUrl %>/Script/js/ue.pager.js"></script>
    <script type="text/javascript" src="<%=DomainUrl %>/Script/kindeditor/kindeditor-min.js"></script>
    <script type="text/javascript" src="<%=DomainUrl %>/Script/kindeditor/lang/zh_CN.js"></script>
    <script src="<%=DomainUrl %>/Script/js/bootstrap-colorpicker.js"></script>

    <script type="text/jquery-tmpl-x" id="j-tmpl-goods-listitem">
    {{if list.length > 0}}
        {{each(i, v) list}}
	        <tr data-cid="${v.Id}">
			    <td><input type="checkbox" class="j-select" /></td>
			    <td style="width:90px;">
				    <a class="btn btn-mini {{if i == 0}}disabled{{/if}} j-categroy-up" href="javascript:;"><i class="icon icon-arrow-up"></i></a>
				    <span class="j-categroy-index">${v.Index}</span>
				    <a class="btn btn-mini {{if i == list.length - 1}}disabled{{/if}} j-categroy-down" href="javascript:;"><i class="icon icon-arrow-down"></i></a>
			    </td>
			    <td style="width:280px;">
                    <img src="${v.ImageUrl}" class="j-categroy-thumbnail" style="margin-right:10px;width:90px;height:45px;">
                    <a class="btn btn-info btn-mini j-btn-imageUpload" href="javascript:;">
                        <i class="icon-folder-open icon-white"></i> 本地上传
                    </a>
					<a class="btn btn-success btn-mini j-btn-imageManager" href="javascript:;">
                        <i class="icon-picture icon-white"></i> 素材库选择
                    </a>
                </td>
			    <td><input type="text" value="${v.Name}" class="j-categroy-title"></td>
			    <td style="width:30px;"><div style="background:${v.Color};width:30px;height:30px;"><div></td>
				<td>${v.Count}</td>
			    <td style="width:200px;">
				    <a href="javascript:void(0);" onclick="MPage.saveSingleCategroy(this)" class="btn btn-primary btn-mini j-btn-saveItem"><i class="icon-ok icon-white"></i>保存</a>
					<a class="btn btn-primary btn-mini" href="<%=DomainUrl %>/view/goods/list.aspx?cid=${v.Id}&sellerId=<%=SellerId%>"><i class="icon-pencil icon-white"></i> 管理商品</a>
				    <a class="btn btn-danger btn-mini j-btn-del" href="javascript:void(0);"><i class="icon-remove icon-white"></i> 删除</a>
			    </td>
		    </tr>
	    {{/each}}
    {{else}}
        <tr>
            <td colspan="5" align="center">暂无无商品分类</td>
        </tr>
    {{/if}}

    </script>

    <script type="text/javascript">
        var sellerId = '<%=SellerId%>';
        var MPage = {
            hander: "<%=DomainUrl %>/Handler/Merchant/GoodsHandler.ashx?sellerId=" + sellerId + "&action=",
            init: function () {
                var mpage = this;

                //去掉之前选中打开的项 选中产品列表
                $("#sidebar li").removeClass("active open");
                $("#sidebar .sidebar_goods").addClass("active open").find(".sidebar_categories").addClass("active");

                var text_editor,
                    image_editor;
                KindEditor.ready(function (K) {
                    //文本编辑器
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
                                    K('#j-img-placehold').attr("src", url);
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
                                    K('#j-img-placehold').attr("src", url);
                                    image_editor.hideDialog();
                                }
                            });
                        });
                    });
                });

                $('.colorpicker').colorpicker();

                $(".colorpicker").bind("changeColor", function (e) {
                    $("#j-categroy-color-preview").css("background", e.color.toHex());
                    $("#j-categroy-color").val(e.color.toHex());
                });

                mpage.getCategroyList();

                //绑定全选
                $("#j-btn-selectAll").bind("change", function () {
                    if ($(this).attr("checked")) {
                        $("#j-categroy-list .j-select:checkbox").attr("checked", "checked");
                    } else {
                        $("#j-categroy-list .j-select:checkbox").removeAttr("checked");
                    }

                    return false;
                });

                //绑定批量删除
                $("#j-btn-delSelected").bind("click", function () {
                    var $checked = $("#j-categroy-list .j-select:checked");

                    var ids = [];
                    $checked.each(function () {
                        ids.push($(this).parents("tr").attr("data-cid"));
                    });

                    if (ids.length > 0) {
                        Common.confirm({
                            title: "删除确认提示",
                            content: "您确定要删除当前选择的所有数据吗？",
                            confirm: function () {
                                //执行确认回调
                                mpage.delCategroy(ids.join(","));
                            }
                        });
                    } else {
                        Common.alert({
                            title: "提示",
                            content: "请至少选择一项删除"
                        });
                    }

                    return false;
                });

                //绑定批量保存
                $("#j-btn-saveAll").bind("click", function () {
                    mpage.saveCategroyList();
                });

                //绑定提交表单
                $("#save").bind("click", function () {
                    mpage.addCategroy();
                });

                //绑定重置表单
                $("#reset").bind("click", function () {
                    $("#j-categroy-title").val('');
                    $('#j-img-placehold').attr("src", 'http://placehold.it/128x128');
                });
            },
            saveSingleCategroy: function (obj) {
                var mpage = this;
                var data_save = [];
                var $item = $(obj).parents("tr");
                data_save.push(
                {
                    Id: $item.attr("data-cid"),
                    Index: parseInt($item.find(".j-categroy-index").html()),
                    Name: $item.find(".j-categroy-title").val(),
                    ImageUrl: $item.find(".j-categroy-thumbnail").attr("src")
                });

                $.post(mpage.hander + "saveGoodsCategoriesList", { data_save: JSON.stringify(data_save) }, function (data) {
                    if (!data.error) {
                        //TODO:提示弹窗toast
                        Common.tip({ type: "success", content: data.success });
                        mpage.getCategroyList();
                    } else {
                        Common.tip({ type: "error", content: data.error });
                    }
                }, "JSON");
            },

            //保存分类列表
            saveCategroyList: function () {
                var mpage = this;
                var $checked = $("#j-categroy-list .j-select:checked");

                var data_save = [];

                $checked.each(function () {
                    var $item = $(this).parents("tr");
                    data_save.push(
                    {
                        Id: $item.attr("data-cid"),
                        Index: parseInt($item.find(".j-categroy-index").html()),
                        Name: $item.find(".j-categroy-title").val(),
                        ImageUrl: $item.find(".j-categroy-thumbnail").attr("src")
                    });
                });

                if (data_save.length > 0) {
                    Common.confirm({
                        title: "保存确认提示",
                        content: "您确定要保存当前选择的所有修改吗？",
                        confirm: function () {
                            //执行确认回调
                            $.post(mpage.hander + "saveGoodsCategoriesList", { data_save: JSON.stringify(data_save) }, function (data) {
                                if (!data.error) {
                                    //TODO:提示弹窗toast
                                    Common.tip({ type: "success", content: data.success });
                                    mpage.getCategroyList();
                                } else {
                                    Common.tip({ type: "error", content: data.error });
                                }
                            }, "JSON");
                        }
                    });
                } else {
                    Common.alert({
                        title: "提示",
                        content: "请至少选择一项保存"
                    });
                }
            },

            //添加分类
            addCategroy: function () {
                var mpage = this;
                var name = $.trim($("#j-categroy-title").val());
                var imageUrl = $('#j-img-placehold').attr("src");
                var color = $.trim($('#j-categroy-color').val());
                alert(color);

                $.post(mpage.hander + "addGoodsCategories", { name: name, imageUrl: imageUrl,color:color }, function (data) {
                    if (!data.error) {
                        mpage.getCategroyList();
                        Common.tip({ type: "success", content: data.success });
                    } else {
                        Common.tip({ type: "error", content: data.error });
                    }
                }, "JSON");
            },

            //获取分类列表
            getCategroyList: function () {
                var mpage = this;
                //清除选中状态
                $("#j-btn-selectAll").removeAttr("checked");
                $.post(mpage.hander + "getGoodsCategoriesList", {}, function (data) {
                    if (!data.error) {
                        $("#j-categroy-list").html($("#j-tmpl-goods-listitem").tmpl(data));

                        //绑定单个删除
                        $("#j-categroy-list .j-btn-del").bind("click", function () {
                            var $item = $(this).parents("tr");
                            var id = $item.attr("data-cid");

                            Common.confirm({
                                title: "删除确认提示",
                                content: Str.format("您确定要删除编号为{0}的商品分类？", id),
                                confirm: function () {
                                    //执行确认回调
                                    mpage.delCategroy(id);
                                    $item.remove();
                                },
                                cancel: function () {
                                    //执行取消回调
                                    //alert('执行取消回调');
                                }
                            });
                            return false;
                        });

                        //图片上传绑定
                        $('#j-categroy-list .j-btn-imageManager').bind("click", function () {
                            var $item = $(this).parents("tr");

                            mpage.image_editor.loadPlugin('filemanager', function () {
                                mpage.image_editor.plugin.filemanagerDialog({
                                    viewType: 'VIEW',
                                    dirName: 'image',
                                    clickFn: function (url, title) {
                                        $item.find('.j-categroy-thumbnail').attr("src", url);
                                        mpage.image_editor.hideDialog();
                                    }
                                });
                            });
                        });

                        //从资料库选择图片
                        $('#j-categroy-list .j-btn-imageUpload').bind("click", function () {
                            var $item = $(this).parents("tr");
                            mpage.image_editor.loadPlugin('image', function () {
                                mpage.image_editor.plugin.imageDialog({
                                    showRemote: false,
                                    clickFn: function (url, title, width, height, border, align) {
                                        $item.find('.j-categroy-thumbnail').attr("src", url);
                                        mpage.image_editor.hideDialog();
                                    }
                                });
                            });
                        });

                        //绑定上下移动
                        $("#j-categroy-list .j-categroy-up,#j-categroy-list .j-categroy-down").bind("click", function () {
                            var $btn = $(this),
                                $item = $(this).parents("tr");

                            if ($btn.hasClass("disabled")) {
                                return false;
                            }

                            var change_index,
                                $change_item;

                            if ($btn.hasClass("j-categroy-up")) {
                                $change_item = $item.prev();
                                $item.insertBefore($change_item);
                            } else {
                                $change_item = $item.next();
                                $item.insertAfter($change_item);
                            }

                            change_index = $change_item.find(".j-categroy-index").html();
                            $change_item.find(".j-categroy-index").html($item.find(".j-categroy-index").html());
                            $item.find(".j-categroy-index").html(change_index);

                            $("#j-categroy-list .j-categroy-up").removeClass("disabled").first().addClass("disabled");
                            $("#j-categroy-list .j-categroy-down").removeClass("disabled").last().addClass("disabled");
                            return false;
                        });

                    } else {
                        Common.tip({ type: "error", content: data.error });
                    }
                }, "JSON");
            },

            //删除单个分类
            delSingleCategroy: function (id) {
                var mpage = this;
                Common.confirm({
                    title: "删除确认提示",
                    content: Str.format("您确定要删除编号为{0}的商品分类？", id),
                    confirm: function () {
                        //执行确认回调
                        mpage.delCategroy(id);
                    }
                });
            },

            //删除分类 ids:分类商品id字符串,隔开
            delCategroy: function (cids) {
                var mpage = this;
                $.post(mpage.hander + "delGoodsCategoriesList", { ids: cids }, function (data) {
                    if (!data.error) {
                        //删除成功后刷新本页 TODO:提示弹窗toast
                        Common.tip({ type: "success", content: data.success });
                        mpage.getCategroyList();
                    } else {
                        Common.tip({ type: "error", content: data.error });
                    }
                }, "JSON");
            }
        }

        $(function () {
            MPage.init();
        });

</script>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Footer" runat="server">
</asp:Content>


