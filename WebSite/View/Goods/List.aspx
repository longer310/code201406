<%@ Page Title="" Language="C#" MasterPageFile="~/View/merchant.Master" AutoEventWireup="true" CodeBehind="List.aspx.cs" Inherits="Backstage.View.Goods.List" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Header" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Content" runat="server">
    <div class="widget-box">
        <div class="widget-title">
            <span class="icon">
                <i class="icon-gift"></i>
            </span>
            <h5>商品列表</h5>
            <div class="buttons">
                <a href="#" class="btn btn-primary btn-mini" id="j-btn-saveAll"><i class="icon-ok icon-white"></i>保存</a>
                <a href="#" class="btn btn-danger btn-mini" id="j-btn-delSelected"><i class="icon-remove icon-white"></i>删除</a>
            </div>
        </div>
        <div class="widget-content">
            <ul class="nav nav-tabs" id="j-goods-tab">
                <li class="active">
                    <a href="#">所有商品</a>
                </li>
                <li><a href="#">推荐商品</a></li>
                <li><a href="#">热销商品</a></li>
            </ul>
            <table class="table table-bordered table-striped with-check">
                <thead>
                    <tr>
                        <th>
                            <input type="checkbox" id="j-btn-selectAll" name="title-table-checkbox" /></th>
                        <th>编号</th>
                        <th>图片</th>
                        <th>名称</th>
                        <th>现价</th>
                        <th>原价</th>
                        <th>已售</th>
                        <th>评论/浏览</th>
                        <th>操作</th>
                    </tr>
                </thead>
                <tbody id="j-goods-list">
                </tbody>
            </table>
        </div>

        <div class="widget-footer">
            <div class="pagination alternate" id="j-goods-pagination">
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

    <!--推荐和热销 如果选择 加上 active 的class-->
    <script type="text/jquery-tmpl-x" id="j-tmpl-goods-listitem">
        {{each(i, v) list}}
	        <tr data-gid="${v.Id}">
				<td><input type="checkbox" /></td>
				<td style="width:30px;">${v.Id}</td>
                <td style="width:45px;"><img style="max-width:45px;min-width:45px;max-height:45px;min-height:45px;" src="${v.LogoUrl}"></td>
				<td>${v.Title}</td>
				<td style="width:104px;"><input type="text" class="input-small j-price" value="${v.Nowprice}" ></td>
				<td style="width:104px;"><input type="text" class="input-small j-preprice" value="${v.OriginalPrice}" ></td>
				<td>${v.Sales}</td>
				<td>${v.CommentCount} / ${v.BrowseCount}</td>
				<td style="width:250px;">
					<button class="btn btn-success btn-mini j-isrecommend" data-toggle="buttons-checkbox"><i class="icon-thumbs-up icon-white"></i> {{if v.IsRecommend>0}}已推荐{{else}}推荐{{/if}}</button>
					<button class="btn btn-info btn-mini j-ishot active" data-toggle="buttons-checkbox"><i class="icon-fire icon-white"></i> {{if v.IsHot>0}}已热销{{else}}热销{{/if}}</button>
					<a class="btn btn-primary btn-mini" href=""><i class="icon-pencil icon-white"></i> 编辑</a>
					<a class="btn btn-danger btn-mini j-btn-del" href=""><i class="icon-remove icon-white"></i> 删除</a>
				</td>
			</tr>
		{{/each}}
    </script>
    <script type="text/javascript">
        var MPage = {
            hander: "../../Handler/Goods/GoodsHandler.ashx?action=",
            maxpage: 5,
            start: 0,
            limit: 3,
            init: function () {
                var mpage = this;

                mpage.getGoodsList(0, 0);

                //绑定tab
                $('#j-goods-tab a').click(function (e) {
                    var type = $(this).parent().index();
                    $(this).tab('show');
                    mpage.getGoodsList(1, type);
                    return false;
                });

                //绑定全选
                $("#j-btn-selectAll").bind("change", function () {
                    if ($(this).attr("checked")) {
                        $("#j-goods-list :checkbox").attr("checked", "checked");
                    } else {
                        $("#j-goods-list :checkbox").removeAttr("checked");
                    }

                    return false;
                });

                //绑定批量删除
                $("#j-btn-delSelected").bind("click", function () {
                    var $checked = $("#j-goods-list :checked");

                    var ids = [];
                    $checked.each(function () {
                        ids.push($(this).attr("data-id"));
                    });

                    if (ids.length > 0) {
                        Common.confirm({
                            title: "删除确认提示",
                            content: "您确定要删除当前选择的所有数据吗？",
                            confirm: function () {
                                //执行确认回调
                                alert('执行确认回调');

                                //删除成功后刷新本页
                                mpage.getGoodsList(mpage.goodsCurrentPage, mpage.goodsCurrentType);
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

                //绑定批量保存
                $("#j-btn-saveAll").bind("click", function () {
                    var $checked = $("#j-goods-list :checked");

                    var data_save = [];

                    $checked.each(function () {
                        var $item = $(this).parents("tr");
                        data_save.push(
                        {
                            id: $item.attr("data-gid"),
                            price: $item.find(".j-price").val(),
                            preprice: $item.find(".j-preprice").val(),
                            isrecommend: $item.find(".j-isrecommend").hasClass("active") ? 1 : 0,
                            ishot: $item.find(".j-ishot").hasClass("active") ? 1 : 0
                        });
                    });

                    if (data_save.length > 0) {
                        Common.confirm({
                            title: "保存确认提示",
                            content: "您确定要保存当前选择的所有修改吗？",
                            confirm: function () {
                                //执行确认回调
                                alert('执行确认回调');

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
            getGoodsList: function (p, type) {
                var mpage = this;
                mpage.start = p;

                //$.getJSON("", { p: p, type : type}， function(json){
                //mpage.goodsCurrentPage = p;
                mpage.goodsCurrentType = type;
                $("#j-btn-selectAll").removeAttr("checked");
                var totalcount = 10;
                $.post(mpage.hander + "getGoodsList", { start: mpage.start, limit: mpage.limit, type: mpage.goodsCurrentType }, function (data) {
                    if (!data.error) {
                        $("#j-goods-list").html($("#j-tmpl-goods-listitem").tmpl(data));
                        totalcount = data.totalcount;
                    } else {
                        Common.alert({
                            title: "提示",
                            content: data.error,
                            confirm: function () {
                                if(data.error =="您还未登录或登录超时，请重新登录！")
                                    location.href = "../../Login.aspx";
                            }
                        });
                    }
                }, "JSON");

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
                    now: mpage.start,//当前页
                    maxPage: mpage.maxpage,//显示的最多页数
                    per: mpage.limit,//每页显示几个
                    count: totalcount,
                    onchange: function (page) {//切换页数回调函数
                        mpage.getGoodsList(page);
                    }
                });

                //绑定单个删除
                $("#j-goods-list .j-btn-del").bind("click", function () {
                    var $item = $(this).parents("tr");
                    var id = $item.attr("data-id");

                    Common.confirm({
                        title: "删除确认提示",
                        content: "您确定要删除当前活动？",
                        confirm: function () {
                            //执行确认回调
                            alert('执行确认回调');

                            $item.remove();
                        },
                        cancel: function () {
                            //执行取消回调
                            alert('执行取消回调');
                        }
                    });
                    return false;
                });
                //});

            }
        }

        $(function () {
            MPage.init();
        });

    </script>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Footer" runat="server">
</asp:Content>


