<%@ Page Title="" Language="C#" MasterPageFile="~/View/DevMaster.Master" AutoEventWireup="true" CodeBehind="SystemInfo.aspx.cs" Inherits="Backstage.View.Dev.System.SystemInfo" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Header" runat="server">
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
            
            <form action="#" method="get" class="form-horizontal" id="j-profile-form">

            <div class="control-group">
               
                <label class="control-label">模式A扣率</label>
                <div class="controls">
                    <input type="text" id="j-pattern-a" value="<%=SignList.First().Prec %>" class="input-small" />
                    <label class="col3-label">模式B扣率</label>
                    <input type="text" id="j-pattern-b" value="<%=SignList.ElementAt(1).Prec %>" class="input-small" />
                    <label class="col3-label">模式C扣率</label>
                    <input type="text" id="j-pattern-c" value="<%=SignList.ElementAt(2).Prec %>" class="input-small" />
                </div>
            </div>
            <div class="form-actions">
                <button type="reset" class="btn"><i class="icon-refresh"></i>清除重置</button>
                <button type="submit" class="btn btn-primary"><i class="icon-ok icon-white"></i>完成保存</button>
            </div>
            </form>
			
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Footer" runat="server">


    <!--页面js-->
    <script charset="utf-8" src="<%=DomainUrl %>/script/kindeditor/kindeditor-min.js"></script>
    <script charset="utf-8" src="<%=DomainUrl %>/script/kindeditor/lang/zh_CN.js"></script>

    <script type="text/javascript">
        var MPage = {
            init: function () {
                var mpage = this;
                //去掉之前选中打开的项 选中产品列表
                $("#sidebar li").removeClass("active open");
                $("#sidebar .sidebar_sys").addClass("active open").find(".sidebar_systeminfo").addClass("active");

                //var text_editor,
                //    image_editor;
                //KindEditor.ready(function (K) {
                //    //文本编辑器
                //    mpage.text_editor = text_editor = K.create('textarea[name="content"]', {
                //        uploadJson: '../public/kindeditor/php/upload_json.php',
                //        allowFileManager: true
                //    });

                //    //图片上传编辑
                //    mpage.image_editor = image_editor = K.editor({
                //        uploadJson: '../public/kindeditor/php/upload_json.php',
                //        fileManagerJson: '../public/kindeditor/php/file_manager_json.php'
                //    });

                //    //图片上传绑定
                //    K('#j-btn-imageManager_logo,#j-btn-imageManager_qrcode').click(function () {
                //        var $btn = $(this);

                //        image_editor.loadPlugin('filemanager', function () {
                //            image_editor.plugin.filemanagerDialog({
                //                viewType: 'VIEW',
                //                dirName: 'image',
                //                clickFn: function (url, title) {
                //                    $btn.parents(".controls").find(".thumbnail img").attr("src", url);
                //                    image_editor.hideDialog();
                //                }
                //            });
                //        });
                //    });

                //    //从资料库选择图片
                //    K('#j-btn-imageUpload_logo,#j-btn-imageUpload_qrcode').click(function () {
                //        var $btn = $(this);
                //        image_editor.loadPlugin('image', function () {
                //            image_editor.plugin.imageDialog({
                //                showRemote: false,
                //                clickFn: function (url, title, width, height, border, align) {
                //                    $btn.parents(".controls").find(".thumbnail img").attr("src", url);
                //                    image_editor.hideDialog();
                //                }
                //            });
                //        });
                //    });
                //});


                //绑定提交表单
                $("#j-profile-form").bind("submit", function () {
                    var save_data = {
                        first: $("#j-pattern-a").val(),
                        second: $("#j-pattern-b").val(),
                        third: $("#j-pattern-c").val()
                    }

                    $.ajax({
                        url: "<%=DomainUrl %>/Handler/Backstage/DevSystemHandler.ashx?action=styleinfo",
                        data: save_data,
                        type: "post"
                    }).success(function (data) {
                        alert("保存成功！");
                    });
                    return false;
                });

                //绑定重置表单
                $("#j-profile-form").bind("reset", function () {
                    $("#j-pattern-a").val("");
                    $("#j-pattern-b").val("");
                    $("#j-pattern-c").val("");
                    //$('#j-img-placehold').attr("src", 'http://placehold.it/128x128');
                    //mpage.text_editor.html('');
                    return false;
                });
            }
        }

        $(function () {
            MPage.init();
        });

        </script>
</asp:Content>
