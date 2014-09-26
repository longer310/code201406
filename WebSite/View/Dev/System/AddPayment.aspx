﻿<%@ Page Title="" Language="C#" MasterPageFile="~/View/DevMaster.Master" AutoEventWireup="true" CodeBehind="AddPayment.aspx.cs" Inherits="Backstage.View.Dev.System.AddPayment" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Header" runat="server">
    <link rel="shortcut icon" href="<%=DomainUrl %>/Css/img/favicon.ico">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Content" runat="server">


    <div class="widget-box">
        <div class="widget-title">
            <span class="icon">
                <i class="icon-cog"></i>
            </span>
            <h5>添加支付接口</h5>
        </div>
        <div class="widget-content">
            <ul class="nav nav-tabs">
                <li><a href="<%=DomainUrl %>/View/Dev/System/Payment.aspx">支付接口列表</a></li>
                <li class="active"><a href="<%=DomainUrl %>/View/Dev/System/AddPayment.aspx">添加支付接口</a></li>
            </ul>
            <div action="#" method="get" class="form-horizontal" id="j-addForm" />
            <div class="control-group">
                <label class="control-label">支付名称</label>
                <div class="controls">
                    <input type="text" id="j-title" />
                </div>
            </div>

            <div class="control-group">
                <label class="control-label">支付Logo</label>
                <div class="controls">

                    <a class="btn btn-info" href="javascript:;" id="j-btn-imageUpload"><i class="icon-folder-open icon-white"></i>本地上传</a>
                    <a class="btn btn-success" href="javascript:;" id="j-btn-imageManager"><i class="icon-picture icon-white"></i>素材库选择</a>
                    <span class="help-inline">上传过的图片可以直接从素材库选择</span>
                    <div class="clearfix" style="margin-top: 10px;">
                        <span class="thumbnail pull-left">
                            <img width="100" height="100" src="http://placehold.it/100x100" alt="" id="j-img-placehold">
                        </span>
                    </div>
                    <p style="margin-top:10px;"><b class="text-error">上传图片要求：100x100</b></p>
                </div>
            </div>

            <div class="control-group">
                <label class="control-label">支付描述</label>
                <div class="controls">
                    <textarea rows="4" id="j-desc"></textarea>
                </div>
            </div>

            <div class="control-group">
                <label class="control-label">支付宝用户账号</label>
                <div class="controls">
                    <input type="text" id="j-account" />
                </div>
            </div>

            <div class="control-group">
                <label class="control-label">支付宝安全校验码</label>
                <div class="controls">
                    <input type="text" id="j-checkcode" />
                </div>
            </div>

            <div class="control-group">
                <label class="control-label">合作者身份ID</label>
                <div class="controls">
                    <input type="text" id="j-identity" />
                </div>
            </div>

            <div class="control-group">
                <label class="control-label">支付宝账号类型</label>
                <div class="controls">
				    <select id="j-accounttype">
					    <option value="1">即时到账</option>
                        <option value="2">手机网站支付</option>
                        <option value="3">移动快捷支付</option>
				    </select>
                </div>
            </div>

            <div class="form-actions">
                <a href="javascript:void(0);" id="reset" class="btn"><i class="icon-ok icon-white"></i>清除重置</a>
                <a href="javascript:void(0);" id="save" class="btn btn-primary"><i class="icon-ok icon-white"></i>完成保存</a>
            </div>
        </div>

    </div>
    </div>

    <!--页面js-->
    <script charset="utf-8" src="<%=DomainUrl %>/Script/kindeditor/kindeditor-min.js"></script>
    <script charset="utf-8" src="<%=DomainUrl %>/Script/kindeditor/lang/zh_CN.js"></script>

    <script type="text/javascript">
        var MPage = {
            hander: "<%=DomainUrl %>/Handler/Platform/AnnouncementHandler.ashx?action=",
            init: function () {
                var mpage = this;

                //去掉之前选中打开的项 选中产品列表
                $("#sidebar li").removeClass("active open");
                $("#sidebar .sidebar_sys").addClass("active open").find(".sidebar_payment").addClass("active");

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
                });

                //绑定提交表单
                $("#save").bind("click", function () {
                    mpage.addPayment();
                    return false;
                });

                //绑定重置表单
                $("#reset").bind("click", function () {
                    mpage.clearPaymentInfo();
                    return false;
                });
            },

            clearPaymentInfo: function () {
                $("#j-title").val("");
                $('#j-img-placehold').attr("src", "http://placehold.it/128x128");
                $("#j-desc").val("");
                $("#j-account").val("");
                $("#j-checkcode").val("");
                $("#j-identity").val("");
                $("#j-accounttype").val(1);
            },

            addPayment: function () {
                var mpage = this;
                var name = $("#j-title").val().trim();
                var imgurl = $('#j-img-placehold').attr("src");
                var description = $("#j-desc").val().trim();
                var account = $("#j-account").val().trim();
                var privatekey = $("#j-checkcode").val().trim();
                var pid = $("#j-identity").val().trim();
                var accounttype = $("#j-accounttype").val();

                if (name == "") {
                    Common.tip({ type: "error", content: "支付方式名称不能为空" });
                    return;
                }
                if (imgurl == "") {
                    Common.tip({ type: "error", content: "支付Logo不能为空" });
                    return;
                }
                if (description == "") {
                    Common.tip({ type: "error", content: "支付描述不能为空" });
                    return;
                }
                if (account == "") {
                    Common.tip({ type: "error", content: "支付宝用户账号不能为空" });
                    return;
                }
                if (privatekey == "") {
                    Common.tip({ type: "error", content: "支付宝安全校验码不能为空" });
                    return;
                }
                if (pid == "") {
                    Common.tip({ type: "error", content: " 合作者身份ID不能为空" });
                    return;
                }

                $.post(mpage.hander + "addpayment", {
                    name: name, imgurl: imgurl, description: description
                    , account: account, privatekey: privatekey, pid: pid, accounttype: accounttype
                }, function (data) {
                    if (!data.error) {
                        Common.tip({ type: "success", content: data.success });
                    } else {
                        Common.tip({ type: "error", content: data.error });
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
