<%@ Page Title="" Language="C#" MasterPageFile="~/View/merchant.Master" AutoEventWireup="true" CodeBehind="SaleStat.aspx.cs" Inherits="Backstage.View.System.SaleStat" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Header" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Content" runat="server">
    <div class="widget-box" >
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
					<div><canvas id="canvas" height="150" width="600"></canvas></div>

					<div style="text-align:center;">
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
        <script src="../public/js/chart.js"></script>
        <script src="../public/js/jquery.peity.min.js"></script>

        <script type="text/jquery-tmpl-x" id="j-tmpl-sale-rankitem">
        	{{each(i, v) list}}
	        	<tr data-gid="1">
					<td style="width:30px;">${i+1}</td>
					<td style="width:150px;">商品页面</td>
					<td style="width:200px;">商品列表页</td>
					<td>56</td>
					<td>2.1</td>
				</tr>
			{{/each}}
        </script>

        <script type="text/jquery-tmpl-x" id="j-tmpl-sale-max_analysis">
        	<li>
				<div class="left peity_bar_all"><span>2,4,9,7,12,10,12,2,4,9,7,12,10,12,2,4,9,7,12,10,12,2,4,9,7,12,10,12</span>+20%</div>
				<div class="right">
					<strong>36094</strong>
					总销售金额
				</div>
			</li>
			<li>
				<div class="left peity_bar_gn"><span>20,15,18,14,10,9,9,9</span>0%</div>
				<div class="right">
					<strong>1433</strong>
					销售商品数量
				</div>
			</li>
			<li>
				<div class="left peity_bar_cn"><span>3,5,9,7,12,20,10</span>-50%</div>
				<div class="right">
					<strong>8650</strong>
					消费人数
				</div>
			</li>
			<li>
				<div class="left peity_bar_on"><span>3,5,9,7,12,20,10</span>-50%</div>
				<div class="right">
					<strong>8650</strong>
					订单数量
				</div>
			</li>
        </script>
        <script type="text/javascript">
            var sellerId = '<%=SellerId%>';

            var MPage = {
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

                    mpage.getDetail(1);
                },

                getDetail: function () {
                    var mpage = this;

                    //$.getJSON("", { type : type}， function(json){
                    var json = {
                        code: 0,
                        msg: "",
                        result: {
                            list: [
                                {},
                                {},
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



                    //明细图表
                    var randomScalingFactor = function () { return Math.round(Math.random() * 50) };
                    var labels = [];
                    var data = [];

                    for (var i = 1; i <= 24; i++) {
                        labels.push(i);
                        data.push(randomScalingFactor());
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
                                pointHighlightStroke: "rgba(220,220,220,1)", scaleSteps: 20,
                                data: data
                            }
                        ]

                    }

                    var ctx = document.getElementById("canvas").getContext("2d");
                    window.myLine = new Chart(ctx).Line(lineChartData, {
                        responsive: true
                    });

                    //总计图表
                    $("#j-sale-max_analysis").html($("#j-tmpl-sale-max_analysis").tmpl(json.result));

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
                    $("#j-sale-list").html($("#j-tmpl-sale-rankitem").tmpl(json.result));
                    //});
                }
            }

            $(function () {
                MPage.init();
            });

        </script>
</asp:Content>
