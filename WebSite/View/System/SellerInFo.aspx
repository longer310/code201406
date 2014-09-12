<%@ Page Title="" Language="C#" MasterPageFile="~/View/merchant.Master" AutoEventWireup="true" CodeBehind="SellerInFo.aspx.cs" Inherits="Backstage.View.System.SellerInFo" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Header" runat="server">
    <link href="../scripts/kindeditor/themes/default/default.css" type="text/css" rel="stylesheet">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Content" runat="server">
    <div class="widget-box">
        <div class="widget-title">
            <span class="icon">
                <i class="icon-cog"></i>
            </span>
            <h5>资料设置</h5>
        </div>
        <div class="widget-content">
            <form action="#" method="get" class="form-horizontal" id="j-sysytem-profile-form" />
            <div class="control-group">
                <label class="control-label">商户名称</label>
                <div class="controls">
                    <input type="text" id="j-sysytem-profile-name" value="<%=Seller.Name %>" />
                </div>
            </div>
            <div class="control-group">
                <label class="control-label">商户LOGO</label>
                <div class="controls">

                    <a class="btn btn-info" href="javascript:;" id="j-btn-imageUpload_logo"><i class="icon-folder-open icon-white"></i>本地上传</a>
                    <a class="btn btn-success" href="javascript:;" id="j-btn-imageManager_logo"><i class="icon-picture icon-white"></i>素材库选择</a>
                    <span class="help-inline">上传过的图片可以直接从素材库选择</span>
                    <div class="clearfix" style="margin-top: 10px;">
                        <span class="thumbnail pull-left">
                            <img src="<%=Seller.LogoUrl == "" ? "http://placehold.it/128x128" : Seller.LogoUrl%>" alt="" id="j-sysytem-profile-logo">
                        </span>
                    </div>
                </div>
            </div>

            <div class="control-group">
                <label class="control-label">联系电话</label>
                <div class="controls">
                    <input type="text" id="j-sysytem-profile-phone" value="<%=Seller.Phone %>" />
                </div>
            </div>

            <div class="control-group">
                <label class="control-label">管理人联系电话</label>
                <div class="controls">
                    <input type="text" id="j-sysytem-profile-admin_phone" value="<%=Seller.ManagerPhone %>" />
                </div>
            </div>

            <div class="control-group">
                <label class="control-label">详细地址</label>
                <div class="controls">
                    <input type="text" id="j-sysytem-profile-address" value="<%=Seller.Address %>" />
                </div>
            </div>

            <table class="table table-striped table-bordered" style="margin-top: 10px;">
                <tbody>
                    <tr>
                        <th style="width: 16.66%">入住日期：</th>
                        <td style="width: 16.66%"><span class="text-info"><%=Seller.CreateTime.ToString("yyyy-MM-dd HH:mm:ss") %></span></td>
                        <th style="width: 16.66%">服务期至：</th>
                        <td style="width: 16.66%"><span class="text-error"><%=Seller.ServerEndTime.ToString("yyyy-MM-dd HH:mm:ss") %></td>
                    </tr>
                </tbody>
            </table>

            <div class="control-group">
                <label class="control-label">微信公众号</label>
                <div class="controls">
                    <input type="text" id="j-sysytem-profile-wechat_id" value="<%=Seller.WinXinAccount %>" />
                </div>
            </div>

            <div class="control-group">
                <label class="control-label">服务QQ号</label>
                <div class="controls">
                    <input type="text" id="j-sysytem-profile-qq" value="<%=Seller.Qq %>" />
                </div>
            </div>

            <div class="control-group">
                <label class="control-label">Email</label>
                <div class="controls">
                    <input type="text" id="j-sysytem-profile-email" value="<%=Seller.Email %>" />
                </div>
            </div>

            <div class="control-group">
                <label class="control-label">商户说明</label>
                <div class="controls">
                    <textarea name="content" style="height: 400px; visibility: hidden;"><%=Seller.Description %></textarea>
                </div>
            </div>
            <div class="form-actions">
                <button type="submit" class="btn btn-primary"><i class="icon-ok icon-white"></i>完成保存</button>
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
                        uploadJson: '<%=DomainUrl %>/Handler/FileManager/UploadHandler.ashx?type=0',
                            allowFileManager: true
                        });

                        //图片上传编辑
                        mpage.image_editor = image_editor = K.editor({
                            uploadJson: '<%=DomainUrl %>/Handler/FileManager/UploadHandler.ashx?type=0',
                            fileManagerJson: '<%=DomainUrl %>/Handler/FileManager/FileManagerHandler.ashx?type=0',
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
                    $("#j-sysytem-profile-form").bind("submit", function () {
                        var save_data = {
                            title: $.trim($("#j-sysytem-profile-name").val()),
                            logourl: $.trim($("#j-sysytem-profile-logo").attr("src")),
                            phone: $.trim($("#j-sysytem-profile-phone").val()),
                            managephone: $.trim($("#j-sysytem-profile-admin_phone").val()),
                            address: $.trim($("#j-sysytem-profile-address").val()),
                            weixin: $.trim($("#j-sysytem-profile-wechat_id").val()),
                            qq: $.trim($("#j-sysytem-profile-qq").val()),
                            email: $.trim($("#j-sysytem-profile-email").val()),
                            content: text_editor.html()
                        }

                        $.ajax({
                            url: "../../Handler/Backstage/SystemHandler.ashx?action=sellerinfo&sellerid=" + sellerId,
                            data: save_data,
                            type: "POST",
                            dataType: "json"
                            //context: document.body
                        }).success(function (data) {
                            alert("修改成功");
                            window.setTimeout(function () {
                                window.location.reload();
                            }, 2000);
                        });
                        return false;
                    });

                }
            }

            $(function () {
                MPage.init();
            });

        </script>
</asp:Content>
