<%@ Page Title="" Language="C#" MasterPageFile="~/View/merchant.Master" AutoEventWireup="true" CodeBehind="List.aspx.cs" Inherits="Backstage.View.Comment.List" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Header" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Content" runat="server">
    <div class="widget-box">
        <div class="widget-title">
            <span class="icon">
                <i class="icon-comment"></i>
            </span>
            <h5>留言管理</h5>
            <div class="buttons">
                <a href="#" class="btn btn-danger btn-mini" id="j-btn-delSelected"><i class="icon-remove icon-white"></i>删除</a>
            </div>
        </div>
        <div class="widget-content">
            <table class="table table-bordered table-striped with-check">
                <thead>
                    <tr>
                        <th>
                            <input type="checkbox" id="j-btn-selectAll" name="title-table-checkbox" /></th>
                        <th>留言日期</th>
                        <th>类型</th>
                        <th>主题</th>
                        <th>留言人</th>
                        <th>会员帐号</th>
                        <th>状态</th>
                        <th>操作</th>
                    </tr>
                </thead>
                <tbody id="j-comment-list">
                </tbody>
            </table>
        </div>

        <div class="widget-footer">
            <div class="pagination alternate" id="j-comment-pagination">
                <ul class="page-main"></ul>
            </div>
        </div>
    </div>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Footer" runat="server">
    <!--页面js-->
    <script src="../public/js/ue.pager.js"></script>

    <script type="text/jquery-tmpl-x" id="j-tmpl-comment-listitem">
        	{{each(i, v) list}}
	        	<tr data-gid="${v.id}">
					<td><input type="checkbox" class="j-select" /></td>
					<td>${v.createtime}</td>
					<td><span class="text-warning">${v.type}</span></td>
					<td>${v.title}</td>
					<td>${v.nickname}</td>
					<td>${v.userid}</td>
					<td><span class="text-error">${v.feedbackstatus}</span></td>
					<td style="width:120px;">
						<a class="btn btn-primary btn-mini j-btn-edit"><i class="icon-pencil icon-white"></i> 编辑</a>
						<a class="btn btn-danger btn-mini j-btn-del" href=""><i class="icon-remove icon-white"></i> 删除</a>
					</td>
				</tr>
			{{/each}}
        </script>

    <!--选择电子券弹窗-->
    <div id="j-comment-modal" class="modal hide">
        <form action="#" method="get" class="form-horizontal">
            <div class="modal-header">
                <button data-dismiss="modal" class="close" type="button">×</button>
                <h3>评论回复</h3>
            </div>
            <div class="modal-body">

                <div class="control-group">
                    <label class="control-label">评论主题</label>
                    <div class="controls">
                        <span class="input-xlarge uneditable-input j-comment-title">评论主题评论主题评论主题评论主题</span>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label">评论内容</label>
                    <div class="controls">
                        <span class="input-xlarge uneditable-input j-comment-content" style="height: auto; white-space: inherit;">评论内容评论内容评论内容评论内容评论内容评论内容</span>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label">回复内容</label>
                    <div class="controls">
                        <textarea rows="5" id="j-comment-reply" class="j-comment-reply"></textarea>
                    </div>
                </div>
                <div class="form-actions">
                    <button type="submit" class="btn btn-primary">回复</button>
                </div>

            </div>
            <div class="modal-footer">
            </div>
        </form>
    </div>

    <script type="text/javascript">
        var sellerid = '<%=SellerId%>';
        var MPage = {
            currentid: 0,
            init: function () {
                var mpage = this;

                mpage.getCommentList(1, 0);

                //绑定全选
                $("#j-btn-selectAll").bind("change", function () {
                    if ($(this).attr("checked")) {
                        $("#j-comment-list .j-select:checkbox").attr("checked", "checked");
                    } else {
                        $("#j-comment-list .j-select:checkbox").removeAttr("checked");
                    }

                    return false;
                });

                //绑定批量删除
                $("#j-btn-delSelected").bind("click", function () {
                    var $checked = $("#j-comment-list .j-select:checked");

                    var ids = [];
                    $checked.each(function () {
                        ids.push($(this).parents("tr").attr("data-gid"));
                    });

                    if (ids.length > 0) {
                        Common.confirm({
                            title: "删除确认提示",
                            content: "您确定要删除当前选择的所有数据吗？",
                            confirm: function () {
                                $.ajax({
                                    url: "../../Handler/Backstage/CommentHandler.ashx?action=delete&ids=" + ids,
                                    type: "Get",
                                    dataType: "json"
                                }).success(function (data) {
                                    alert("删除成功");
                                    //删除成功后刷新本页
                                    mpage.getCommentList(mpage.currentPage);
                                });

                                
                            },
                            cancel: function () {
                                //执行取消回调
                                alert('执行取消回调');
                            }
                        });
                    } else {
                        Common.alert({
                            title: "提示",
                            content: "请至少选择一项",
                            confirm: function () {
                                //执行确认回调
                                alert('执行确认回调');
                            }
                        });
                    }

                    return false;
                });
            },

            //p 页码
            //type tab 类型
            getCommentList: function (p) {
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
                                title: "评论主题评论主题评论主题评论主题",
                                content: "评论内容评论内容评论内容评论内容评论内容评论内容"
                            },
                            {
                                id: 2,
                                title: "评论主题评论主题评论主题评论主题",
                                content: "评论内容评论内容评论内容评论内容评论内容评论内容"
                            },
                            {
                                id: 3,
                                title: "评论主题评论主题评论主题评论主题",
                                content: "评论内容评论内容评论内容评论内容评论内容评论内容"
                            },
                            {
                                id: 4,
                                title: "评论主题评论主题评论主题评论主题",
                                content: "评论内容评论内容评论内容评论内容评论内容评论内容"
                            },
                            {
                                id: 5,
                                title: "评论主题评论主题评论主题评论主题",
                                content: "评论内容评论内容评论内容评论内容评论内容评论内容"
                            },
                            {
                                id: 6,
                                title: "评论主题评论主题评论主题评论主题",
                                content: "评论内容评论内容评论内容评论内容评论内容评论内容"
                            }
                        ]
                    }
                };

                $.ajax({
                    url: "../../Handler/Backstage/CommentHandler.ashx?action=getlist&sellerId=" + sellerId + "&start=" + (p - 1) + "&limit=6",
                    type: "Get",
                    dataType: "json"
                    //context: document.body
                }).success(function (data) {
                    json.result.count = data.data.totalcount;
                    json.result.list = data.data.results;

                    mpage.currentPag = p;
                    //mpage.cache = json;
                    $("#j-btn-selectAll").removeAttr("checked");


                    $("#j-comment-list").html($("#j-tmpl-comment-listitem").tmpl(json.result));

                    ue.pager({
                        //target : $(".list_pager"),//放置分页的元素
                        pagerTarget: $("#j-comment-pagination ul"),
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
                            mpage.getCommentList(page);
                        }
                    });

                    //绑定单个删除
                    $("#j-comment-list .j-btn-del").unbind("click").bind("click", function () {
                        var $item = $(this).parents("tr");
                        var id = $item.attr("data-gid");

                        Common.confirm({
                            title: "删除确认提示",
                            content: "您确定要删除当前用户？",
                            confirm: function () {
                                //执行确认回调
                                $.ajax({
                                    url: "../../Handler/Backstage/CommentHandler.ashx?action=delete&ids=" + id,
                                    type: "Get",
                                    dataType: "json"
                                }).success(function (data) {
                                    alert("删除成功");
                                    //删除成功后刷新本页
                                    $item.remove();
                                });

                            },
                            cancel: function () {
                                //执行取消回调
                                //alert('执行取消回调');
                            }
                        });
                        return false;
                    });

                    //绑定单个回复
                    $("#j-comment-list .j-btn-edit").unbind("click").bind("click", function () {
                        var $item = $(this).parents("tr");
                        var id = $item.attr("data-gid");
                        currentid = id;
                        var comment_item;

                        for (var i = 0; i < json.result.list.length; i++) {
                            if (json.result.list[i].id == id) {
                                comment_item = json.result.list[i];
                                break;
                            }
                        }
                        $('#j-comment-modal .j-comment-title').html(comment_item.title);
                        $('#j-comment-modal .j-comment-content').html(comment_item.content);

                        $('#j-comment-modal').modal('show');
                        $("#j-comment-modal").height("auto");
                        var height = $("#j-comment-modal").height();
                        $("#j-comment-modal").css({
                            height: height,
                            "margin-top": -height / 2
                        });
                        return false;
                    });

                    //绑定回复
                    $("#j-comment-modal form").unbind("submit").bind("submit", function () {
                        var title = $('#j-comment-modal .j-comment-title').html();
                        var content = $('#j-comment-modal .j-comment-content').html();
                        var feedback = $('#j-comment-reply').html();
                        var save_data = {
                            title: title,
                            content: content,
                            feedback: feedback
                        };
                        $.ajax({
                            url: "../../Handler/Backstage/CouponHandler.ashx?action=update&id=" + currentid,
                            type: "POST",
                            data: save_data,
                            dataType: "json"
                        }).success(function (data) {
                            alert("删除成功");
                            //删除成功后刷新本页
                            $item.remove();
                        });
                        return false;
                    });
                });


                //});
            }
        }

        $(function () {
            MPage.init();
        });

        </script>
</asp:Content>
