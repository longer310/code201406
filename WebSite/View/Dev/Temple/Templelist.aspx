<%@ Page Title="" Language="C#" MasterPageFile="~/View/DevMaster.Master" AutoEventWireup="true" CodeBehind="Templelist.aspx.cs" Inherits="Backstage.View.Dev.Temple.Templelist" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Header" runat="server">
    <link rel="shortcut icon" href="<%=DomainUrl %>/Css/img/favicon.ico">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Content" runat="server">

    <div class="widget-box">
        <div class="widget-title">
            <span class="icon">
                <i class="icon-tags"></i>
            </span>
            <h5>模版列表</h5>
            <div class="buttons">
                <a href="#" class="btn btn-primary btn-mini" id="j-btn-selectAll"><i class="icon-check icon-white"></i>全选</a>
                <a href="#" class="btn btn-danger btn-mini" id="j-btn-delSelected"><i class="icon-remove icon-white"></i>删除</a>
            </div>
        </div>
        <div class="widget-content">
            <ul class="nav nav-tabs" id="j-tab"></ul>
            <div class="list-2col list-4col">
                <ul class="list-in" id="j-list">
                </ul>
            </div>
        </div>

        <div class="widget-footer">
            <div class="pagination alternate" id="j-pagination">
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

    <!--页面js-->
    <script type="text/javascript" src="<%=DomainUrl %>/Script/js/ue.pager.js"></script>
    <script type="text/javascript">
        var Shop_Category = [
            {
                id: 0,
                name: "所有模版"
            },
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

        </script>

    <!--活动列表模版-->
    <script type="text/jquery-tmpl-x" id="j-tmpl-listitem">
        	{{each(i, v) list}}
	        	<li class="item" data-id="${v.Id}">
					<div class="item-in">
						<h3 class="post-title"></h3>
						<div class="article-thumb">
							<img alt="User" src="${v.LogoUrl}" />
						</div>
						<div class="article-post" style="margin-top:10px;">
							<p>名称：<span class="text-warning">${v.Name}</span></p> 
							<p>所属：<span class="text-warning">
                                {{if v.TypeId == 1}}餐饮超市类
                                {{else v.TypeId == 2}}夜场类
                                {{else v.TypeId == 3}}企业类
                                {{/if}}
                            </span></p>
							<div class="post-action">
								<div class="checker"><span><input type="checkbox" name="radios"></span></div>
								<a href="edittemple.aspx?id=${v.Id}" class="btn btn-primary btn-mini j-btn-edit"><i class="icon-pencil icon-white"></i> 编辑</a>
								<a href="#" class="btn btn-danger btn-mini j-btn-del"><i class="icon-remove icon-white"></i> 删除</a>
							</div>
						</div>
					</div>
				</li>
			{{/each}}
        </script>

    <script type="text/javascript">
        var MPage = {
            mid: 0,//当前分类 默认是全部分类
            maxpage: 5,     //最多显示的页数
            start: 1,       //页码
            limit: 8,       //一页条数
            hander: "<%=DomainUrl %>/Handler/Platform/AnnouncementHandler.ashx?action=",

            init: function() {
                var mpage = this;

                //去掉之前选中打开的项 选中产品列表
                $("#sidebar li").removeClass("active open");
                $("#sidebar .sidebar_templemanager").addClass("active open").find(".sidebar_templelist").addClass("active");

                var route = Route.parse(document.location.href, Route.SEARCH);
                mpage.start = route.param.page || mpage.start;
                mpage.mid = route.param.mid || mpage.mid;

                mpage.renderTab();
                mpage.getTempleList(mpage.start, mpage.mid);

                //绑定全选
                $("#j-btn-selectAll").bind("click", function() {
                    if (!$(this).data("checked")) {
                        $("#j-list :checkbox").attr("checked", "checked");
                        $(this).data("checked", true).html('<i class="icon-check icon-white"></i> 取消全选');
                    } else {
                        $("#j-list :checkbox").removeAttr("checked");
                        $(this).data("checked", false).html('<i class="icon-check icon-white"></i> 全选');
                    }

                    return false;
                });

                //绑定批量删除
                $("#j-btn-delSelected").bind("click", function() {
                    var $checked = $("#j-list :checked");

                    var ids = [];
                    $checked.each(function() {
                        ids.push($(this).parents("li").attr("data-id"));
                    });

                    if (ids.length > 0) {
                        Common.confirm({
                            title: "删除确认提示",
                            content: "您确定要删除当前选择的所有数据吗？",
                            confirm: function() {
                                //执行确认回调
                                mpage.delTempleList(ids.join(','));

                                //删除成功后刷新本页
                                //mpage.getTempleList(mpage.start, mpage.mid);
                                //Route.goto(document.location.href);
                            },
                            cancel: function() {
                                //执行取消回调
                                alert('执行取消回调');
                            }
                        });
                    } else {
                        Common.alert({
                            title: "提示",
                            content: "请至少选择一项",
                            confirm: function() {
                                //执行确认回调
                                alert('执行确认回调');
                            }
                        });
                    }

                    return false;
                });
            },

            getTempleList: function (p, typeid) {
                var mpage = this;
                mpage.start = p;

                $("#j-btn-selectAll").data("checked", false).html('<i class="icon-check icon-white"></i> 全选');
                //$.getJSON("", { p: p, type : type}， function(json){
                $.post(mpage.hander + "getTempleList", { typeid: typeid, start: mpage.start - 1, limit: mpage.limit }, function (data) {
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
                            now: mpage.start,//当前页
                            maxPage: mpage.maxpage,//显示的最多页数
                            per: mpage.limit,//每页显示几个
                            count: data.totalcount,
                            onchange: function(page) { //切换页数回调函数
                                //mpage.getTempleList(page);
                                Route.goto("Templelist.aspx?page=" + page + "&mid=" + mpage.mid);
                            }
                        });

                        //绑定单个删除
                        $("#j-list .j-btn-del").bind("click", function() {
                            var $item = $(this).parents("li");
                            var id = $item.attr("data-id");

                            Common.confirm({
                                title: "删除确认提示",
                                content: "您确定要删除当前模版？",
                                confirm: function() {
                                    //执行确认回调
                                    mpage.delTempleList(id);
                                }
                            });
                            return false;
                        });

                        $("#j-list .j-btn-edit").bind("click", function() {
                            Route.goto(this.href);
                            return false;
                        });
                    }
                }, "JSON");
            },

            //删除模板列表
            delTempleList: function (ids) {
                var mpage = this;
                $.post(mpage.hander + "delTempleList", { ids: ids }, function (data) {
                    if (!data.error) {
                        Common.tip({ type: "success", content: data.success });
                        mpage.getTempleList(mpage.start);
                        Route.goto(document.location.href);
                    } else {
                        Common.tip({ type: "error", content: data.error });
                    }
                }, "JSON");
            },

            renderTab: function() {
                var mpage = this,
                    tmpl = '';

                $.each(Shop_Category, function(i, v) {
                    tmpl += '<li class="' + (v.id == mpage.mid ? 'active' : '') + '" data-id="' + v.id + '"><a href="#">' + v.name + '</a></li>';
                });

                $("#j-tab").html(tmpl);

                //绑定tab
                $('#j-tab a').bind("click", function(e) {
                    var id = $(this).parent().attr("data-id");
                    $(this).tab('show');
                    //mpage.mid = id;
                    //mpage.getTempleList(1, id);

                    Route.goto("templelist.aspx?page=" + 1 + "&mid=" + id);
                    return false
                });
            },
        };

            $(function () {
                MPage.init();
            });
        </script>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Footer" runat="server">
</asp:Content>
