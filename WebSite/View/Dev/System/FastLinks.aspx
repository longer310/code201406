<%@ Page Title="" Language="C#" MasterPageFile="~/View/DevMaster.Master" AutoEventWireup="true" CodeBehind="FastLinks.aspx.cs" Inherits="Backstage.View.Dev.System.Links" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Header" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Content" runat="server">
    
			<div class="widget-box" >
				<div class="widget-title">
					<span class="icon">
						<i class="icon-cog"></i>
					</span>
					<h5>添加快捷方式</h5>
				</div>
				<div class="widget-content">
					<form action="#" method="post" class="form-horizontal" id="j-addForm" />
						<div class="control-group">
							<label class="control-label">快捷名称</label>
							<div class="controls">
								<input type="text" id="j-title" />
							</div>
						</div>
						
						<div class="control-group">
							<label class="control-label">快捷图标</label>
							<div class="controls">
								
								<a class="btn btn-info" href="javascript:;" id="j-btn-imageUpload"><i class="icon-folder-open icon-white"></i> 本地上传</a>
								<a class="btn btn-success" href="javascript:;" id="j-btn-imageManager"><i class="icon-picture icon-white"></i> 素材库选择</a>
								<span class="help-inline">上传过的图片可以直接从素材库选择</span>
								<div class="clearfix" style="margin-top:10px;">
									<span class="thumbnail pull-left">
										<img src="http://placehold.it/40x40" alt="" id="j-img-placehold">
									</span>
								</div>
							</div>
						</div>

						<div class="control-group">
							<label class="control-label">跳转地址</label>
							<div class="controls">
								<input type="text" id="j-url" />
							</div>
						</div>

						<div class="form-actions">
							<button type="reset" class="btn"><i class="icon-refresh"></i> 清除重置</button>
							<button type="submit" class="btn btn-primary"><i class="icon-ok icon-white"></i> 完成保存</button>
						</div>
					</form>
				</div>
			</div>
    
			<div class="widget-box" >
				<div class="widget-title">
					<span class="icon">
						<i class="icon-cog"></i>
					</span>
					<h5>快捷方式列表</h5>
					<div class="buttons">
						<a href="#" class="btn btn-primary btn-mini" id="j-btn-saveAll"><i class="icon-ok icon-white"></i> 保存所有</a>
						<a href="#" class="btn btn-danger btn-mini" id="j-btn-delSelected"><i class="icon-remove icon-white"></i> 删除</a>
					</div>
				</div>
				<div class="widget-content">
					<table class="table table-bordered table-striped with-check">
						<thead>
							<tr>
								<th><input type="checkbox" id="j-btn-selectAll" name="title-table-checkbox" /></th>
								<th>序号</th>
								<th>快捷图标</th>
								<th>快捷名称</th>
								<th>跳转地址</th>
								<th>操作</th>
							</tr>
						</thead>
						<tbody id="j-list">
						</tbody>
					</table>
				</div>
			</div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Footer" runat="server">
    
        <!--页面js-->
        <script src="../public/js/ue.pager.js"></script>

        <script charset="utf-8" src="../public/kindeditor/kindeditor-min.js"></script>
		<script charset="utf-8" src="../public/kindeditor/lang/zh_CN.js"></script>

		<script type="text/jquery-tmpl-x" id="j-tmpl-listitem">
        	{{each(i, v) list}}
	        	<tr data-cid="${v.id}">
					<td><input type="checkbox" class="j-select" /></td>
					<td style="width:90px;">
						<a class="btn btn-mini {{if i == 0}}disabled{{/if}} j-up" href="javascript:;"><i class="icon icon-arrow-up"></i></a>
						<span class="j-index">${v.index}</span>
						<a class="btn btn-mini {{if i == list.length - 1}}disabled{{/if}} j-down" href="javascript:;"><i class="icon icon-arrow-down"></i></a>
					</td>
					<td style="width:230px;"><img src="http://placehold.it/40x40" class="j-thumbnail" style="margin-right:10px;width:40px;height:40px;"><a class="btn btn-info btn-mini j-btn-imageUpload" href="javascript:;"><i class="icon-folder-open icon-white"></i> 本地上传</a>
								<a class="btn btn-success btn-mini j-btn-imageManager" href="javascript:;"><i class="icon-picture icon-white"></i> 素材库选择</a></td>
					<td><input type="text" value="水煮活鱼水煮活鱼水煮活鱼" class="j-title"></td>
					<td><input type="text" value="http://baidu.com" class="j-url"></td>
					<td style="width:60px;">
						<a class="btn btn-danger btn-mini j-btn-del" href=""><i class="icon-remove icon-white"></i> 删除</a>
					</td>
				</tr>
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

                    mpage.getList();

                    //绑定全选
                    $("#j-btn-selectAll").bind("change", function () {
                        if ($(this).attr("checked")) {
                            $("#j-list .j-select:checkbox").attr("checked", "checked");
                        } else {
                            $("#j-list .j-select:checkbox").removeAttr("checked");
                        }

                        return false;
                    });

                    //绑定批量删除
                    $("#j-btn-delSelected").bind("click", function () {
                        var $checked = $("#j-list .j-select:checked");

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
                                    alert('执行确认回调');

                                    //删除成功后刷新本页
                                    mpage.getList();
                                },
                                cancel: function () {
                                    //执行取消回调
                                    alert('执行取消回调');
                                }
                            });
                        } else {
                            Common.alert({
                                title: "提示",
                                content: "请至少选择一项",
                                confirm: function () {
                                    //执行确认回调
                                    alert('执行确认回调');
                                }
                            });
                        }

                        return false;
                    });

                    //绑定批量保存
                    $("#j-btn-saveAll").bind("click", function () {
                        var $checked = $("#j-list .j-select:checked");

                        var data_save = [];

                        $checked.each(function () {
                            var $item = $(this).parents("tr");
                            data_save.push(
        					{
        					    id: $item.attr("data-cid"),
        					    index: parseInt($item.find(".j-index").html()),
        					    title: $item.find(".j-title").val(),
        					    title: $item.find(".j-url").val(),
        					    thumbnail: $item.find(".j-thumbnail").attr("src")
        					});
                        });

                        console.log(data_save);

                        if (data_save.length > 0) {
                            Common.confirm({
                                title: "保存确认提示",
                                content: "您确定要保存当前选择的所有修改吗？",
                                confirm: function () {
                                    //执行确认回调
                                    alert('执行确认回调');

                                },
                                cancel: function () {
                                    //执行取消回调
                                    alert('执行取消回调');
                                }
                            });
                        } else {
                            Common.alert({
                                title: "提示",
                                content: "请至少选择一项",
                                confirm: function () {
                                    //执行确认回调
                                    alert('执行确认回调');
                                }
                            });
                        }

                        return false;
                    });

                    //绑定提交表单
                    $("#j-addForm").bind("submit", function () {
                        var save_data = {
                            title: $.trim($("#j-title").val()),
                            title: $.trim($("#j-url").val()),
                            thumbnail: $('#j-img-placehold').attr("src")
                        }

                        console.log(save_data);
                        alert('提交数据');
                        //添加成功后重新获取分类列表
                        mpage.getList();
                        return false;
                    });

                    //绑定重置表单
                    $("#j-addForm").bind("reset", function () {
                        $("#j-title").val('');
                        $('#j-img-placehold').attr("src", 'http://placehold.it/128x128');
                        return false;
                    });
                },

                getList: function () {
                    var mpage = this;

                    //$.getJSON("", { p: p, type : type}， function(json){
                    $("#j-btn-selectAll").removeAttr("checked");
                    var json = {
                        code: 0,
                        msg: "",
                        result: {
                            count: 59,
                            list: [
                                {
                                    index: 1,
                                    id: 1,
                                },
                                {
                                    index: 2,
                                    id: 2
                                },
                                {
                                    index: 3,
                                    id: 3
                                },
                                {
                                    index: 4,
                                    id: 4
                                },
                                {
                                    index: 5,
                                    id: 5
                                },
                                {
                                    index: 6,
                                    id: 6
                                }
                            ]
                        }
                    };

                    $("#j-list").html($("#j-tmpl-listitem").tmpl(json.result));

                    //绑定单个删除
                    $("#j-list .j-btn-del").bind("click", function () {
                        var $item = $(this).parents("tr");
                        var id = $item.attr("data-cid");

                        Common.confirm({
                            title: "删除确认提示",
                            content: "您确定要删除当前活动？",
                            confirm: function () {
                                //执行确认回调
                                alert('执行确认回调');

                                $item.remove();
                            },
                            cancel: function () {
                                //执行取消回调
                                alert('执行取消回调');
                            }
                        });
                        return false;
                    });

                    //图片上传绑定
                    $('#j-list .j-btn-imageManager').bind("click", function () {
                        var $item = $(this).parents("tr");

                        mpage.image_editor.loadPlugin('filemanager', function () {
                            mpage.image_editor.plugin.filemanagerDialog({
                                viewType: 'VIEW',
                                dirName: 'image',
                                clickFn: function (url, title) {
                                    $item.find('.j-thumbnail').attr("src", url);
                                    mpage.image_editor.hideDialog();
                                }
                            });
                        });
                    });

                    //从资料库选择图片
                    $('#j-list .j-btn-imageUpload').bind("click", function () {
                        var $item = $(this).parents("tr");
                        mpage.image_editor.loadPlugin('image', function () {
                            mpage.image_editor.plugin.imageDialog({
                                showRemote: false,
                                clickFn: function (url, title, width, height, border, align) {
                                    $item.find('.j-thumbnail').attr("src", url);
                                    mpage.image_editor.hideDialog();
                                }
                            });
                        });
                    });

                    //绑定上下移动
                    $("#j-list .j-up,#j-list .j-down").bind("click", function () {
                        var $btn = $(this),
                            $item = $(this).parents("tr");

                        if ($btn.hasClass("disabled")) {
                            return false;
                        }

                        var change_index,
                            $change_item;

                        if ($btn.hasClass("j-up")) {
                            $change_item = $item.prev();
                            $item.insertBefore($change_item);
                        } else {
                            $change_item = $item.next();
                            $item.insertAfter($change_item);
                        }

                        change_index = $change_item.find(".j-index").html();
                        $change_item.find(".j-index").html($item.find(".j-index").html());
                        $item.find(".j-index").html(change_index);

                        $("#j-list .j-up").removeClass("disabled").first().addClass("disabled");
                        $("#j-list .j-down").removeClass("disabled").last().addClass("disabled");
                        return false;
                    });
                    //});

                }
            }

            $(function () {
                MPage.init();
            });

        </script>
</asp:Content>
