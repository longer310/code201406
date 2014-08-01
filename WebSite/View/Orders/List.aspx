<%@ Page Title="" Language="C#" MasterPageFile="~/View/merchant.Master" AutoEventWireup="true" CodeBehind="List.aspx.cs" Inherits="Backstage.View.Orders.List" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Header" runat="server">
    <link rel="shortcut icon" href="<%=DomainUrl %>/Css/img/favicon.ico">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Content" runat="server">
    
<div class="widget-box" >
	<div class="widget-title">
		<span class="icon">
			<i class="icon-gift"></i>
		</span>
		<h5>订单列表</h5>
		<div class="buttons">
			<a href="#" class="btn btn-success btn-mini" id="j-btn-saveAll"><i class="icon-ok icon-white"></i> 已发货</a>
		</div>
	</div>
	<div class="widget-content">
		<ul class="nav nav-tabs" id="j-order-tab">
			<li><a href="#">所有订单</a></li>
			<li><a href="#">已付款订单</a></li>
			<li><a href="#">待发货订单</a></li>
			<li><a href="#">已发货订单</a></li>
			<li><a href="#">已完成订单</a></li>
		</ul>
		<table class="table table-bordered table-striped with-check">
			<thead>
				<tr>
					<th><input type="checkbox" id="j-btn-selectAll" name="title-table-checkbox" /></th>
					<th>订单号</th>
					<th>会员账号</th>
					<th>商品数量</th>
					<th>订单金额</th>
					<th>订单时间</th>
					<th>订单状态</th>
					<th style="display:none;" id="j-goods-order-type">订单类型</th>
					<th>操作</th>
				</tr>
			</thead>
			<tbody id="j-order-list">
			</tbody>
		</table>
	</div>

	<div class="widget-footer">
		<div class="pagination alternate" id="j-order-pagination">
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

<div id="footer">
	<p>关于淘宝合作伙伴营销中心廉正举报联系客服开放平台诚征英才联系我们网站地图法律声明© 2003-2014 Taobao.com 版权所有</p>
	<p>网络文化经营许可证：文网文[2010]040号|增值电信业务经营许可证：浙B2-20080224-1|信息网络传播视听节目许可证：1109364号 </p>
</div>

    <!--页面js-->
    <script type="text/javascript" src="<%=DomainUrl %>/Script/js/ue.pager.js"></script>
    <script type="text/jquery-tmpl-x" id="j-tmpl-order-listitem">
        	{{each(i, v) list}}
	        	<tr data-gid="1">
					<td><input type="checkbox" class="j-select" /></td>
					<td >${v.Id}</td>
					<td>${v.UserId}</td>
					<td>${v.GoodsCount}</td>
					<td><b class="text-error">￥${v.Money}</b></td>
					<td>${v.CreateTime}</td>
					<td>
                        <b class="text-error j-order-status">
                            {{if v.Status == 1}}未付款
                            {{else v.Status == 2}}已付款
                            {{else v.Status == 3}}待发货
                            {{else v.Status == 4}}已发货
                            {{else}}已完结
                            {{/if}}
                        </b>
                    </td>
					
					<td style="display:{{if UINFO.shop_type == 1}}block{{else}}none{{/if}}">
                        {{if v.Type == 0}}到店{{else}}送餐{{/if}}
                    </td>
					
					<td style="width:130px;">
						<div class="pull-right">
                        {{if v.Type > 0}}
							<a class="btn btn-success btn-mini j-btn-reach" href="javascript:;"><i class="icon-ok icon-white"></i> 已发货</a>
                        {{/if}}
							<a class="btn btn-primary btn-mini" href="<%=DomainUrl %>/view/orders/detail.aspx?id=${v.Id}"><i class="icon-pencil icon-white"></i> 查看</a>
						</div>
					</td>
				</tr>
			{{/each}}
        </script>

        <script type="text/javascript">
            //用户的基础信息
            var UINFO = {
                uid: 1111,
                uname: "2222",
                shop_type: 1//商家类型 为餐饮
            }
        </script>
        <script type="text/javascript">
            var MPage = {
                hander: "<%=DomainUrl %>/Handler/Orders/OrdersHandler.ashx?action=",
                maxpage: 5,     //最多显示的页数
                start: 0,       //页码
                limit: 3,       //一页条数
                type: 0,         //当前产品类型
                init: function () {
                    var mpage = this;

                    //去掉之前选中打开的项 选中产品列表
                    $("#sidebar li").removeClass("active open");
                    $("#sidebar .sidebar_orders").addClass("active open");

                    var route = Route.parse(document.location.href, Route.SEARCH);
                    mpage.start = parseInt(route.param.page) || 1;
                    mpage.type = parseInt(route.param.type) || 0;
                    mpage.getOrderList(mpage.start, mpage.type);

                    if (UINFO.shop_type == 1) {
                        $("#j-goods-order-type").show();
                    }
                    //绑定tab
                    $('#j-order-tab a').click(function (e) {
                        mpage.type = $(this).parent().index();
                        $(this).tab('show');
                        //document.location.href = "?page=1&type=" + type;
                        mpage.getOrderList(1, mpage.type);
                        return false;
                    });

                    $('#j-order-tab li').eq(mpage.type).addClass("active");

                    //绑定全选
                    $("#j-btn-selectAll").bind("change", function () {
                        if ($(this).attr("checked")) {
                            $("#j-order-list .j-select:checkbox").attr("checked", "checked");
                        } else {
                            $("#j-order-list .j-select:checkbox").removeAttr("checked");
                        }

                        return false;
                    });

                    //绑定批量设置已发货
                    $("#j-btn-saveAll").bind("click", function () {
                        var $checked = $("#j-order-list .j-select:checked");

                        var data_save = [];

                        $checked.each(function () {
                            var $item = $(this).parents("tr");
                            data_save.push(
        					{
        					    id: $item.attr("data-gid")
        					});
                        });

                        console.log(data_save);

                        if (data_save.length > 0) {
                            Common.confirm({
                                title: "保存确认提示",
                                content: "您确定要保存当前选择的所有修改吗？",
                                confirm: function () {
                                    //执行确认回调
                                    alert('执行确认回调');
                                    $checked.each(function () {
                                        var $item = $(this).parents("tr");
                                        $item.find(".j-order-status").html('已发货');
                                        $item.find(".j-btn-reach").remove();
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

                //start 页码
                //type tab 类型
                getOrderList: function (start, type) {
                    var mpage = this;
                    mpage.start = start;
                    mpage.type = type;

                    $("#j-btn-selectAll").removeAttr("checked");
                    //$.getJSON("", { p: p, type : type}， function(json){
                    $.post(mpage.hander + "getOrdersList", { start: mpage.start - 1, limit: mpage.limit, type: mpage.type }, function (data) {
                        if (!data.error) {
                            $("#j-order-list").html($("#j-tmpl-order-listitem").tmpl(data));

                            ue.pager({
                                //target : $(".list_pager"),//放置分页的元素
                                pagerTarget: $("#j-order-pagination ul"),
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
                                maxPage: 5,//显示的最多页数
                                per: 6,//每页显示几个
                                count: data.count,
                                onchange: function (page) {//切换页数回调函数
                                    mpage.getOrderList(page, mpage.type);
                                    //document.location.href = "?page=" + page + "&type=" + type;
                                }
                            });

                            //绑定单个设置已发货
                            $("#j-order-list .j-btn-reach").bind("click", function () {
                                var $item = $(this).parents("tr");
                                var id = $item.attr("data-gid");
                                var $btn = $(this);

                                Common.confirm({
                                    title: "订单修改提示",
                                    content: "您确定要将该订单的状态修改为已发货？",
                                    confirm: function () {
                                        //执行确认回调
                                        alert('执行确认回调');

                                        $item.find(".j-order-status").html('已发货');
                                        $btn.remove();
                                    },
                                    cancel: function () {
                                        //执行取消回调
                                        alert('执行取消回调');
                                    }
                                });
                                return false;
                            });
                        } else {
                            Common.alert({
                                title: "提示",
                                content: data.error,
                                confirm: function () {
                                }
                            });
                        }
                    }, "JSON");

                }
            }

            $(function () {
                MPage.init();
            });

        </script>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Footer" runat="server">
</asp:Content>


