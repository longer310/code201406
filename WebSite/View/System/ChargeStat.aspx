<%@ Page Title="" Language="C#" MasterPageFile="~/View/merchant.Master" AutoEventWireup="true" CodeBehind="ChargeStat.aspx.cs" Inherits="Backstage.View.System.ChargeStat" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Header" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Content" runat="server">

    <div class="widget-box">
        <div class="widget-title">
            <span class="icon">
                <i class="icon-hdd"></i>
            </span>
            <h5>充值量统计</h5>
        </div>
        <div class="widget-content">
            <ul class="nav nav-tabs" id="j-charge-tab">
                <li class="active"><a href="#">日充值量</a></li>
                <li><a href="#">月充值量</a></li>
                <li><a href="#">季度充值量</a></li>
                <li><a href="#">年充值量</a></li>
            </ul>
            <div>
                <canvas id="canvas" height="150" width="600"></canvas>
            </div>

            <div style="text-align: center;">
                <ul class="stat-boxes" id="j-charge-max_analysis">
                </ul>
            </div>

            <table class="table table-bordered table-striped">
                <thead>
                    <tr>
                        <th>排名</th>
                        <th>时间</th>
                        <th>会员账号</th>
                        <th>金额</th>
                        <th>占比</th>
                    </tr>
                </thead>
                <tbody id="j-charge-list">
                </tbody>
            </table>


        </div>
    </div>


</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Footer" runat="server">
    <!--页面js-->
    <script src="../public/js/chart.js"></script>
    <script src="../public/js/jquery.peity.min.js"></script>

    <script type="text/jquery-tmpl-x" id="j-tmpl-charge-rankitem">
        	{{each(i, v) list}}
	        	<tr data-gid="1">
					<td style="width:30px;">${i+1}</td>
					<td style="width:150px;">2012-12-23 10:12:23</td>
					<td style="width:200px;">czonechan</td>
					<td>56</td>
					<td>2.1</td>
				</tr>
			{{/each}}
        </script>

    <script type="text/jquery-tmpl-x" id="j-tmpl-charge-max_analysis">
        	<li>
				<div class="left peity_bar_all"><span>2,4,9,7,12,10,12,2,4,9,7,12,10,12,2,4,9,7,12,10,12,2,4,9,7,12,10,12</span>+20%</div>
				<div class="right">
					<strong>36094</strong>
					总充值金额
				</div>
			</li>
			<li>
				<div class="left peity_bar_per"><span>20,15,18,14,10,9,9,9</span>0%</div>
				<div class="right">
					<strong>1433</strong>
					最高单笔充值
				</div>
			</li>
			<li>
				<div class="left peity_bar_count"><span>3,5,9,7,12,20,10</span>-50%</div>
				<div class="right">
					<strong>8650</strong>
					充值人数
				</div>
			</li>
        </script>
    <script type="text/javascript">
        var sellerId = '<%=SellerId%>';

        var MPage = {
            init: function () {
                var mpage = this;


                $('#j-charge-tab a').click(function (e) {
                    var type = $(this).parent().index();
                    $(this).tab('show');
                    mpage.getDetail(type);
                    return false
                });

                mpage.getDetail(1);
            },

            getDetail: function () {
                var mpage = this;

                $.ajax({
                    url: "../../Handler/Backstage/SystemHandler.ashx?action=getchargestat",
                    type: "get",
                    dataType: "json"
                    //context: document.body
                }).success(function (data) {

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
                            ],
                            count: 0
                        }
                    };

                    json.result = data.data.Results;
                    json.result.count = data.data.TotalCount;

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
                    $("#j-charge-max_analysis").html($("#j-tmpl-charge-max_analysis").tmpl(json.result));

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
                    $(".peity_bar_per span").peity("bar", {
                        colour: "#BA1E20"
                    });
                    $(".peity_bar_count span").peity("bar", {
                        colour: "#090f7f"
                    });

                    //排行
                    $("#j-charge-list").html($("#j-tmpl-charge-rankitem").tmpl(json.result));
                    //});
                });
            }
        }

        $(function () {
            MPage.init();
        });

        </script>

</asp:Content>
