<%@ Page Title="" Language="C#" MasterPageFile="~/View/DevMaster.Master" AutoEventWireup="true" CodeBehind="EditTemple.aspx.cs" Inherits="Backstage.View.Dev.Temple.EditTemple" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Header" runat="server">
    <link rel="shortcut icon" href="<%=DomainUrl %>/Css/img/favicon.ico">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Content" runat="server">


    <div class="widget-box">
        <div class="widget-title">
            <span class="icon">
                <i class="icon-tags"></i>
            </span>
            <h5>修改模版</h5>
        </div>
        <div class="widget-content">
            <div action="#" method="get" class="form-horizontal" id="j-addForm" />
            <div class="control-group">
                <label class="control-label">模版名称</label>
                <div class="controls">
                    <input type="text" id="j-title" />
                </div>
            </div>

            <div class="control-group">
                <label class="control-label">所属类别</label>
                <div class="controls">
                    <select id="j-list">
                    </select>
                </div>
            </div>

            <div class="control-group">
                <label class="control-label">模版效果图</label>
                <div class="controls">

                    <a class="btn btn-info" href="javascript:;" id="j-btn-imageUpload"><i class="icon-folder-open icon-white"></i>本地上传</a>
                    <a class="btn btn-success" href="javascript:;" id="j-btn-imageManager"><i class="icon-picture icon-white"></i>素材库选择</a>
                    <span class="help-inline">上传过的图片可以直接从素材库选择</span>
                    <div class="clearfix" style="margin-top: 10px;">
                        <span class="thumbnail pull-left">
                            <img style="max-width:128px;min-width:128px;max-height:128px;min-height:128px;" src="http://placehold.it/128x128" alt="" id="j-img-placehold">
                        </span>
                    </div>
                </div>
            </div>

            <div class="form-actions">
                <a href="javascript:void(0);" id="reset" class="btn "><i class="icon-ok icon-white"></i>清除重置</a>
                <a href="javascript:void(0);" id="save" class="btn btn-primary"><i class="icon-ok icon-white"></i>确定修改</a>
            </div>
        </div>
    </div>
    </div>

    <!--页面js-->
    <script type="text/javascript" src="<%=DomainUrl %>/Script/kindeditor/kindeditor-min.js"></script>
    <script type="text/javascript" src="<%=DomainUrl %>/Script/kindeditor/lang/zh_CN.js"></script>

    <script type="text/javascript">
        var Shop_Category = [
            {
                id: 0,
                name: "所有模版"
            },
            {
                id: 1,
                name: "餐饮超市类"
            },
            {
                id: 2,
                name: "夜场类"
            },
            {
                id: 3,
                name: "企业类"
            }
        ];

        </script>

    <script type="text/jquery-tmpl-x" id="j-tmpl-optionitem">
        	{{each(i, v) list}}
        		<option value="${v.id}">${v.name}</option>
        	{{/each}}
        </script>

    <script type="text/javascript">
        var MPage = {
            templeid: 0,
            hander: "<%=DomainUrl %>/Handler/Platform/AnnouncementHandler.ashx?action=",
            init: function() {
                var mpage = this;

                //去掉之前选中打开的项 选中产品列表
                $("#sidebar li").removeClass("active open");
                $("#sidebar .sidebar_templemanager").addClass("active open").find(".sidebar_templelist").addClass("active");

                mpage.showCategroyList();

                var text_editor,
                    image_editor;
                KindEditor.ready(function(K) {
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

                    //图片上传绑定
                    K('#j-btn-imageManager').click(function() {
                        image_editor.loadPlugin('filemanager', function() {
                            image_editor.plugin.filemanagerDialog({
                                viewType: 'VIEW',
                                dirName: 'image',
                                clickFn: function(url, title) {
                                    K('#j-img-placehold').attr("src", url);
                                    image_editor.hideDialog();
                                }
                            });
                        });
                    });

                    //从资料库选择图片
                    K('#j-btn-imageUpload').click(function() {
                        image_editor.loadPlugin('image', function() {
                            image_editor.plugin.imageDialog({
                                showRemote: false,
                                imageUrl: K('#j-img-placehold').attr("src"),
                                clickFn: function(url, title, width, height, border, align) {
                                    K('#j-img-placehold').attr("src", url);
                                    image_editor.hideDialog();
                                }
                            });
                        });
                    });

                    var route = Route.parse(document.location.href, Route.SEARCH);
                    var template_id = route.param.id;

                    if (template_id) {
                        mpage.templeid = template_id;
                        mpage.getImageDetail();
                    } else {
                        alert("该模版不存在");
                        window.history.back();
                    }
                });


                //绑定提交表单
                $("#save").bind("click", function() {
                    mpage.updateTemple();
                });

                //绑定重置表单
                $("#reset").bind("click", function() {
                    mpage.setTempleData();
                    return false;
                });
            },

            showCategroyList: function() {
                $("#j-list").html($("#j-tmpl-optionitem").tmpl({
                    list: Shop_Category
                }));
            },

            updateTemple: function() {
                var mpage = this;
                var typeid = $("#j-list").val();
                var name = $.trim($("#j-title").val());
                var logourl = $('#j-img-placehold').attr("src");
                $.post(mpage.hander + "updateTemple", { id: mpage.templeid, logourl: logourl, name: name, typeid: typeid }, function(data) {
                    if (!data.error) {
                        Common.tip({ type: "success", content: data.success });
                        window.location.href = "<%=DomainUrl %>/View/Dev/Temple/Templelist.aspx";
                    } else {
                        Common.tip({ type: "error", content: data.error });
                    }
                }, "JSON");
            },

            getImageDetail: function() {
                var mpage = this;
                $.post(mpage.hander + "getTemple", { id: mpage.templeid }, function(data) {
                    if (!data.error) {
                        mpage.setTempleData(data.data);
                    } else {
                        Common.tip({ type: "error", content: data.error });
                    }
                }, "JSON");
            },

            setTempleData: function(temple) {
                var mpage = this;
                
                $("#j-title").val(temple.Name);
                $("#j-thumbnails").html("").hide();
                $('#j-img-placehold').attr("src", temple.LogoUrl);
                $("#j-list").val(temple.TypeId);
            }
        };

        $(function () {
            MPage.init();
        });

        </script>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Footer" runat="server">
</asp:Content>
