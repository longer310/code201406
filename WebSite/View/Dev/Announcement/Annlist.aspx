<%@ Page Title="" Language="C#" MasterPageFile="~/View/DevMaster.Master" AutoEventWireup="true" CodeBehind="Annlist.aspx.cs" Inherits="Backstage.View.Dev.Announcement.Annlist" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Header" runat="server">
    <link rel="shortcut icon" href="<%=DomainUrl %>/Css/img/favicon.ico">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Content" runat="server">

    <div class="widget-box">
        <div class="widget-title">
            <span class="icon">
                <i class="icon-bullhorn"></i>
            </span>
            <h5>公告列表</h5>
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
                        <th style="width: 40px;">编号</th>
                        <th>内容</th>
                        <th>发送时间</th>
                        <th>操作</th>
                    </tr>
                </thead>
                <tbody id="j-list">
                </tbody>
            </table>
        </div>

        <div class="widget-footer">
            <div class="pagination alternate" id="j-pagination">
                <ul class="page-main"></ul>
            </div>
        </div>
    </div>

    <!--页面js-->
    <script type="text/javascript" src="<%=DomainUrl %>/Script/js/ue.pager.js"></script>

    <script type="text/jquery-tmpl-x" id="j-tmpl-listitem">
        {{each(i, v) list}}
	        <tr data-aid="${v.Id}">
				<td><input type="checkbox" class="j-select" /></td>
				<td style="width:40px;">${v.Id}</td>
				<td>${v.Content}</td>
				<td style="width:200px;">${v.CreateTime.ToDate().Format("yyyy-MM-dd hh:mm:ss")}</td>
				<td style="width:60px;">
					<a class="btn btn-danger btn-mini j-btn-del" href="javascript:;"><i class="icon-remove icon-white"></i> 删除</a>
				</td>
			</tr>
		{{/each}}
    </script>

    <script type="text/javascript">
        var MPage = {
            hander: "<%=DomainUrl %>/Handler/Platform/AnnouncementHandler.ashx?action=",
            cid: 0,//当前分类 默认是全部分类
            maxpage: 5,     //最多显示的页数
            start: 1,       //页码
            limit: 10,       //一页条数

            init: function() {
                var mpage = this;
                //去掉之前选中打开的项 选中产品列表
                $("#sidebar li").removeClass("active open");
                $("#sidebar .sidebar_announcement").addClass("active open").find(".sidebar_annlist").addClass("active");

                mpage.getList(1);

                //绑定全选
                $("#j-btn-selectAll").bind("change", function() {
                    if ($(this).attr("checked")) {
                        $("#j-list .j-select:checkbox").attr("checked", "checked");
                    } else {
                        $("#j-list .j-select:checkbox").removeAttr("checked");
                    }

                    return false;
                });

                //绑定批量删除
                $("#j-btn-delSelected").bind("click", function() {
                    var $checked = $("#j-list :checked");

                    var ids = [];
                    $checked.each(function() {
                        ids.push($(this).parents("tr").attr("data-aid"));
                    });

                    if (ids.length > 0) {
                        Common.confirm({
                            title: "删除确认提示",
                            content: "您确定要删除当前选择的所有数据吗？",
                            confirm: function() {
                                //执行确认回调
                                mpage.delAnnList(ids.join(','));
                            }
                        });
                    } else {
                        Common.alert({
                            title: "提示",
                            content: "请至少选择一项"
                        });
                    }

                    return false;
                });
            },


            //p 页码
            //type tab 类型
            getList: function(p) {
                var mpage = this;

                mpage.start = p;
                $.post(mpage.hander + "getAnnouncemmentList", { start: mpage.start - 1, limit: mpage.limit }, function(data) {
                    if (!data.error) {
                        $("#j-list").html($("#j-tmpl-listitem").tmpl(data));

                        ue.pager({
                            //target : $(".list_pager"),//放置分页的元素
                            pagerTarget: $("#j-pagination ul"),
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
                            maxPage: mpage.maxpage,//显示的最多页数
                            per: mpage.limit,//每页显示几个
                            count: data.totalcount,
                            onchange: function(page) { //切换页数回调函数
                                mpage.getList(page);
                            }
                        });

                        //绑定提款
                        $("#j-list .j-btn-del").bind("click", function() {
                            var $item = $(this).parents("tr");
                            var id = $item.attr("data-aid");

                            Common.confirm({
                                title: "删除确认提示",
                                content: "您确定要删除当前公告？",
                                confirm: function() {
                                    //执行确认回调
                                    mpage.delAnnList(id);
                                }
                            });
                            return false;
                        });
                    } else {
                        Common.tip({ type: "error", content: data.error });
                    }
                }, "JSON");

                //});

            },
            
            //删除公告列表
            delAnnList: function (ids) {
                var mpage = this;
                $.post(mpage.hander + "delAnnouncemmentList", { ids: ids }, function (data) {
                    if (!data.error) {
                        Common.tip({ type: "success", content: data.success });
                        mpage.getList(mpage.start);
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
