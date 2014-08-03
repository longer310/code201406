<%@ Page Title="" Language="C#" MasterPageFile="~/View/merchant.Master" AutoEventWireup="true" CodeBehind="Detail.aspx.cs" Inherits="Backstage.View.Orders.Detail" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Header" runat="server">
    <link rel="shortcut icon" href="<%=DomainUrl %>/Css/img/favicon.ico">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Content" runat="server">
    <div class="widget-box">
        <div class="widget-title">
            <span class="icon">
                <i class="icon-shopping-cart"></i>
            </span>
            <h5>订单详情</h5>
        </div>
        <div class="widget-content">

            <div class="row-fluid">
                <div class="span6" id="j-orderDetail-info">
                </div>
                <div class="span6" id="j-orderDetail-user">
                </div>
            </div>



            <div class="progress" style="height: 30px; line-height: 30px;" id="j-orderDetail-status">
            </div>

            <table class="table table-bordered table-striped">
                <thead>
                    <tr>
                        <th>图片</th>
                        <th>名称</th>
                        <th>单价</th>
                        <th>数量</th>
                        <th>小计</th>
                    </tr>
                </thead>
                <tbody id="j-orderDetail-list">
                </tbody>
                <tfoot>
                    <tr>
                        <td colspan="5" id="j-orderDetail-footer"></td>
                    </tr>
                </tfoot>
            </table>
        </div>

        <div class="widget-footer clearfix">
            <div class="pull-right" style="padding: 20px 0;">
                <a class="btn btn-primary" href="javascript:window.history.back();"><i class="icon-ok icon-white"></i>返回</a>
            </div>
        </div>
    </div>

    <div id="footer">
        <p>关于淘宝合作伙伴营销中心廉正举报联系客服开放平台诚征英才联系我们网站地图法律声明© 2003-2014 Taobao.com 版权所有</p>
        <p>网络文化经营许可证：文网文[2010]040号|增值电信业务经营许可证：浙B2-20080224-1|信息网络传播视听节目许可证：1109364号 </p>
    </div>
    <script type="text/javascript">
        //用户的基础信息
        var UINFO = {
            uid: 1111,
            uname: "2222",
            shop_type: 1//商家类型 为餐饮
        }
        </script>

    <script type="text/jquery-tmpl-x" id="j-tmpl-orderDetail-listitem">
        	{{each(i, v) list}}
	        	<tr data-oid="1">
					<td style="width:100px;"><img src="${v.ImgUrl}"></td>
					<td>${v.Title}</td>
					<td class="muted" style="width:80px;"><b class="text-error">${v.NowPrice}</b>元</td>
					<td class="muted" style="width:40px;"><b class="text-error">${v.Num}</b>份</td>
					<td class="muted" style="width:100px;"><b class="text-error">${v.TotalPrice}</b>元</td>
				</tr>
			{{/each}}
        </script>

    <script type="text/jquery-tmpl-x" id="j-tmpl-orderDetail-info">
        	<dl class="dl-horizontal muted">
				<dt>订单号</dt>
				<dd class="text-info">${Id}</dd>
				<dt>订单类型</dt>
				<dd class="text-info">
                    {{if Type == 0}}到店{{else}}送餐{{/if}}
                </dd>
				<dt>订单状态</dt>
				<dd class="text-info">
                    {{if Status == 1}}未付款
                    {{else Status == 2}}已付款
                    {{else Status == 3}}待发货
                    <a class="btn btn-success btn-mini" id="j-btn-orderDetail-reach" href="javascript:;" data-oid="1"><i class="icon-ok icon-white"></i> 已发货</a>
                    {{else Status == 4}}已发货
                    {{else}}已完结
                    {{/if}}
                    </dd>
				<dt>下单时间</dt>
				<dd class="text-info">${CreateTime}</dd>
			</dl>
        </script>

    <script type="text/jquery-tmpl-x" id="j-tmpl-orderDetail-user">
			<dl class="dl-horizontal muted">
				<dt>收货地址</dt>
				<dd class="text-info">${Address}</dd>
				<dt>联系方式</dt>
				<dd class="text-info">${Mobile}</dd>
				<dt>联系人</dt>
				<dd class="text-info">${LinkMan}</dd>
			</dl>
        </script>

    <script type="text/jquery-tmpl-x" id="j-tmpl-orderDetail-status">
        	<div class="bar {{if Status == 1}}bar-success{{else}}bar-info{{/if}}" style="width: {{if Type == 0}}33.333%{{else}}20%{{/if}};">未付款</div>
        	<div class="bar {{if Status == 2}}bar-success{{else}}bar-info{{/if}}" style="width: {{if Type == 0}}33.333%{{else}}20%{{/if}};">已付款</div>
            {{if Type > 0}}
			    <div class="bar {{if Status == 3}}bar-success{{else}}bar-info{{/if}}" style="width: 20%;">待发货</div>
			    <div class="bar {{if Status == 4}}bar-success{{else}}bar-info{{/if}}" style="width: 20%;">已发货</div>
            {{/if}}
			<div class="bar {{if Status == 5}}bar-success{{else}}bar-info{{/if}}" style="width: {{if Type == 0}}33.333%{{else}}20%{{/if}};">已完成</div>
		</script>

    <script type="text/jquery-tmpl-x" id="j-tmpl-orderDetail-footer">
        	<div class="muted pull-right text-right">
				<p><span class="label label-info">合计</span> <b class="text-error ">${StotalPrice}</b>元</p>
                {{if Type == 0}}
				    <p><b class="text-error">+</b> <span class="label label-info">配送费</span> <b class="text-error">${SendPrice}</b>元</p>
                {{/if}}
                {{if CtotalPrice > 0}}
				    <p><b class="text-error">-</b> <span class="label label-success">${Ccontent}</span> <b class="text-error">${CtotalPrice}</b>元</p> 
                {{/if}}
				<p><b class="text-error">=</b> <span class="label label-info">实际付款</span> <b class="text-error">${TotalPrice}</b>元</p>
			</div>

			<blockquote>
				<p>${Remark}</p>
				<small>用户备注</small>
			</blockquote>
		</script>
    <%-- Common.tip({type : "info", content :"asfdsadf"})
        Common.tip({type : "success", content :"asfdsadf"})
        Common.tip({type : "warning", content :"asfdsadf"})
        Common.tip({type : "error", content :"asfdsadf"})--%>
    <script type="text/javascript">
        var MPage = {
            hander: "<%=DomainUrl %>/Handler/Orders/OrdersHandler.ashx?action=",
            init: function () {
                var mpage = this;

                //去掉之前选中打开的项 选中产品列表
                $("#sidebar li").removeClass("active open");
                $("#sidebar .sidebar_orders").addClass("active open");

                var orderid = Str.getQueryString("id");
                if (orderid == null) {
                    Common.tip({ type: "error", content: "不存在此订单" });
                    return false;
                } else {
                    mpage.getOrderDetail(orderid);
                }
            },

            //p 页码
            //type tab 类型
            getOrderDetail: function (orderid) {
                var mpage = this;
                $.post(mpage.hander + "getOrdersDetail", { orderid: orderid }, function (data) {
                    if (!data.error) {
                        $("#j-orderDetail-list").html($("#j-tmpl-orderDetail-listitem").tmpl(data.data));
                        $("#j-orderDetail-info").html($("#j-tmpl-orderDetail-info").tmpl(data.data));
                        $("#j-orderDetail-user").html($("#j-tmpl-orderDetail-user").tmpl(data.data));
                        $("#j-orderDetail-status").html($("#j-tmpl-orderDetail-status").tmpl(data.data));
                        $("#j-orderDetail-footer").html($("#j-tmpl-orderDetail-footer").tmpl(data.data));

                        $("#j-btn-orderDetail-reach").bind("click", function () {
                            var $btn = $(this);
                            var id = $btn.attr("data-oid");

                            Common.confirm({
                                title: "订单修改提示",
                                content: "您确定要将该订单的状态修改为已发货？",
                                confirm: function () {
                                    //执行确认回调
                                    mpage.SetOrderDelivered(id);
                                    
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
            },

            //设置订单状态为已发送
            SetOrderDelivered: function (id) {
                var mpage = this;
                $.post(mpage.hander + "setOrdersDelivered", { ids: id }, function (data) {
                    if (!data.error) {
                        Common.tip({ type: "success", content: data.success });
                        $("#j-orderDetail-status").find(".bar").eq(0).removeClass("bar-success").addClass("bar-info").end().eq(1).removeClass("bar-info").addClass("bar-success");
                        $("#j-btn-orderDetail-reach").remove();
                    } else {
                        Common.tip({ type: "error", content: data.error });
                    }
                }, "JSON");
            },
        };

        $(function () {
            MPage.init();
        });

        </script>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Footer" runat="server">
</asp:Content>


