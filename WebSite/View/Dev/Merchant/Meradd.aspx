<%@ Page Title="" Language="C#" MasterPageFile="~/View/DevMaster.Master" AutoEventWireup="true" CodeBehind="Meradd.aspx.cs" Inherits="Backstage.View.Dev.Merchant.Meradd" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Header" runat="server">
    <link rel="shortcut icon" href="<%=DomainUrl %>/Css/img/favicon.ico">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Content" runat="server">


    <div class="widget-box">
        <div class="widget-title">
            <span class="icon">
                <i class="icon-gift"></i>
            </span>
            <h5>新增商户</h5>
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
                                    <img width="60" height="60" src="http://placehold.it/300x300" alt="" id="j-img-placehold">
                                </span>
                            </div>
                            <p style="margin-top:10px;"><b class="text-error">上传图片要求：300x300</b></p>
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
                            <span class="static-text" id="j_user_createtime">2014-02-12</span>
                        </div>
                    </div>

                    <div class="control-group">
                        <label class="control-label">服务期至</label>
                        <div class="controls">
                            <span class="static-text" id="j_mer_serverendtime">2014-02-12</span>
                            <a href="javascript:void(0);" id="j_add_oneyear" class="btn btn-primary btn-mini"><i class="icon-plus icon-white"></i>增加一年</a>
                            <a href="javascript:void(0);" id="j_sub_oneyear" class="btn btn-primary btn-mini"><i class="icon-minus icon-white"></i>减少一年</a>
                        </div>
                    </div>
                    <div class="control-group">
						<label class="control-label">是否使用【易wifi】</label>
						<div class="controls">
							<label class="checkbox"><input type="checkbox" id="j-is_wifi"> 使用</label>
						</div>
					</div>

					<div id="j-wifi_hold" style="display:none;">
						<div class="control-group">
				            <label class="control-label">wifi账号</label>
				            <div class="controls">
				                <input type="text" id="j-wifi-account">
				            </div>
				        </div>
			        </div>

					<div class="control-group">
						<label class="control-label">是否使用【云打印】</label>
						<div class="controls">
							<label class="checkbox"><input type="checkbox" id="j-is_print"> 使用</label>
						</div>
					</div>

					<div id="j-print_hold" style="display:none;">
						<div class="control-group">
				            <label class="control-label">终端号</label>
				            <div class="controls">
				                <input type="text" id="j-profile-machinecode">
				            </div>
				        </div>

	                    <div class="control-group">
				            <label class="control-label">密   钥</label>
				            <div class="controls">
				                <input type="text" id="j-profile-machinekey">
				            </div>
				        </div>
					</div>

					<div class="control-group">
						<label class="control-label">是否启用配送功能</label>
						<div class="controls">
							<label class="checkbox"><input type="checkbox" id="j-is_delivery"> 启用</label>
						</div>
					</div>
                    <%--<div class="control-group">
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
                        <label class="control-label">配送</label>
                        <div class="controls">
                            <label class="checkbox">
                                <input type="checkbox" id="j-is_delivery">
                                是否开启【配送功能】</label>
                        </div>
                    </div>--%>

                    <div class="control-group">
                        <label class="control-label">签约模式</label>
                        <div class="controls">
                            <select id="j-sign-list">
                            </select>
                        </div>
                    </div>

                    <div class="control-group">
                        <label class="control-label">开发人员</label>
                        <div class="controls">
                            <input type="text" id="j-dev-name" />
                        </div>
                    </div>

                    <%--<div class="control-group">
                        <label class="control-label">wifi账号</label>
                        <div class="controls">
                            <input type="text" id="j-wifi-account" />
                        </div>
                    </div>--%>
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
                            <input type="text" id="j-profile-phone" class="input-medium1" />
							<label class="col2-label">管理人联系电话</label>
							<input type="text" id="j-profile-admin_phone" class="input-medium1" />
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
							<input type="text" id="j-profile-wechat_id"  class="input-medium1"/>
							<label class="col2-label">服务QQ号</label>
							<input type="text" id="j-profile-qq"  class="input-medium1"/>
                        </div>
                    </div>

                    <%--<div class="control-group">
						<label class="control-label">IOS地址</label>
						<div class="controls">
							<input type="text" id="j-profile-iosurl" />
						</div>
					</div>

					<div class="control-group">
						<label class="control-label">安卓地址</label>
						<div class="controls">
							<input type="text" id="j-profile-androidurl" />
						</div>
					</div>--%>
							

					<div class="control-group">
						<label class="control-label">其他备注</label>
						<div class="controls">
							<input type="text" id="j-profile-note" />
						</div>
					</div>
                </div>
            </div>
            
            <div class="widget-box" >
					<div class="widget-title">
						<h5>软件版本更新（还未上传软件时，版本号不需要填写！）</h5>
					</div>
					<div class="widget-content">

						<div class="control-group">
							<label class="control-label">IOS地址</label>
							<div class="controls">
								<input readonly="readonly"  type="text" id="j-profile-iosurl"  class="input-medium2" />

								<label class="inline" style="margin-left:28px;margin-right:15px;">版本号</label>
								<input onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')" type="text" id="j-profile-iosurl-ver"  class="input-small"/>
								<a class="btn btn-info" href="javascript:;" id="j-btn-iosUpload"><i class="icon-folder-open icon-white"></i> 本地上传</a>
							</div>
						</div>

						<div class="control-group">
							<label class="control-label">安卓地址</label>
							<div class="controls">
								<input readonly="readonly" type="text" id="j-profile-androidurl"  class="input-medium2" />
								<label class="inline" style="margin-left:28px;margin-right:15px;">版本号</label>
								<input onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')" type="text" id="j-profile-androidurl-ver"  class="input-small"/>
								<a class="btn btn-info" href="javascript:;" id="j-btn-androidUpload"><i class="icon-folder-open icon-white"></i> 本地上传</a>
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
                        <label class="control-label">活动资讯</label>
                        <div class="controls">
                            <input type="text" id="j_name_activity" class="input-small" value="活动资讯" />

							<label class="col3-label">商品展示</label>
							<input type="text" id="j_name_goods" value="商品展示" class="input-small" />

							<label class="col3-label">快速预约</label>
							<input type="text" id="j_name_appointment" value="快速预约" class="input-small" />
                        </div>
                    </div>

                    <%--<div class="control-group">
                        <label class="control-label">商品展示</label>
                        <div class="controls">
                            <input type="text" id="j_name_goods" value="商品展示" />
                        </div>
                    </div>

                    <div class="control-group">
                        <label class="control-label">快速预约</label>
                        <div class="controls">
                            <input type="text" id="j_name_appointment" value="快速预约" />
                        </div>
                    </div>--%>

                    <div class="control-group">
                        <label class="control-label">图片墙</label>
                        <div class="controls">
                            <input type="text" id="j_name_img" value="图片墙" class="input-small" />
							<label class="col3-label">包厢</label>
							<input type="text" id="j_name_box" value="包厢" class="input-small" />
                        </div>
                    </div>

                    <%--<div class="control-group">
                        <label class="control-label">包厢</label>
                        <div class="controls">
                            <input type="text" id="j_name_box" value="包厢" />
                        </div>
                    </div>--%>
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
    <script type="text/jquery-tmpl-x" id="j-tmpl-sign-listitem">
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

        var Sign_List = [
            {
                Id: 1,
                Name: "签约A",
                Pre: 7
            },
            {
                Id: 1,
                Name: "签约B",
                Pre: 8
            },
            {
                Id: 1,
                Name: "签约C",
                Pre: 10
            }
        ];
    </script>
    <script type="text/javascript">
        var onlyDomainUrl = '<%=OnlyDomainUrl%>';
        var MPage = {
            merchantid: 0,
            merchantdata: {},
            hander: "<%=DomainUrl %>/Handler/Platform/AnnouncementHandler.ashx?action=",
            init: function () {
                var mpage = this;

                //去掉之前选中打开的项 选中产品列表
                $("#sidebar li").removeClass("active open");
                $("#sidebar .sidebar_merchant").addClass("active open").find(".sidebar_addmer").addClass("active");

                $.post(MPage.hander + "getCfgList", { type: 1 }, function (data) {
                    if (!data.error) {
                        Shop_SubCategory = data.mertypelist;
                        Template_List = data.templelist;
                        Sign_List = data.signlist;
                        mpage.showSubCategoryList();

                        $("#j_user_createtime").html(data.nowdate);
                        $("#j_mer_serverendtime").html(data.serverdata);
                    } else {
                        Common.tip({ type: "error", content: data.error });
                    }
                }, "JSON");

                var file_editor,
                    image_editor;
                KindEditor.ready(function (K) {
                    //文本编辑器
                    <%--mpage.text_editor = text_editor = K.create('textarea[name="content"]', {
                        uploadJson: '<%=DomainUrl %>/Handler/FileManager/UploadHandler.ashx?type=3',
                        allowFileManager: true
                    });--%>

                    //图片上传编辑
                    mpage.image_editor = image_editor = K.editor({
                        uploadJson: '<%=DomainUrl %>/Handler/FileManager/UploadHandler.ashx?type=0',
                        fileManagerJson: '<%=DomainUrl %>/Handler/FileManager/FileManagerHandler.ashx?type=0',
                    });

                    //图片上传编辑
                    mpage.file_editor = file_editor = K.editor({
                        uploadJson: '<%=DomainUrl %>/Handler/FileManager/UploadHandler.ashx?type=0',
                        fileManagerJson: '<%=DomainUrl %>/Handler/FileManager/FileManagerHandler.ashx?type=0',
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


                    K('#j-btn-iosUpload').click(function () {
                        file_editor.loadPlugin('insertfile', function () {
                            file_editor.plugin.fileDialog({
                                showRemote: false,
                                clickFn: function (url, title) {
                                    //console.log(url, title);
                                    K('#j-profile-iosurl').val(onlyDomainUrl+url);
                                    file_editor.hideDialog();
                                }
                            });
                        });
                    });

                    K('#j-btn-androidUpload').click(function () {
                        file_editor.loadPlugin('insertfile', function () {
                            file_editor.plugin.fileDialog({
                                showRemote: false,
                                clickFn: function (url, title) {
                                    //console.log(url, title);
                                    K('#j-profile-androidurl').val(onlyDomainUrl + url);
                                    file_editor.hideDialog();
                                }
                            });
                        });
                    });
                });

                //增加一年
                $("#j_add_oneyear").bind("click", function () {
                    var date = $('#j_mer_serverendtime').html();
                    var d = new Date(date);
                    d.setYear(d.getFullYear() + 1);
                    $('#j_mer_serverendtime').html(d.Format("yyyy-MM-dd"));
                    return false;
                });
                //减少一年
                $("#j_sub_oneyear").bind("click", function () {
                    var date = $('#j_mer_serverendtime').html();
                    var d = new Date(date);
                    d.setYear(d.getFullYear() - 1);
                    $('#j_mer_serverendtime').html(d.Format("yyyy-MM-dd"));
                    return false;
                });

                //提交表单
                $("#save").bind("click", function () {
                    mpage.addMerchant();
                });

                //重置表单
                $("#reset").bind("click", function () {
                    mpage.clearMerchantData();
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

                $("#j-is_wifi").bind("change", function () {
                    if ($(this).attr("checked")) {
                        $("#j-wifi_hold").show();
                    } else {
                        $("#j-wifi_hold").hide();
                    }
                });

                $("#j-is_print").bind("change", function () {
                    if ($(this).attr("checked")) {
                        $("#j-print_hold").show();
                    } else {
                        $("#j-print_hold").hide();
                    }
                });

            },

            clearMerchantData: function () {
                var mpage = this;

                $("#j-shop-name").val("");
                $("#j-login-name").val("");
                $('#j-img-placehold').attr("src", "http://placehold.it/128x128");
                $("#j-subCategory-list").val(0).trigger("change");
                $('#j_user_createtime').html(new Date().Format("yyyy-MM-dd"));
                $('#j_mer_serverendtime').html(new Date().Format("yyyy-MM-dd"));
                $("#j-is_wifi").removeAttr("checked");
                $("#j-is_print").removeAttr("checked");
                $("#j-sign-list").val(1);

                $("#j-profile-phone").val("");
                $("#j-profile-admin_phone").val("");
                $("#j-profile-address").val("");
                $("#j-profile-wechat_id").val("");
                $("#j-profile-qq").val("");
                $("#j-profile-email").val("");
                $("#j_name_activity").val("活动资讯");
                $("#j_name_goods").val("商品展示");
                $("#j_name_appointment").val("快速预约");
                $("#j_name_img").val("图片墙");
                $("#j_name_box").val("包厢");
            },


            showSubCategoryList: function () {
                var mpage = this;
                $("#j-subCategory-list").html($("#j-tmpl-category-listitem").tmpl({
                    list: Shop_SubCategory
                }));
                $("#j-sign-list").html($("#j-tmpl-sign-listitem").tmpl({
                    list: Sign_List
                }));
            },

            addMerchant: function () {
                var mpage = this;

                var data_save = {};
                data_save.Id = mpage.merchantid;
                data_save.Name = $("#j-shop-name").val().trim();
                data_save.UserName = $("#j-login-name").val().trim();
                data_save.LogoUrl = $('#j-img-placehold').attr("src");
                data_save.Mid = $("#j-subCategory-list").val();
                data_save.Tid = $("#j-template-list").val();
                data_save.CreateTime = new Date($('#j_user_createtime').html());
                data_save.ServerEndTime = new Date($('#j_mer_serverendtime').html());
                data_save.HasWifi = $("#j-is_wifi").attr("checked") == "checked" ? 1 : 0;
                data_save.WifiAccount = $("#j-wifi-account").val();
                data_save.HasPrint = $("#j-is_print").attr("checked") == "checked" ? 1 : 0;
                data_save.HasDelivery = $("#j-is_delivery").attr("checked") == "checked" ? 1 : 0;
                data_save.Sid = $("#j-sign-list").val();
                data_save.DevName = $("#j-dev-name").val();
                data_save.Phone = $("#j-profile-phone").val().trim();
                data_save.ManagerPhone = $("#j-profile-admin_phone").val().trim();
                data_save.Address = $("#j-profile-address").val().trim();
                data_save.WinXinAccount = $("#j-profile-wechat_id").val().trim();
                data_save.Qq = $("#j-profile-qq").val().trim();
                data_save.Note = $("#j-profile-note").val().trim();
                data_save.IosUrl = $("#j-profile-iosurl").val().trim();
                data_save.AndroidUrl = $("#j-profile-androidurl").val().trim();
                data_save.IosVer = $("#j-profile-iosurl-ver").val().trim();
                data_save.AndroidVer = $("#j-profile-androidurl-ver").val().trim();
                data_save.MachineCode = $("#j-profile-machinecode").val().trim();
                data_save.MachineKey = $("#j-profile-machinekey").val().trim();
                data_save.CnameList = [
                    $("#j_name_activity").val().trim(),
                    $("#j_name_goods").val().trim(),
                    $("#j_name_appointment").val().trim(),
                    $("#j_name_img").val().trim(),
                    $("#j_name_box").val().trim()
                ];
                

                if (data_save.Name == "") {
                    Common.tip({ type: "error", content: "商户名称不能为空" });
                    return;
                }
                if (data_save.UserName == "") {
                    Common.tip({ type: "error", content: "商户登录名不能为空" });
                    return;
                }
                if (data_save.Mid == 0) {
                    Common.tip({ type: "error", content: "请选择商户类型" });
                    return;
                }
                if (data_save.LogoUrl == "" ||
                    data_save.LogoUrl == "http://placehold.it/128x128") {
                    Common.tip({ type: "error", content: "商户logo不能为空" });
                    return;
                }
                if (data_save.CreateTime >= data_save.ServerEndTime) {
                    Common.tip({ type: "error", content: "服务期截止时间不能小于等于入驻时间" });
                    return;
                }
                if (data_save.DevName == "") {
                    Common.tip({ type: "error", content: "开发员不能为空" });
                    return;
                }
                if (!/[0-9A-Za-z]/.test(data_save.DevName)) {
                    alert('开发人员格式输入错误');
                    return false;
                }
                if (data_save.HasWifi == 1 && data_save.WifiAccount == "") {
                    Common.tip({ type: "error", content: "WiFi账号不能为空" });
                    return;
                }
                if (data_save.Phone == "") {
                    Common.tip({ type: "error", content: "联系电话不能为空" });
                    return;
                }
                if (data_save.ManagerPhone == "") {
                    Common.tip({ type: "error", content: "管理人联系电话不能为空" });
                    return;
                }
                if (data_save.Address == "") {
                    Common.tip({ type: "error", content: "联系地址不能为空" });
                    return;
                }
                if (data_save.WinXinAccount == "") {
                    Common.tip({ type: "error", content: "微信公众号不能为空" });
                    return;
                }
                if (data_save.Qq == "") {
                    Common.tip({ type: "error", content: "服务QQ不能为空" });
                    return;
                }
                if (data_save.Email == "") {
                    Common.tip({ type: "error", content: "Email不能为空" });
                    return;
                }
                //if (data_save.IosUrl == "") {
                //    Common.tip({ type: "error", content: "Ios地址不能为空，请点击右边的本地上传" });
                //    return;
                //}
                //if (data_save.AndroidUrl == "") {
                //    Common.tip({ type: "error", content: "安卓地址不能为空，请点击右边的本地上传" });
                //    return;
                //}
                if (data_save.IosUrl != "" && data_save.IosVer == "") {
                    Common.tip({ type: "error", content: "Ios版本号不能为空" });
                    return;
                }
                if (data_save.IosVer != "" && isNaN(data_save.IosVer)) {
                    alert("Ios版本号应为数字，例如1");
                    return;
                }
                if (data_save.AndroidUrl != "" && data_save.AndroidVer == "") {
                    Common.tip({ type: "error", content: "安卓版本号不能为空" });
                    return;
                }
                if (data_save.AndroidVer != "" && isNaN(data_save.AndroidVer)) {
                    alert("Android版本号应为数字，例如1");
                    return;
                }
                if (data_save.HasPrint == 1 && data_save.MachineCode == "") {
                    Common.tip({ type: "error", content: "打印机终端号不能为空" });
                    return;
                }
                if (data_save.HasPrint == 1 && data_save.MachineKey == "") {
                    Common.tip({ type: "error", content: "打印机密钥不能为空" });
                    return;
                }

                $.post(mpage.hander + "saveMerchant", { data_save: JSON.stringify(data_save) }, function (data) {
                    if (!data.error) {
                        Common.tip({ type: "success", content: data.success });
                        window.location.href = "<%=DomainUrl %>/View/Dev/Merchant/Merlist.aspx";
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
