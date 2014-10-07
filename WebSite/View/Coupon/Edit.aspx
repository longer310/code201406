<%@ Page Title="" Language="C#" MasterPageFile="~/View/merchant.Master" AutoEventWireup="true" CodeBehind="Edit.aspx.cs" Inherits="Backstage.View.Coupon.Edit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Header" runat="server">
    <!--页面样式-->
    <link href="../public/kindeditor/themes/default/default.css" type="text/css" rel="stylesheet" />
    <link href="../public/css/datepicker.css" type="text/css" rel="stylesheet" />
    <link href="../public/css/select2.css" type="text/css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Content" runat="server">
    <div class="widget-box">
        <div class="widget-title">
            <span class="icon">
                <i class="icon-tags"></i>
            </span>
            <h5>编辑电子券</h5>
        </div>
        <div class="widget-content">
            <form action="#" method="get" class="form-horizontal" id="j-ticket-addForm" />
            <div class="control-group">
                <label class="control-label">名称</label>
                <div class="controls">
                    <input type="text" id="j-ticket-title" />
                </div>
            </div>

            <div class="control-group">
                <label class="control-label">有效期</label>
                <div class="controls">
                    <input type="text" data-date="12-02-2012" data-date-format="dd-mm-yyyy" value="12-02-2012" class="input-medium j-datepicker" id="j-ticket-expire_date" />
                    <label class="checkbox inline">
                        <input type="checkbox" id="j-ticket-date_forever">
                        长期有效</label>
                </div>
            </div>

            <div class="control-group">
                <label class="control-label">活动图片</label>
                <div class="controls">

                    <a class="btn btn-info" href="javascript:;" id="j-btn-imageUpload"><i class="icon-folder-open icon-white"></i>本地上传</a>
                    <a class="btn btn-success" href="javascript:;" id="j-btn-imageManager"><i class="icon-picture icon-white"></i>素材库选择</a>
                    <span class="help-inline">上传过的图片可以直接从素材库选择</span>
                    <div class="clearfix" style="margin-top: 10px;">
                        <span class="thumbnail pull-left">
                            <img src="http://placehold.it/540x400" width="180" height="133" alt="" id="j-img-placehold">
                        </span>
                    </div>
                    <p style="margin-top:10px;"><b class="text-error">上传图片要求：540x400</b></p>
                </div>
            </div>

            <div class="control-group">
                <label class="control-label">兑换所需积分</label>
                <div class="controls">
                    <input type="text" id="j-ticket-score" class="input-medium" />
                </div>
            </div>

            <div class="control-group">
                <label class="control-label">兑换所需积分</label>
                <div class="controls">
                    满
                    <input type="text" id="j-ticket-total" class="input-small" />
                    元，减
                    <input type="text" id="j-ticket-discount" class="input-small" />
                    元
						
                </div>
            </div>

            <div class="control-group">
                <label class="control-label">限定使用商品</label>
                <div class="controls">
                    <div class="select2-container select2-container-multi select2-dropdown-open" id="j-goods-select">
                        <ul class="select2-choices" id="j-goods-selected">
                        </ul>
                        <div class="fixed-modal" id="j-goods-selectModal" style="display: none;">
                            <div class="modal-header">
                                <a data-dismiss="modal" class="close" href="javascript:;">×</a>
                                <h3>选择限定使用的商品</h3>
                            </div>
                            <div class="modal-body">
                                <ul class="activity-list" id="j-goods-list">
                                </ul>
                            </div>
                            <div class="modal-footer">
                                <div class="pagination alternate" id="j-goods-pagination">
                                    <ul class="page-main">
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="control-group">
                <label class="control-label">使用说明</label>
                <div class="controls">
                    <textarea name="content" style="height: 400px; visibility: hidden;"></textarea>
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
    <script src="../../script/js/ue.pager.js"></script>
    <script src="../../script/js/bootstrap-datepicker.js"></script>

    <script charset="utf-8" src="../../script/kindeditor/kindeditor-min.js"></script>
    <script charset="utf-8" src="../../script/kindeditor/lang/zh_CN.js"></script>

    <script type="text/jquery-tmpl-x" id="j-tmpl-goods-selecteditem">
			{{each(i, v) goods_selected}}
				<li class="select2-search-choice" data-id="${v.id}">
					<div class="j-title">${v.title}</div>
					<a href="javascript:;" class="select2-search-choice-close j-btn-del"></a>
				</li>
			{{/each}}
		</script>


    <script type="text/jquery-tmpl-x" id="j-tmpl-goods-listitem">
        	{{each(i, v) list}}
	        	<li data-id="${v.id}"><a href="#" class="j-title">${v.title}</a></li>
			{{/each}}
        </script>

    <script type="text/javascript">
        var sellerId = '<%=SellerId%>';
        var ticket_id = '<%=Id%>';
        var MPage = {
            init: function () {
                var mpage = this;

                var text_editor,
                    image_editor;
                KindEditor.ready(function (K) {
                    //文本编辑器
                    mpage.text_editor = text_editor = K.create('textarea[name="content"]', {
                        uploadJson: '<%=DomainUrl %>/Handler/FileManager/UploadHandler.ashx?type=106&sellerid=' + sellerId,
                         allowFileManager: true
                     });

                    //图片上传编辑
                    mpage.image_editor = image_editor = K.editor({
                        uploadJson: '<%=DomainUrl %>/Handler/FileManager/UploadHandler.ashx?type=106&sellerid=' + sellerId,
                        fileManagerJson: '<%=DomainUrl %>/Handler/FileManager/FileManagerHandler.ashx?type=0&sellerid=' + sellerId,
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

                    if (ticket_id) {
                        mpage.getTicketDetail(ticket_id);
                    } else {
                        alert("该电子券不存在");
                        window.history.back();
                    }
                });

                $('.j-datepicker').datepicker();

                $("#j-ticket-date_forever").bind("change", function () {
                    if ($(this).attr("checked")) {
                        $("#j-ticket-expire_date").attr("disabled", "disabled");
                    } else {
                        $("#j-ticket-expire_date").removeAttr("disabled");
                    }
                });

                //绑定选择商品
                $("#j-goods-select").bind("click", function () {
                    mpage.getGoodsList(1);
                    $('#j-goods-selectModal').show();
                });

                $('#j-goods-selectModal .close').bind("click", function () {
                    $('#j-goods-selectModal').hide()
                    return false;
                });

                $("#j-goods-selected").delegate(".j-btn-del", "click", function () {
                    $(this).parents("li").remove();
                    return false;
                });

                //绑定提交表单
                $("#j-ticket-addForm").bind("submit", function () {


                    //限定的商品
                    var goods_selected = [];

                    $("#j-goods-selected li").each(function () {
                        var $item = $(this),
                            id = $item.attr("data-id");

                        goods_selected.push(id);
                    });

                    var save_data = {
                        title: $.trim($("#j-ticket-title").val()),
                        expire_date: $("#j-ticket-date_forever").attr("checked") ? -1 : $("#j-ticket-expire_date").val(),
                        thumbnail: $('#j-img-placehold').attr("src"),
                        score: $("#j-ticket-score").val(),
                        total: $("#j-ticket-total").val(),
                        discount: $("#j-ticket-discount").val(),
                        goods_selected: goods_selected,
                        text: $.trim(text_editor.text()),
                        content: text_editor.html()
                    }
                    $.ajax({
                        url: "../../Handler/Backstage/CouponHandler.ashx?action=update",
                        data: save_data,
                        type: "POST",
                        dataType: "json"
                        //context: document.body
                    }).success(function (data) {
                        alert("更新成功");
                        window.location.href = "List.aspx?sellerId=" + sellerId;
                        //window.setTimeout(function () {
                        //    window.location.reload();
                        //}, 2000);
                    });
                    return false;
                });

                //绑定重置表单
                $("#j-ticket-addForm").bind("reset", function () {
                    mpage.setFormData();
                    return false;
                });
            },

            getTicketDetail: function (id) {
                var mpage = this;

                //$.getJSON("", { id: ticket_id}， function(json){
                var json = {
                    code: 0,
                    msg: "",
                    result: {
                        title: '电子券名称',
                        expire_date: -1,
                        thumbnail: 'http://placehold.it/128x128',
                        score: 50,
                        total: 100,
                        discount: 20,
                        goods_selected: [
                            {
                                id: 1,
                                title: "商品"
                            },
                            {
                                id: 2,
                                title: "商品"
                            },
                            {
                                id: 3,
                                title: "商品"
                            }
                        ],
                        content: 'asfasfsadfas'
                    }
                }
                $.ajax({
                    url: "../../Handler/Backstage/CouponHandler.ashx?action=getitem&id="+id,
                    type: "Get",
                    dataType: "json"
                    //context: document.body
                }).success(function (data) {
                    json.result = data.data;
                    mpage.detailData = json.result;
                    mpage.setFormData();
                });
                
                //});
            },

            setFormData: function () {
                var mpage = this,
                    detail = mpage.detailData;

                $("#j-ticket-title").val(detail.title);

                if (detail.expire_date == -1) {
                    $("#j-ticket-date_forever").attr("checked", "checked");
                    $("#j-ticket-expire_date").attr("disabled", "disabled");
                } else {
                    $("#j-ticket-expire_date").removeAttr("checked");
                    $("#j-ticket-date_forever").removeAttr("disabled", "disabled").val(detail.expire_date);
                }

                $('#j-img-placehold').attr("src", 'http://placehold.it/128x128');
                $("#j-ticket-score").val(detail.score);
                $("#j-ticket-total").val(detail.total);
                $("#j-ticket-discount").val(detail.discount);
                $("#j-goods-selected").html($("#j-tmpl-goods-selecteditem").tmpl({
                    goods_selected: detail.goods_selected
                }));
                mpage.text_editor.html(detail.content);
            },

            getGoodsList: function (p) {
                var mpage = this;

                //$.getJSON("", { p: p}， function(json){
                var json = {
                    code: 0,
                    msg: "",
                    result: {
                        count: 59,
                        list: [
                            {
                                id: 1,
                                title: "商品"
                            },
                            {
                                id: 2,
                                title: "商品"
                            },
                            {
                                id: 3,
                                title: "商品"
                            },
                            {
                                id: 4,
                                title: "商品"
                            },
                            {
                                id: 5,
                                title: "商品"
                            },
                            {
                                id: 6,
                                title: "商品"
                            }
                        ]
                    }
                };
                $.ajax({
                    url: "../../Handler/Backstage/CouponHandler.ashx?action=getlist&sellerid=" + sellerId + "&start=" + (p - 1) + "&limit=" + 6,
                    type: "get",
                    dataType: "json"
                    //context: document.body
                }).success(function (data) {
                    json.result.count = data.data.TotalCount;
                    json.result.list = data.data.Results;
                    $("#j-goods-list").html($("#j-tmpl-goods-listitem").tmpl(json.result));

                    $("#j-goods-list li").unbind("click").bind("click", function () {
                        var id = $(this).attr("data-id"),
                            title = $(this).find(".j-title").text();

                        $("#j-goods-selected").append($("#j-tmpl-goods-selecteditem").tmpl({
                            goods_selected: [
                                {
                                    id: id,
                                    title: title
                                }
                            ]
                        }));
                        return false;
                    });

                    ue.pager({
                        //target : $(".list_pager"),//放置分页的元素
                        pagerTarget: $("#j-goods-pagination ul"),
                        first: '<li><a href="#">首页</a></li>',
                        firstDisabled: '<li class="disabled"><a href="#">首页</a></li>',
                        last: '<li><a href="#">末页</a></li>',
                        lastDisabled: '<li class="disabled"><a href="#">末页</a></li>',
                        prev: '<li><a href="#">上一页</a></li>',
                        prevDisabled: '<li class="disabled"><a href="#">上一页</a></li>',
                        next: '<li><a href="#">下一页</a></li>',
                        nextDisabled: '<li class="disabled"><a href="#">下一页</a></li>',
                        current: '<li class="active"><a href="#">@{page}</a></li>',
                        page: '<li><a href="#">@{page}</a></li>',
                        tip: '<li class="page-info"><b class="text-info">@{nowPage}</b>/@{pageCount}页 共<b class="text-info">@{count}</b>条记录</li>',
                        now: p,//当前页
                        maxPage: 5,//显示的最多页数
                        per: 6,//每页显示几个
                        count: json.result.count,
                        onchange: function (page) {//切换页数回调函数
                            mpage.getGoodsList(page);
                        }
                    })
                });

                //});

            }
        }

        $(function () {
            MPage.init();
        });

        </script>


</asp:Content>
