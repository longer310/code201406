<%@ Page Title="" Language="C#" MasterPageFile="~/View/merchant.Master" AutoEventWireup="true" CodeBehind="SaleStat.aspx.cs" Inherits="Backstage.View.System.SaleStat" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Header" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Content" runat="server">
    <div class="widget-box">
        <div class="widget-title">
            <span class="icon">
                <i class="icon-hdd"></i>
            </span>
            <h5>销量统计</h5>
        </div>
        <div class="widget-content">
            <ul class="nav nav-tabs" id="j-sale-tab">
                <li class="active"><a href="#">日销量</a></li>
                <li><a href="#">月销量</a></li>
                <li><a href="#">季度销量</a></li>
                <li><a href="#">年销量</a></li>
            </ul>
            <div>
                <canvas id="canvas" height="150" width="600"></canvas>
            </div>

            <div style="text-align: center;">
                <ul class="stat-boxes" id="j-sale-max_analysis">
                </ul>
            </div>

            <table class="table table-bordered table-striped">
                <thead>
                    <tr>
                        <th>排名</th>
                        <th>商品分裂</th>
                        <th>商品名称</th>
                        <th>销量</th>
                        <th>占比</th>
                    </tr>
                </thead>
                <tbody id="j-sale-list">
                </tbody>
            </table>


        </div>
    </div>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Footer" runat="server">
    <!--页面js-->
    <script type="text/javascript" src="<%=DomainUrl %>/Script/js/chart.js"></script>
    <script type="text/javascript" src="<%=DomainUrl %>/Script/js/jquery.peity.min.js"></script>

    <script type="text/jquery-tmpl-x" id="j-tmpl-sale-rankitem">
        {{if List.length > 0}}	
        {{each(i, v) List}}
	        	<tr data-gid="1">
					<td style="width:30px;">${i+1}</td>
					<td style="width:150px;">${GoodsName}</td>
					<td style="width:200px;">${GoodsCategoriesName}</td>
					<td>${Num}</td>
					<td>${Pre}</td>
				</tr>
			{{/each}}
        {{else}}
            <tr>
                <td colspan="5" align="center">查找不到销售记录</td>
            </tr>
        {{/if}}
        
        </script>

    <script type="text/jquery-tmpl-x" id="j-tmpl-sale-max_analysis">
        	<li>
				<div class="left peity_bar_all"><span>2,4,9,7,12,10,12,2,4,9,7,12,10,12,2,4,9,7,12,10,12,2,4,9,7,12,10,12</span>${Stat.LTotalMoneyPre}</div>
				<div class="right">
					<strong>${Stat.TotalMoney}</strong>
					总销售金额
				</div>
			</li>
			<li>
				<div class="left peity_bar_gn"><span>20,15,18,14,10,9,9,9</span>${Stat.LTotalGoodsNumPre}</div>
				<div class="right">
					<strong>${Stat.TotalGoodsNum}</strong>
					销售商品数量
				</div>
			</li>
			<li>
				<div class="left peity_bar_cn"><span>3,5,9,7,12,20,10</span>${Stat.LUserCountPre}</div>
				<div class="right">
					<strong>${Stat.UserCount}</strong>
					消费人数
				</div>
			</li>
			<li>
				<div class="left peity_bar_on"><span>3,5,9,7,12,20,10</span>${Stat.LOrdersNumPre}</div>
				<div class="right">
					<strong>${Stat.OrdersNum}</strong>
					订单数量
				</div>
			</li>
        </script>
    <script type="text/javascript">
        var sellerId = '<%=SellerId%>';

        var MPage = {
            hander: "<%=DomainUrl %>/Handler/Merchant/StatisticsHandler.ashx?sellerId=" + sellerId + "&action=",
            init: function () {
                var mpage = this;

                //去掉之前选中打开的项 选中产品列表
                $("#sidebar li").removeClass("active open");
                $("#sidebar .sadebaer_dbs").addClass("active open").find(".sidebar_salestat").addClass("active");

                $('#j-sale-tab a').click(function (e) {
                    var type = $(this).parent().index();
                    $(this).tab('show');
                    mpage.getDetail(type);
                    return false
                });

                mpage.getDetail(0);
            },

            getDetail: function (type) {
                var mpage = this;

                $.post(mpage.hander + "getconsumestat", { type: type, start: 0, limit: 10 }, function (data) {
                    if (!data.error) {
                        //明细图表
                        var labels = [];
                        var ldata = [];

                        for (var i = 0; i < data.data.Stat.Xvalues.length; i++) {
                            labels.push(data.data.Stat.Xvalues[i]);
                            ldata.push(data.data.Stat.Yvalues[i]);
                        }

                        var lineChartData = {
                            labels: labels,

                            datasets: [
                                {
                                    label: "My First dataset",
                                    fillColor: "rgba(220,220,220,0.2)",
                                    strokeColor: "rgba(220,220,220,1)",
                                    pointColor: "rgba(220,220,220,1)",
                                    pointStrokeColor: "#fff",
                                    pointHighlightFill: "#fff",
                                    pointHighlightStroke: "rgba(220,220,220,1)",
                                    scaleSteps: 20,
                                    data: ldata
                                }
                            ]
                        };

                        var ctx = document.getElementById("canvas").getContext("2d");
                        window.myLine = new Chart(ctx).Line(lineChartData, {
                            responsive: true
                        });

                        //总计图表
                        $("#j-sale-max_analysis").html($("#j-tmpl-sale-max_analysis").tmpl(data.data));

                        $.fn.peity.defaults.bar = {
                            delimeter: ",",
                            height: 24,
                            max: null,
                            min: 0,
                            width: 50
                        };

                        $(".peity_bar_all span").peity("bar", {
                            colour: "#459D1C"
                        });
                        $(".peity_bar_gn span").peity("bar", {
                            colour: "#BA1E20"
                        });
                        $(".peity_bar_cn span").peity("bar", {
                            colour: "#090f7f"
                        });
                        $(".peity_bar_on span").peity("bar", {
                            colour: "#cec82e"
                        });

                        //排行
                        $("#j-sale-list").html($("#j-tmpl-sale-rankitem").tmpl(data.data));

                    } else {
                        Common.tip({ type: "error", content: data.error });
                    }
                }, "JSON");
            }
        }

        $(function () {
            MPage.init();
        });

        </script>
</asp:Content>
