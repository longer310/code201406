<%@ Page Title="" Language="C#" MasterPageFile="~/View/DevMaster.Master" AutoEventWireup="true" CodeBehind="Ad.aspx.cs" Inherits="Backstage.View.Dev.Ad.Ad" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Header" runat="server">
    <link rel="shortcut icon" href="<%=DomainUrl %>/Css/img/favicon.ico">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Content" runat="server">

    <div class="widget-box">
        <div class="widget-title">
            <h5>软件端广告</h5>
        </div>
        <div class="widget-content">
            <div action="#" method="get" class="form-horizontal" id="j-ad-addForm" />
            <div class="control-group">
                <label class="control-label">广告图片</label>
                <div class="controls">

                    <a class="btn btn-info" id="j-btn-imageUpload" href="javascript:;"><i class="icon-folder-open icon-white"></i>本地上传</a>
                    <a class="btn btn-success" id="j-btn-imageManager" href="javascript:;"><i class="icon-picture icon-white"></i>素材库选择</a>
                    <span class="help-inline">上传过的图片可以直接从素材库选择</span>
                    <div class="clearfix" style="margin-top: 10px;">
                        <span class="thumbnail pull-left">
                            <img src="http://placehold.it/540x65" width="540" height="65"  alt="" id="j-img-placehold">
                        </span>
                    </div>
					<p style="margin-top:10px;"><b class="text-error">上传图片要求：540x65</b></p>
                </div>
            </div>

            <div class="control-group">
                <label class="control-label">跳转至</label>
                <div class="controls">
                    <input class="j-goto" type="text" value="">
                </div>
            </div>
        </div>

        <div class="form-actions">
                <a href="javascript:void(0);" id="save" class="btn btn-primary"><i class="icon-ok icon-white"></i>完成保存</a>
        </div>
        </div>
					
    </div>

    <div id="footer">
        <p>关于淘宝合作伙伴营销中心廉正举报联系客服开放平台诚征英才联系我们网站地图法律声明© 2003-2014 Taobao.com 版权所有</p>
        <p>网络文化经营许可证：文网文[2010]040号|增值电信业务经营许可证：浙B2-20080224-1|信息网络传播视听节目许可证：1109364号 </p>
    </div>

    <!--页面js-->
    <script src="<%=DomainUrl %>/Script/js/ue.pager.js"></script>
    <script type="text/javascript" charset="utf-8" src="<%=DomainUrl %>/Script/kindeditor/kindeditor-min.js"></script>
    <script type="text/javascript" charset="utf-8" src="<%=DomainUrl %>/Script/kindeditor/lang/zh_CN.js"></script>


    <script>
        var MPage = {
            hander: "<%=DomainUrl %>/Handler/Platform/AnnouncementHandler.ashx?action=",
            init: function () {
                var mpage = this;

                //去掉之前选中打开的项 选中产品列表
                $("#sidebar li").removeClass("active open");
                $("#sidebar .sidebar_ad").addClass("active open");

                var image_editor;
                KindEditor.ready(function (K) {
                    //图片上传编辑
                    mpage.image_editor = image_editor = K.editor({
                        uploadJson: '<%=DomainUrl %>/Handler/FileManager/UploadHandler.ashx?type=109',
                        fileManagerJson: '<%=DomainUrl %>/Handler/FileManager/FileManagerHandler.ashx?type=109',
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


                //绑定提交表单
                $("#save").bind("click", function () {
                    var picurl = $("#j-img-placehold").attr("src");
                    var jumpurl = $(".j-goto").val();
                    $.post(MPage.hander + "saveAdCfg", { type: 0, imgs: picurl, jumpurls: jumpurl, staytime: 1 }, function (data) {
                        if (!data.error) {
                            Common.tip({ type: "success", content: data.success });
                        } else {
                            Common.tip({ type: "error", content: data.error });
                        }
                    }, "JSON");
                    return false;
                });

                mpage.getAdInfo();
            },

            getAdInfo: function () {
                var mpage = this;

                $.post(mpage.hander + "getAdCfg", {}, function (data) {
                    if (!data.error) {
                        $("#j-img-placehold").attr("src", data.data.PhoneAd.PicUrl);
                        $(".j-goto").val(data.data.PhoneAd.JumpUrl);
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


