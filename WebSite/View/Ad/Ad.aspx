<%@ Page Title="" Language="C#" MasterPageFile="~/View/merchant.Master" AutoEventWireup="true" CodeBehind="Ad.aspx.cs" Inherits="Backstage.View.Ad.Ad" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Header" runat="server">
    <link rel="shortcut icon" href="<%=DomainUrl %>/Css/img/favicon.ico">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Content" runat="server">

    <div class="widget-box">
        <div class="widget-title">
            <span class="icon">
                <i class="icon-user"></i>
            </span>
            <h5>广告设置</h5>
        </div>
        <div class="widget-content">

            <div class="widget-box" id="j-home-ad">
                <div class="widget-title">
                    <h5>登录页大图广告</h5>
                </div>
                <div class="widget-content">
                    <form action="#" method="get" class="form-horizontal" id="j-ad-addForm" />
                    <div class="control-group">
                        <label class="control-label">图片 <b class="text-error">*640x1138</b></label>
                        <div class="controls">

                            <a class="btn btn-info j-btn-imageUpload" href="javascript:;"><i class="icon-folder-open icon-white"></i>本地上传</a>
                            <a class="btn btn-success j-btn-imageManager" href="javascript:;"><i class="icon-picture icon-white"></i>素材库选择</a>
                            <span class="help-inline">上传过的图片可以直接从素材库选择</span>
                            <div class="clearfix" style="margin-top: 10px;">
                                <span class="thumbnail pull-left">
                                    <img id="j-login-url" src="http://placehold.it/640x1138" width="200" height="356" alt="" class="j-img-placehold">
                                </span>
                            </div>
                            <p style="margin-top: 10px;"><b class="text-error">上传图片要求：640x1138</b></p>
                        </div>
                    </div>

                    <div class="control-group">
                        <label class="control-label">停留时间：</label>
                        <div class="controls">
                            <input onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')" id="j-login-delay" type="text" class="input-small j-ad-delay" />
                            秒
								
                        </div>
                    </div>

                    <div class="form-actions">
                        <a href="javascript:void(0);" id="saveloginad" class="btn btn-primary"><i class="icon-ok icon-white"></i>完成保存</a>
                    </div>
                </div>
            </div>

            <div class="widget-box">
                <div class="widget-title">
                    <h5>首页轮播广告</h5>
                </div>
                <div class="widget-content">
                    <div action="#" method="get" class="form-horizontal" id="j-homeslide-addForm" />

                    <div class="control-group">
                        <div class="controls">
                            <label class="inline">广告个数</label>
                            <input type="text" value="2" class="input-small" readonly="readonly" id="j-homeslide-count" />
                            个
									
                            <a href="javascript:;" title="增加一个" class="icon icon-plus-sign" id="j-homeslide-add_ad"></a>
                            <a href="javascript:;" title="减少一个" class="icon icon-minus-sign" id="j-homeslide-remove_ad"></a>
                            <label class="inline" style="margin-left: 20px;">停留时间</label>
                            <input onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')" type="text" class="input-small" id="j-homeslide-delay" value="1" />
                            秒
								
                        </div>
                    </div>

                    <div id="j-homeslide-ad">
                    </div>

                    <div class="form-actions">
                        <a href="javascript:void(0);" id="saveslidead" class="btn btn-primary"><i class="icon-ok icon-white"></i>完成保存</a>
                    </div>
                </div>

            </div>
        </div>

        <div class="widget-box">
            <div class="widget-title">
                <h5>wifi设备广告</h5>
            </div>
            <div class="widget-content">
                <div class="form-horizontal" id="j-wifi-addForm" />

                <div class="control-group">
                    <div class="controls">
                        <label class="inline">广告个数</label>
                        <input type="text" value="1" class="input-small" readonly="readonly" id="j-wifi_count" />
                        个
								
                    <a href="javascript:;" title="增加一个" class="icon icon-plus-sign" id="j-add_ad"></a>
                        <a href="javascript:;" title="减少一个" class="icon icon-minus-sign" id="j-remove_ad"></a>
                        <label class="inline" style="margin-left: 20px;">停留时间</label>
                        <input onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')" type="text" class="input-small" id="j-wifi-delay" value="1" />
                        秒
							
                    </div>
                </div>

                <div id="j-wifi-ad">
                </div>

                <div class="form-actions">
                    <a href="javascript:void(0);" id="savewifiad" class="btn btn-primary"><i class="icon-ok icon-white"></i>完成保存</a>
                </div>


            </div>
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

    <script type="text/jquery-tmpl-x" id="j-tmpl-wifi-ad-item">
		{{each(i, v) WifiAds}}
			<div style="border:1px solid #cdcdcd; background-color:#efefef;position:relative; margin-bottom:10px;" class="j-wifi-ad_item" data-id="${v.id}">
				<div class="control-group">
					<label class="control-label">广告图片</label>
					<div class="controls">
						<div class="clearfix">
							<span class="thumbnail pull-left" style="margin-right:10px;">
								<img src="${v.PicUrl}" height="130" width="313" alt="" class="j-img-placehold">
							</span>
                            <p style="margin-top:10px;"><b class="text-error">上传图片要求：540x224</b></p>
							<p><a class="btn btn-info j-btn-imageUpload" href="javascript:;"><i class="icon-folder-open icon-white"></i> 本地上传</a></p>
							<p><a class="btn btn-success j-btn-imageManager" href="javascript:;"><i class="icon-picture icon-white"></i> 素材库选择</a></p>
							<span class="help-inline">上传过的图片可以直接从素材库选择</span>
						</div>
					</div>
				</div>

				<div class="control-group">
					<label class="control-label">跳转至</label>
					<div class="controls">
						<input class="j-wifi-goto" type="text" value="${v.JumpUrl}">
					</div>
				</div>
                <a title="删除广告" href="javascript:;" class="j-btn-del btn btn-mini" style="position:absolute; right:10px; top:10px;"><i class="icon-remove"></i> 删除</a>
			</div>
                </div>
		{{/each}}
    </script>

    <script type="text/jquery-tmpl-x" id="j-tmpl-homeslide-ad-item">
		{{each(i, v) SlideAds}}
			<div style="border:1px solid #cdcdcd; background-color:#efefef;position:relative; margin-bottom:10px;" class="j-homeslide-ad-item" data-id="${v.id}">
				<div class="control-group">
					<label class="control-label">广告图片</label>
					<div class="controls">
						<div class="clearfix">
							<span class="thumbnail pull-left" style="margin-right:10px;">
								<img src="${v.img}" height="130" width="313" alt="" class="j-img-placehold">
							</span>
                            <p style="margin-top:10px;"><b class="text-error">上传图片要求：540x224</b></p>
							<p><a class="btn btn-info j-btn-imageUpload" href="javascript:;"><i class="icon-folder-open icon-white"></i> 本地上传</a></p>
							<p><a class="btn btn-success j-btn-imageManager" href="javascript:;"><i class="icon-picture icon-white"></i> 素材库选择</a></p>
							<span class="help-inline">上传过的图片可以直接从素材库选择</span>
						</div>
					</div>
				</div>

				<div class="control-group">
					<label class="control-label">跳转类型</label>
					<div class="controls">
						<select class="j-homeslide-goto-type">
							<option value="1" {{if v.type ==1 }}selected="selected"{{/if}}>图片墙</option>
							<option value="2" {{if v.type ==2 }}selected="selected"{{/if}}>活动</option>
							<option value="3" {{if v.type ==3 }}selected="selected"{{/if}}>产品</option>
						</select>

						<label class="inline" style="margin-left:20px;">ID：</label><input class="input-small j-homeslide-goto-id" type="text" value="${v.typeid}">
					</div>
				</div>

				<a title="删除广告" href="javascript:;" class="j-btn-del btn btn-mini" style="position:absolute; right:10px; top:10px;"><i class="icon-remove"></i> 删除</a>
			</div>
		{{/each}}
	</script>

    <script>
        var sellerId = '<%=SellerId%>';
        var MPage = {
            hander: "<%=DomainUrl %>/Handler/Merchant/UserHandler.ashx?sellerId=" + sellerId + "&action=",
            init: function () {
                var mpage = this;

                mpage.initForm();
            },

            initForm: function () {
                var mpage = this;

                //去掉之前选中打开的项 选中产品列表
                $("#sidebar li").removeClass("active open");
                $("#sidebar .sidebar_ad").addClass("active open");

                mpage.getInfo();
                mpage.bindForm();
            },
            //获取数据
            getInfo: function () {
                var mpage = this;

                $.post(mpage.hander + "getAdCfg", {}, function (data) {
                    if (!data.error) {
                        mpage.addLevel(data.data);
                        mpage.addHomeSlideLevel(data.data);
                        $("#j-login-url").attr("src", data.data.LoginAdUrl);
                        $("#j-login-delay").val(data.data.LoginAdStayTime);
                        $("#j-wifi-delay").val(data.data.WifiAdStayTime);
                        $("#j-wifi_count").val(data.data.WifiAds.length);

                        $("#j-homeslide-delay").val(data.data.SlideAdStayTime);
                        $("#j-homeslide-count").val(data.data.SlideAds.length);
                    } else {
                        Common.tip({ type: "error", content: data.error });
                    }
                }, "JSON");
            },
            //保存
            saveInfo: function (type) {
                var mpage = this;
                var imgs = "";
                var staytime = 1;
                var jumpurls = "";
                var types = "";
                var typeids = "";
                if (type == 0) {
                    //登录广告大图
                    var imglist = [];
                    var loginurl = $("#j-login-url").attr("src");
                    if (loginurl == "" || loginurl == "http://placehold.it/640x1138") {
                        Common.tip({ type: "error", content: "还没上传图片~" });
                        return;
                    }
                    staytime = $("#j-login-delay").val();
                    if (staytime == "") {
                        Common.tip({ type: "error", content: "还没填写停留时间~" });
                        return;
                    }
                    if (isNaN(staytime)) {
                        Common.tip({ type: "error", content: "输入的停留时间格式错误~" });
                        return;
                    }
                    imglist.push(loginurl);
                    //imglist.push($("#j-login-url").attr("src"));
                }
                else if (type == 1) {
                    var imglist = [];
                    $("#j-wifi-ad .j-img-placehold").each(function () {
                        var $item = $(this);
                        var url = $item.attr("src");
                        if (url == "" || url == "http://placehold.it/640x1138") {
                            Common.tip({ type: "error", content: "还没上传图片~" });
                            return;
                        }
                        imglist.push(url);
                    });
                    imgs = imglist.join(",");
                    staytime = $("#j-wifi-delay").val();
                    if (staytime == "") {
                        Common.tip({ type: "error", content: "还没填写停留时间~" });
                        return;
                    }
                    if (isNaN(staytime)) {
                        Common.tip({ type: "error", content: "输入的停留时间格式错误~" });
                        return;
                    }
                    var jumplist = [];
                    $("#j-wifi-ad .j-wifi-goto").each(function () {
                        var $item = $(this);
                        var url = $item.val();
                        if (url == "" || url == "http://placehold.it/640x1138") {
                            Common.tip({ type: "error", content: "跳转页面不能为空~" });
                            return;
                        }
                        jumplist.push(url);
                    });
                    jumpurls = jumplist.join(",");
                }
                else {
                    var imglist = [];
                    $("#j-homeslide-ad .j-img-placehold").each(function () {
                        var $item = $(this);
                        var url = $item.attr("src");
                        if (url == "" || url == "http://placehold.it/640x1138") {
                            Common.tip({ type: "error", content: "还没上传图片~" });
                            return;
                        }
                        imglist.push(url);
                    });
                    imgs = imglist.join(",");
                    staytime = $("#j-wifi-delay").val();
                    if (staytime == "") {
                        Common.tip({ type: "error", content: "还没填写停留时间~" });
                        return;
                    }
                    if (isNaN(staytime)) {
                        Common.tip({ type: "error", content: "输入的停留时间格式错误~" });
                        return;
                    }
                    var typelist = [];
                    $("#j-homeslide-ad .j-homeslide-goto-type").each(function () {
                        var $item = $(this);
                        var stype = $item.val();
                        if (stype == "" || stype == 0) {
                            Common.tip({ type: "error", content: "还没有选择类型~" });
                            return;
                        }
                        typelist.push(stype);
                    });
                    types = typelist.join(',');
                    var typeidlist = [];
                    $("#j-homeslide-ad .j-homeslide-goto-id").each(function () {
                        var $item = $(this);
                        var typeid = $item.val();
                        if (typeid == "") {
                            Common.tip({ type: "error", content: "还没填写相应类型ID~" });
                            return;
                        }
                        if (isNaN(typeid)) {
                            Common.tip({ type: "error", content: "输入ID格式不正确~" });
                            return;
                        }
                        typeidlist.push(typeid);
                    });
                    typeids = typeidlist.join(",");
                }

                $.post(mpage.hander + "saveAdCfg", { type: type, staytime: staytime, imgs: imgs, jumpurls: jumpurls, types: types, typeids: typeids }, function (data) {
                    if (!data.error) {
                        Common.tip({ type: "success", content: data.success });
                    } else {
                        Common.tip({ type: "error", content: data.error });
                    }
                }, "JSON");
            },

            bindForm: function () {
                var mpage = this;

                var image_editor,
                    image_editor_homeslide,
        			image_editor_wifi;
                KindEditor.ready(function (K) {
                    //图片上传编辑
                    mpage.image_editor = image_editor = K.editor({
                        uploadJson: '<%=DomainUrl %>/Handler/FileManager/UploadHandler.ashx?type=107&sellerid=' + sellerId,
                        fileManagerJson: '<%=DomainUrl %>/Handler/FileManager/FileManagerHandler.ashx?type=107&sellerid=' + sellerId,
                    });
                    //图片上传编辑
                    mpage.image_editor_homeslide = image_editor_homeslide = K.editor({
                        uploadJson: '<%=DomainUrl %>/Handler/FileManager/UploadHandler.ashx?type=108&sellerid=' + sellerId,
                        fileManagerJson: '<%=DomainUrl %>/Handler/FileManager/FileManagerHandler.ashx?type=108&sellerid=' + sellerId,
                    });
                    //图片上传编辑
                    mpage.image_editor_wifi = image_editor_wifi = K.editor({
                        uploadJson: '<%=DomainUrl %>/Handler/FileManager/UploadHandler.ashx?type=108&sellerid=' + sellerId,
                        fileManagerJson: '<%=DomainUrl %>/Handler/FileManager/FileManagerHandler.ashx?type=108&sellerid=' + sellerId,
                    });

                    //图片上传绑定
                    $('#j-home-ad .j-btn-imageManager').bind('click', function () {
                        var $item = $(this).parents(".controls");

                        image_editor.loadPlugin('filemanager', function () {
                            image_editor.plugin.filemanagerDialog({
                                viewType: 'VIEW',
                                dirName: 'image',
                                clickFn: function (url, title) {
                                    $item.find('.j-img-placehold').attr("src", url);
                                    image_editor.hideDialog();
                                }
                            });
                        });
                    });

                    //从资料库选择图片
                    $('#j-home-ad .j-btn-imageUpload').bind('click', function () {
                        var $item = $(this).parents(".controls");

                        image_editor.loadPlugin('image', function () {
                            image_editor.plugin.imageDialog({
                                showRemote: false,
                                clickFn: function (url, title, width, height, border, align) {
                                    $item.find('.j-img-placehold').attr("src", url);
                                    image_editor.hideDialog();
                                }
                            });
                        });
                    });
                });
                /**/
                $("#j-homeslide-add_ad").bind("click", function () {
                    var count = parseInt($("#j-homeslide-count").val()) || 0;

                    count++;
                    $("#j-homeslide-count").val(count);
                    mpage.addHomeSlideLevel({
                        SlideAds: [
                            {
                                img: "http://placehold.it/128x128"
                            }
                        ]
                    });
                });

                $("#j-homeslide-remove_ad").bind("click", function () {
                    var count = parseInt($("#j-homeslide-count").val()) || 0;
                    count--;
                    if (count < 0) {
                        count = 0;
                    }
                    $("#j-homeslide-count").val(count);
                    mpage.removeHomeSlideLevel();
                });

                $("#j-homeslide-ad").delegate(".j-btn-del", "click", function () {
                    var count = parseInt($("#j-homeslide-count").val()) || 0;
                    count--;
                    if (count < 0) {
                        count = 0;
                    }
                    $("#j-homeslide-count").val(count);
                    mpage.removeHomeSlideLevel($(this).parents(".j-homeslide-ad-item").index());
                });

                $("#j-add_ad").bind("click", function () {
                    var count = parseInt($("#j-wifi_count").val()) || 0;

                    count++;
                    $("#j-wifi_count").val(count);
                    mpage.addLevel({
                        WifiAds: [
                            {
                                PicUrl: "http://placehold.it/128x128"
                            }
                        ]
                    });

                    $(".j-btn-del").bind("click", function () {
                        var count = parseInt($("#j-wifi_count").val()) || 0;
                        count--;
                        if (count < 0) {
                            count = 0;
                        }
                        $("#j-wifi_count").val(count);
                        mpage.removeLevel($(this).parents(".j-wifi-ad_item").index());
                    });
                });

                $("#j-remove_ad").bind("click", function () {
                    var count = parseInt($("#j-wifi_count").val()) || 0;
                    count--;
                    if (count < 0) {
                        count = 0;
                    }
                    $("#j-wifi_count").val(count);
                    mpage.removeLevel();
                });

                //绑定提交表单
                $("#j-ad-addForm").bind("submit", function () {

                    alert('提交数据');
                    return false;
                });

                $("#savewifiad").bind("click", function () {
                    mpage.saveInfo(1);
                });

                $("#saveloginad").bind("click", function () {
                    mpage.saveInfo(0);
                });

                $("#saveslidead").bind("click", function () {
                    mpage.saveInfo(2);
                });
            },
            addHomeSlideLevel: function (data) {
                var mpage = this;
                //console.log(data);
                $("#j-homeslide-ad").append($("#j-tmpl-homeslide-ad-item").tmpl(data));

                //图片上传绑定
                $("#j-homeslide-ad").find('.j-btn-imageManager').unbind('click').bind('click', function () {
                    var $item = $(this).parents(".controls");

                    mpage.image_editor_homeslide.loadPlugin('filemanager', function () {
                        mpage.image_editor_homeslide.plugin.filemanagerDialog({
                            viewType: 'VIEW',
                            dirName: 'image',
                            clickFn: function (url, title) {
                                $item.find('.j-img-placehold').attr("src", url);
                                mpage.image_editor_homeslide.hideDialog();
                            }
                        });
                    });
                });

                //从资料库选择图片
                $("#j-homeslide-ad").find('.j-btn-imageUpload').unbind('click').bind('click', function () {
                    var $item = $(this).parents(".controls");

                    mpage.image_editor_homeslide.loadPlugin('image', function () {
                        mpage.image_editor_homeslide.plugin.imageDialog({
                            showRemote: false,
                            clickFn: function (url, title, width, height, border, align) {
                                $item.find('.j-img-placehold').attr("src", url);
                                mpage.image_editor_homeslide.hideDialog();
                            }
                        });
                    });
                });
            },

            removeHomeSlideLevel: function (index) {
                console.log(index);
                if (typeof index == "number") {
                    $("#j-homeslide-ad .j-homeslide-ad-item").eq(index).remove();
                } else {
                    $("#j-homeslide-ad .j-homeslide-ad-item").last().remove();
                }

            },
            addLevel: function (data) {
                var mpage = this;

                //console.log(data);
                $("#j-wifi-ad").append($("#j-tmpl-wifi-ad-item").tmpl(data));

                //图片上传绑定
                $("#j-wifi-ad").find('.j-btn-imageManager').unbind('click').bind('click', function () {
                    var $item = $(this).parents(".controls");

                    mpage.image_editor_wifi.loadPlugin('filemanager', function () {
                        mpage.image_editor_wifi.plugin.filemanagerDialog({
                            viewType: 'VIEW',
                            dirName: 'image',
                            clickFn: function (url, title) {
                                $item.find('.j-img-placehold').attr("src", url);
                                mpage.image_editor_wifi.hideDialog();
                            }
                        });
                    });
                });

                //从资料库选择图片
                $("#j-wifi-ad").find('.j-btn-imageUpload').unbind('click').bind('click', function () {
                    var $item = $(this).parents(".controls");

                    mpage.image_editor_wifi.loadPlugin('image', function () {
                        mpage.image_editor_wifi.plugin.imageDialog({
                            showRemote: false,
                            clickFn: function (url, title, width, height, border, align) {
                                $item.find('.j-img-placehold').attr("src", url);
                                mpage.image_editor_wifi.hideDialog();
                            }
                        });
                    });
                });

                $(".j-btn-del").unbind("click").bind("click", function () {
                    var count = parseInt($("#j-wifi_count").val()) || 0;
                    count--;
                    if (count < 0) {
                        count = 0;
                    }
                    $("#j-wifi_count").val(count);
                    mpage.removeLevel($(this).parents(".j-wifi-ad_item").index());
                });
            },

            removeLevel: function (index) {
                if (typeof index == "number") {
                    if (index < 0) return;
                    $("#j-wifi-ad .j-wifi-ad_item").eq(index).remove();
                } else {
                    $("#j-wifi-ad .j-wifi-ad_item").last().remove();
                }
            }
        };

        $(function () {
            MPage.init();
        });

    </script>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Footer" runat="server">
</asp:Content>


