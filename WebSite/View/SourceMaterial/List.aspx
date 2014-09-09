<%@ Page Title="" Language="C#" MasterPageFile="~/View/merchant.Master" AutoEventWireup="true" CodeBehind="List.aspx.cs" Inherits="Backstage.View.SourceMaterial.List" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Header" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Content" runat="server">
    
			<div class="widget-box" >
				<div class="widget-title">
					<span class="icon">
						<i class="icon-picture"></i>
					</span>
					<h5>图片墙列表</h5>
					<div class="buttons">
						<a href="#" class="btn btn-primary btn-mini" id="j-btn-selectAll"><i class="icon-check icon-white"></i> 全选</a>
						<a href="#" class="btn btn-danger btn-mini" id="j-btn-delSelected"><i class="icon-remove icon-white"></i> 删除</a>
					</div>
				</div>
				<div class="widget-content">
					<div class="list-2col list-4col">
						<ul class="list-in" id="j-image-list">
						</ul>
					</div>
				</div>

				<div class="widget-footer">
					<div class="pagination alternate" id="j-image-pagination">
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

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Footer" runat="server">
    <!--页面js-->
        <script src="../../script/js/ue.pager.js"></script>

        <!--活动列表模版-->
        <script type="text/jquery-tmpl-x" id="j-tmpl-image-listitem">
        	{{each(i, v) list}}
	        	<li class="item" data-id="${v.id}">
					<div class="item-in">
						<h3 class="post-title">${v.title}</h3>
						<div class="article-thumb">
							<img alt="User" src="${v.url}" />
						</div>

						<p class="post-desc">
							${v.description}
						</p>
						<div class="article-post">
							<p class="post-meta">
								<span>浏览：<span class="text-error">${v.views}</span> 
								评论：<span class="text-error">${v.commentnum}</span>条</span> 
							</p>
							<div class="post-action">
								<div class="checker"><span><input type="checkbox" name="radios"></span></div>
								<a href="Edit.aspx?id=${v.id}" class="btn btn-primary btn-mini"><i class="icon-pencil icon-white"></i> 编辑</a>
								<a href="#" class="btn btn-danger btn-mini j-btn-del"><i class="icon-remove icon-white"></i> 删除</a>
							</div>
						</div>
					</div>
				</li>
			{{/each}}
        </script>

        <script type="text/javascript">
            var sellerId = '<%=SellerId%>';
            var MPage = {
                init: function () {
                    var mpage = this;
                    mpage.getImageList(1);

                    //绑定全选
                    $("#j-btn-selectAll").bind("click", function () {
                        if (!$(this).data("checked")) {
                            $("#j-image-list :checkbox").attr("checked", "checked");
                            $(this).data("checked", true).html('<i class="icon-check icon-white"></i> 取消全选');
                        } else {
                            $("#j-image-list :checkbox").removeAttr("checked");
                            $(this).data("checked", false).html('<i class="icon-check icon-white"></i> 全选');
                        }

                        return false;
                    });

                    //绑定批量删除
                    $("#j-btn-delSelected").bind("click", function () {
                        var $checked = $("#j-image-list :checked");

                        var ids = [];
                        $checked.each(function () {
                            ids.push($(this).parents("li").attr("data-id"));
                        });

                        if (ids.length > 0) {
                            Common.confirm({
                                title: "删除确认提示",
                                content: "您确定要删除当前选择的所有数据吗？",
                                confirm: function () {
                                    //执行确认回调
                                    $.ajax({
                                        url: "../../Handler/Backstage/SourceMaterialHandler.ashx?action=delete?ids=" + ids,
                                        type: "Get",
                                        dataType: "json"
                                        //context: document.body
                                    }).success(function (data) {
                                        alert("删除成功");
                                        //删除成功后刷新本页
                                        mpage.getImageList(mpage.currentPage);
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
                                    //alert('执行确认回调');
                                }
                            });
                        }

                        return false;
                    });
                },

                getImageList: function (p) {
                    var mpage = this;

                    //$.getJSON("", { p: p}， function(json){
                    mpage.currentPage = p;
                    $("#j-btn-selectAll").data("checked", false).html('<i class="icon-check icon-white"></i> 全选');

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
                                {},
                                {},
                                {}
                            ]
                        }
                    };

                    $.ajax({
                        url: "../../Handler/Backstage/SourceMaterialHandler.ashx?action=getlist&sellerId=" + sellerId + "&start=" + (p-1) + "&limit=8",
                        type: "Get",
                        dataType: "json"
                        //context: document.body
                    }).success(function (data) {

                        json.result.list = data.data.results;
                        json.result.count = data.data.totalcount;

                        $("#j-image-list").html($("#j-tmpl-image-listitem").tmpl(json.result));

                        ue.pager({
                            //target : $(".list_pager"),//放置分页的元素
                            pagerTarget: $("#j-image-pagination ul"),
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
                            per: 8,//每页显示几个
                            count: json.result.count,
                            onchange: function (page) {//切换页数回调函数
                                mpage.getImageList(page);
                            }
                        });

                        //绑定单个删除
                        $("#j-image-list .j-btn-del").bind("click", function () {
                            var $item = $(this).parents("li");
                            console.log($item);
                            var id = $item.attr("data-id");

                            Common.confirm({
                                title: "删除确认提示",
                                content: "您确定要删除当前图片墙？",
                                confirm: function () {
                                    //执行确认回调
                                    $.ajax({
                                        url: "../../Handler/Backstage/SourceMaterialHandler.ashx?action=delete&ids=" + id,
                                        type: "Get",
                                        dataType: "json"
                                        //context: document.body
                                    }).success(function (data) {
                                        alert("删除成功");
                                        //删除成功后刷新本页
                                        mpage.getImageList(mpage.currentPage);
                                    });

                                    $item.remove();
                                },
                                cancel: function () {
                                    //执行取消回调
                                    alert('执行取消回调');
                                }
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
