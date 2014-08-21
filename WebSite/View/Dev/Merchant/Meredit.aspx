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
            <h5>商户修改</h5>
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
                            <select id="j-categroy-list">
                                <option>餐饮超市分类1</option>
                                <option>餐饮超市分类2</option>
                                <option>餐饮超市分类3</option>
                                <option>餐饮超市分类4</option>
                                <option>餐饮超市分类5</option>
                            </select><span style="padding: 0 20px;">所属</span><span class="text-warning">餐饮超市类</span>
                        </div>
                    </div>

                    <div class="control-group">
                        <label class="control-label">使用UI模版</label>
                        <div class="controls">
                            <select id="j-template-list">
                                <option>1</option>
                                <option>2</option>
                                <option>3</option>
                                <option>4</option>
                                <option>5</option>
                            </select>
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
                            <select id="j-dev-list">
                                <option>1</option>
                                <option>2</option>
                                <option>3</option>
                                <option>4</option>
                                <option>5</option>
                            </select>
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
                    <h5>运营状况</h5>
                </div>
                <div class="widget-content">
                    <ul class="server_info clearfix">
                        <li>用户下载量：<b class="text-error">2222</b>次</li>
                        <li>注册会员量：<b class="text-error">2222</b>名</li>
                        <li>商品量：<b class="text-error">2222</b>个</li>
                        <li>本月营业额：<b class="text-error">2222</b>元</li>
                        <li>总营业额：<b class="text-error">2222</b>元</li>
                        <li>空间剩余情况：<b class="text-error">2222</b>MB</li>
                    </ul>
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
    <script type="text/jquery-tmpl-x" id="j-tmpl-categroy-listitem">
        	{{each(i, v) list}}
        		<option value="${v.id}">${v.name}</option>
        	{{/each}}
        </script>

    <script type="text/jquery-tmpl-x" id="j-tmpl-template-listitem">
        	{{each(i, v) list}}
        		<option value="${v.id}">${v.name}</option>
        	{{/each}}
        </script>

    <script type="text/javascript">
        var Shop_SubCategory = [
            {
                id: 1,
                name: "二级分类一"
            },
            {
                id: 2,
                name: "二级分类二"
            },
            {
                id: 3,
                name: "二级分类三"
            },
            {
                id: 4,
                name: "二级分类四"
            }
        ];

        var Template_List = [
            {
                id: 1,
                name: "模版一"
            },
            {
                id: 2,
                name: "模版二"
            },
            {
                id: 3,
                name: "模版三"
            },
            {
                id: 4,
                name: "模版四"
            }
        ];
    	</script>

    <script type="text/javascript">
        var MPage = {
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
                            mpage.getDetail(shop_id);
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

                    mpage.showCategroyList();
                    mpage.showTemplateList();
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

                getDetail: function (id) {
                    var mpage = this;

                    $.post(mpage.hander + "getMerchant", { id: id }, function (data) {
                        if (!data.error) {
                            $("#j-shop-name").val(data.mer.Name);
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
                }
            };

            $(function () {
                MPage.init();
            });

        </script>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Footer" runat="server">
</asp:Content>
