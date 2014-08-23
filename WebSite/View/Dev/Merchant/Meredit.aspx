<%@ Page Title="" Language="C#" MasterPageFile="~/View/DevMaster.Master" AutoEventWireup="true" CodeBehind="Meredit.aspx.cs" Inherits="Backstage.View.Dev.Merchant.Meredit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Header" runat="server">
    <link rel="shortcut icon" href="<%=DomainUrl %>/Css/img/favicon.ico">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Content" runat="server">

    <div class="widget-box">
        <div class="widget-title">
            <span class="icon">
                <i class="icon-gift"></i>
            </span>
            <h5>修改商户</h5>
        </div>
        <div class="widget-content">
            <div action="#" method="post" class="form-horizontal" id="j-goods-addForm" />
            <div class="widget-box">
                <div class="widget-content">
                    <div class="control-group">
                        <label class="control-label">商户名称</label>
                        <div class="controls">
                            <input type="text" id="j-shop-name" />
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label">登陆用户名</label>
                        <div class="controls">
                            <input type="text" id="j-login-name" />
                        </div>
                    </div>

                    <div class="control-group">
                        <label class="control-label">商户logo</label>
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

                    <div class="control-group">
                        <label class="control-label">商户类型</label>
                        <div class="controls">
                            <select id="j-subCategory-list"></select><span id="j-shop-category-hold" style="display: none;"><span style="padding: 0 20px;">所属</span><span class="text-warning" id="j-shop-category">餐饮超市类</span></span>
                        </div>
                    </div>

                    <div class="control-group" style="display: none;" id="j-template-hold">
                        <label class="control-label">使用UI模版</label>
                        <div class="controls">
                            <select id="j-template-list"></select>
                        </div>
                    </div>

                    <div class="control-group">
                        <label class="control-label">入驻日期</label>
                        <div class="controls">
                            <span class="static-text">2014-02-12</span>
                        </div>
                    </div>

                    <div class="control-group">
                        <label class="control-label">服务期至</label>
                        <div class="controls">
                            <span class="static-text">2014-02-12</span>
                            <a href="" class="btn btn-primary btn-mini"><i class="icon-plus icon-white"></i>增加一年</a>
                        </div>
                    </div>

                    <div class="control-group">
                        <label class="control-label">易wifi和云打印</label>
                        <div class="controls">
                            <label class="checkbox">
                                <input type="checkbox" id="j-is_wifi">
                                是否使用【易wifi】</label>
                            <label class="checkbox">
                                <input type="checkbox" id="j-is_print">
                                是否使用【云打印】</label>
                        </div>
                    </div>

                    <div class="control-group">
                        <label class="control-label">签约模式</label>
                        <div class="controls">
                            <select id="j-sign-list">
                                <option>模式A</option>
                                <option>模式B</option>
                            </select>
                        </div>
                    </div>

                    <div class="control-group">
                        <label class="control-label">开发人员</label>
                        <div class="controls">
                            <input type="text" id="j-dev-name" />
                        </div>
                    </div>
                </div>
            </div>

            <div class="widget-box">
                <div class="widget-title">
                    <h5>基本资料</h5>
                </div>
                <div class="widget-content">

                    <div class="control-group">
                        <label class="control-label">联系电话</label>
                        <div class="controls">
                            <input type="text" id="j-profile-phone" />
                        </div>
                    </div>

                    <div class="control-group">
                        <label class="control-label">管理人联系电话</label>
                        <div class="controls">
                            <input type="text" id="j-profile-admin_phone" />
                        </div>
                    </div>

                    <div class="control-group">
                        <label class="control-label">联系地址</label>
                        <div class="controls">
                            <input type="text" id="j-profile-address" />
                        </div>
                    </div>

                    <div class="control-group">
                        <label class="control-label">微信公众号</label>
                        <div class="controls">
                            <input type="text" id="j-profile-wechat_id" />
                        </div>
                    </div>

                    <div class="control-group">
                        <label class="control-label">服务QQ号</label>
                        <div class="controls">
                            <input type="text" id="j-profile-qq" />
                        </div>
                    </div>

                    <div class="control-group">
                        <label class="control-label">Email</label>
                        <div class="controls">
                            <input type="text" id="j-profile-email" />
                        </div>
                    </div>
                </div>
            </div>

            <div class="widget-box">
                <div class="widget-title">
                    <h5>类别名称</h5>
                </div>
                <div class="widget-content">

                    <div class="control-group">
                        <label class="control-label">活动咨询</label>
                        <div class="controls">
                            <input type="text" value="默认名称" />
                        </div>
                    </div>

                    <div class="control-group">
                        <label class="control-label">商品展示</label>
                        <div class="controls">
                            <input type="text" value="默认名称" />
                        </div>
                    </div>

                    <div class="control-group">
                        <label class="control-label">快速预约</label>
                        <div class="controls">
                            <input type="text" value="默认名称" />
                        </div>
                    </div>

                    <div class="control-group">
                        <label class="control-label">图片墙</label>
                        <div class="controls">
                            <input type="text" value="默认名称" />
                        </div>
                    </div>

                    <div class="control-group">
                        <label class="control-label">包厢</label>
                        <div class="controls">
                            <input type="text" value="默认名称" />
                        </div>
                    </div>
                </div>
            </div>

            <div class="form-actions">
                <a href="javascript:history.back();" class="btn">返回</a>
                <a href="javascript:void(0);" id="reset" class="btn btn-primary"><i class="icon-ok icon-white"></i>清除重置</a>
                <a href="javascript:void(0);" id="save" class="btn btn-primary"><i class="icon-ok icon-white"></i>完成保存</a>
            </div>
        </div>
    </div>
    </div>
       
    <!--页面js-->
    <script charset="utf-8" src="<%=DomainUrl %>/Script/kindeditor/kindeditor-min.js"></script>
    <script charset="utf-8" src="<%=DomainUrl %>/Script/kindeditor/lang/zh_CN.js"></script>


    <!--分类下拉框模版-->
    <script type="text/jquery-tmpl-x" id="j-tmpl-category-listitem">
        	<option value="0">请选择分类</option>
        	{{each(i, v) list}}
        		<option value="${v.Id}" data-typeid="${v.TypeId}">${v.Name}</option>
        	{{/each}}
    </script>

    <script type="text/jquery-tmpl-x" id="j-tmpl-template-listitem">
        	{{each(i, v) list}}
        		<option value="${v.Id}">${v.Name}</option>
        	{{/each}}
    </script>

    <script type="text/javascript">
        var Shop_Category = [
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


        var Shop_SubCategory = [
            {
                id: 1,
                name: "二级分类一",
                typeid: 1
            },
            {
                id: 2,
                name: "二级分类二",
                typeid: 1
            },
            {
                id: 3,
                name: "二级分类三",
                typeid: 1
            },
            {
                id: 4,
                name: "二级分类四",
                typeid: 1
            },
            {
                id: 5,
                name: "二级分类5",
                typeid: 2
            },
            {
                id: 6,
                name: "二级分类6",
                typeid: 3
            },
            {
                id: 7,
                name: "二级分类7",
                typeid: 3
            },
            {
                id: 8,
                name: "二级分类8",
                typeid: 3
            }
        ];

        var Template_List = [
            {
                id: 1,
                name: "模版一",
                typeid: 1
            },
            {
                id: 2,
                name: "模版二",
                typeid: 2
            },
            {
                id: 3,
                name: "模版三",
                typeid: 2
            },
            {
                id: 4,
                name: "模版四",
                typeid: 3
            },
            {
                id: 5,
                name: "模版5",
                typeid: 1
            },
            {
                id: 6,
                name: "模版6",
                typeid: 2
            },
            {
                id: 7,
                name: "模版7",
                typeid: 2
            },
            {
                id: 8,
                name: "模版8",
                typeid: 3
            }
        ];
    </script>
    <script type="text/javascript">
        var MPage = {
            merchantid: 0,
            hander: "<%=DomainUrl %>/Handler/Platform/AnnouncementHandler.ashx?action=",
            init: function () {
                var mpage = this;

                //去掉之前选中打开的项 选中产品列表
                $("#sidebar li").removeClass("active open");
                $("#sidebar .sidebar_merchant").addClass("active open").find(".sidebar_merlist").addClass("active");

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
                    /\?id=(\d+)/.test(document.location.href);
                    var shop_id = RegExp.$1;

                    if (shop_id) {
                        mpage.merchantid = shop_id;
                        mpage.getDetail();
                    } else {
                        alert("该商户不存在");
                        window.history.back();
                    }
                });

                //提交表单
                $("#j-goods-addForm").bind("submit", function () {

                    return false;
                });

                //重置表单
                $("#j-goods-addForm").bind("reset", function () {

                });

                $("#j-subCategory-list").bind("change", function () {
                    var typeid = parseInt($(this).find("option:selected").attr("data-typeid")) || 0;

                    if (typeid > 0) {
                        $("#j-shop-category-hold").show();

                        $.each(Shop_Category, function (i, v) {
                            if (v.id == typeid) {
                                $("#j-shop-category").html(v.name);
                                return false;
                            }
                        });


                        var _Template_List = [];

                        $.each(Template_List, function (i, v) {
                            if (v.TypeId == typeid || v.TypeId == 0) {
                                _Template_List.push(v);
                            }
                        });

                        $("#j-template-list").html($("#j-tmpl-template-listitem").tmpl({
                            list: _Template_List
                        }));

                        $("#j-template-hold").show();
                    } else {
                        $("#j-shop-category-hold").hide();
                        $("#j-template-hold").hide();

                        $("#j-template-list").val(0);
                        $("#j-shop-category").html("");
                    }

                });

                mpage.showSubCategoryList();
                mpage.getDetail();
            },

            showCategroyList: function () {
                var mpage = this;
                $.post(mpage.hander + "getMerchantTypeList", {}, function (data) {
                    if (!data.error) {
                        $("#j-categroy-list").html($("#j-tmpl-categroy-listitem").tmpl(data));
                    } else {
                        Common.tip({ type: "error", content: data.error });
                    }
                }, "JSON");
            },

            showTemplateList: function () {
                var mpage = this;

                $("#j-template-list").html($("#j-tmpl-template-listitem").tmpl({
                    list: Template_List
                }));
            },

            getDetail: function () {
                var mpage = this;
                var data = {
                    typeid: 1,
                    stypeid: 1,
                    tid: 5
                }


                $.post(mpage.hander + "getMerchant", { id: mpage.merchantid }, function (data) {
                    if (!data.error) {
                        $("#j-subCategory-list").val(data.mer.Mid).trigger("change");
                        $("#j-template-list").val(data.mer.Tid);
                        $("#j-shop-name").val(data.mer.Name);
                        $("#j-login-name").val(data.user.UserName);
                        $('#j-img-placehold').attr("src", data.mer.LogoUrl);
                        $('#j_user_createtime').val(data.user.CreateTime); 
                        $('#j_mer_serverendtime').val(data.mer.ServerEndTime);
                        if (data.mer.HasWifi) $("#j-is_wifi").attr("checked", "checked");
                        if (data.mer.HasPrint) $("#j-is_print").attr("checked", "checked"); 
                        $("#j-dev-name").val(data.mer.DevName);
                    } else {
                        Common.tip({ type: "error", content: data.error });
                        //Common.alert({
                        //    title: "提示",
                        //    content: data.error,
                        //    confirm: function () {
                        //    }
                        //});
                    }
                }, "JSON");
            },


            showSubCategoryList: function () {
                var mpage = this;
                $("#j-subCategory-list").html($("#j-tmpl-category-listitem").tmpl({
                    list: Shop_SubCategory
                }));
            }
        };

        $(function () {
            $.post(MPage.hander + "getMerchantTypeList", { type: 1 }, function (data) {
                if (!data.error) {
                    Shop_SubCategory = data.list;
                    $.post(MPage.hander + "getTempleList", { typeid: 0, start: 0, limit: 0 }, function (data2) {
                        if (!data.error) {
                            Template_List = data2.list;
                            MPage.init();
                        } else {
                            Common.tip({ type: "error", content: data.error });
                        }
                    }, "JSON");
                } else {
                    Common.tip({ type: "error", content: data.error });
                }
            }, "JSON");
        });

        </script>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Footer" runat="server">
</asp:Content>
