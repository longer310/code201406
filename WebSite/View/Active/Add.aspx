<%@ Page Title="" Language="C#" MasterPageFile="~/View/merchant.Master" AutoEventWireup="true" CodeBehind="Add.aspx.cs" Inherits="Backstage.View.Active.Add" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Header" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Content" runat="server">
    <div class="widget-box">
        <div class="widget-title">
            <span class="icon">
                <i class="icon-gift"></i>
            </span>
            <h5>新增活动</h5>
        </div>
        <div class="widget-content">
            <form action="#" method="get" class="form-horizontal" id="j-activity-addForm" />
            <div class="control-group">
                <label class="control-label">活动主题</label>
                <div class="controls">
                    <input type="text" id="j-activity-title" />
                </div>
            </div>
            <div class="control-group">
                <label class="control-label">电子券</label>
                <div class="controls">
                    <input type="text" id="j-btn-ticket-selected" />
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
                            <img src="http://placehold.it/540x400" alt="" width="180" height="133" id="j-img-placehold">
                        </span>
                    </div>
                    <p style="margin-top: 10px;"><b class="text-error">上传图片要求：540*400</b></p>
                </div>
            </div>

            <div class="control-group">
                <label class="control-label">活动内容</label>
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
    <script src="<%=DomainUrl %>/script/js/ue.pager.js"></script>

    <script charset="utf-8" src="<%=DomainUrl %>/script/kindeditor/kindeditor-min.js"></script>
    <script charset="utf-8" src="<%=DomainUrl %>/script/kindeditor/lang/zh_CN.js"></script>

    <!--选择电子券弹窗-->
    <div id="j-ticket-selectModal" class="modal hide">
        <div class="modal-header">
            <button data-dismiss="modal" class="close" type="button">×</button>
            <h3>选择电子券</h3>
        </div>
        <div class="modal-body">
            <ul class="activity-list" id="j-ticket-list">
                <li><a href="#">电子券名称电子券名称电子券名称电子券名称电子券名称</a></li>
                <li><a href="#">电子券名称电子券名称电子券名称电子券名称电子券名称</a></li>
                <li><a href="#">电子券名称电子券名称电子券名称电子券名称电子券名称</a></li>
                <li><a href="#">电子券名称电子券名称电子券名称电子券名称电子券名称</a></li>
                <li><a href="#">电子券名称电子券名称电子券名称电子券名称电子券名称</a></li>
                <li><a href="#">电子券名称电子券名称电子券名称电子券名称电子券名称</a></li>
            </ul>
        </div>
        <div class="modal-footer">
            <div class="pagination alternate" id="j-ticket-pagination">
                <ul class="page-main">
                    <li class="disabled"><a href="#">首页</a></li>
                    <li class="disabled"><a href="#">上一页</a></li>
                    <li class="active">
                        <a href="#">1</a>
                    </li>
                    <li><a href="#">2</a></li>
                    <li><a href="#">3</a></li>
                    <li><a href="#">4</a></li>
                    <li><a href="#">下一页</a></li>
                    <li><a href="#">末页</a></li>
                    <li class="page-info"><b class="text-info">1</b>/8页 共<b class="text-info">18</b>条记录</li>
                </ul>
            </div>
        </div>
    </div>

    <!--电子券列表模版-->
    <script type="text/jquery-tmpl-x" id="j-tmpl-ticket-listitem">
        	{{each(i, v) list}}
	        	<li data-id="${v.id}"><a href="#">${v.title}</a></li>
			{{/each}}
        </script>

    <script type="text/javascript">
        var sellerId = '<%=sellerId%>';
        var MPage = {
            init: function () {
                var mpage = this;

                var text_editor,
                    image_editor;
                KindEditor.ready(function (K) {
                    //文本编辑器
                    mpage.text_editor = text_editor = K.create('textarea[name="content"]', {
                        uploadJson: '<%=DomainUrl %>/Handler/FileManager/UploadHandler.ashx?type=102&sellerid=' + sellerId,
                        allowFileManager: true
                    });

                    //图片上传编辑
                    mpage.image_editor = image_editor = K.editor({
                        uploadJson: '<%=DomainUrl %>/Handler/FileManager/UploadHandler.ashx?type=102&sellerid=' + sellerId,
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
                });

                //绑定选择电子券
                $("#j-btn-ticket-selected").bind("focus", function () {
                    mpage.getTicketList(1);
                    $('#j-ticket-selectModal').modal('show');
                });

                //绑定提交表单
                $("#j-activity-addForm").bind("submit", function () {
                    var save_data = {
                        title: $.trim($("#j-activity-title").val()),
                        ticket_id: $("#j-btn-ticket-selected").attr("data-id"),
                        thumbnail: $('#j-img-placehold').attr("src"),
                        text: $.trim(text_editor.text()),
                        content: text_editor.html(),
                        sellerid: sellerId
                    }
                    $.ajax({
                        url: "../../Handler/Backstage/SystemHandler.ashx?action=addpush",
                        data: save_data,
                        type: "POST",
                        dataType: "json"
                        //context: document.body
                    }).success(function (data) {
                        alert("添加成功");
                        window.location.href = "List.aspx?sellerId=" + sellerId;
                        //window.setTimeout(function () {
                        //    window.location.reload();
                        //}, 2000);
                    });
                    return false;
                });

                //绑定重置表单
                $("#j-activity-addForm").bind("reset", function () {
                    $("#j-activity-title").val('');
                    $("#j-btn-ticket-selected").removeAttr("data-id").val('');
                    $('#j-img-placehold').attr("src", 'http://placehold.it/128x128');
                    mpage.text_editor.html('');
                    return false;
                });
            },

            getTicketList: function (p) {
                var mpage = this;

                //$.getJSON("", { p: p}， function(json){
                var json = {
                    code: 0,
                    msg: "",
                    result: {
                        count: 59,
                        list: [
                            {},
                            {},
                            {},
                            {},
                            {},
                            {}
                        ]
                    }
                };

                $.ajax({
                    url: "../../Handler/Backstage/CouponHandler.ashx?action=getlist&sellerid=" + sellerId + "&start=" + (p - 1) + "&limit=" + 6,
                    type: "get",
                    dataType: "json"
                    //context: document.body
                }).success(function (data) {

                    json.result.count = data.data.totalcount;
                    json.result.list = data.data.results;
                    $("#j-ticket-list").html($("#j-tmpl-ticket-listitem").tmpl(json.result));

                    $("#j-ticket-list li").bind("click", function () {
                        var gid = $(this).attr("data-id"),
                            title = $(this).text();

                        $("#j-btn-ticket-selected").attr("data-id", gid).val(title);
                        $('#j-ticket-selectModal').modal('hide');
                        return false;
                    });

                    ue.pager({
                        //target : $(".list_pager"),//放置分页的元素
                        pagerTarget: $("#j-ticket-pagination ul"),
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
                            mpage.getTicketList(page);
                        }
                    })
                });

            }
        }

        $(function () {
            MPage.init();
        });

        </script>
</asp:Content>
