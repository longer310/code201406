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
    <script type="text/javascript" src="<%=DomainUrl %>/Script/js/chart.js"></script>
    <script type="text/javascript" src="<%=DomainUrl %>/Script/js/jquery.peity.min.js"></script>

    <script type="text/jquery-tmpl-x" id="j-tmpl-charge-rankitem">
        {{if List.length > 0}}
        	{{each(i, v) List}}
	        	<tr data-gid="1">
					<td style="width:30px;">${i+1}</td>
					<td style="width:200px;">${v.UserName}</td>
					<td>${v.TotalMoney}</td>
					<td>${v.Pre}</td>
				</tr>
			{{/each}}
        {{else}}
            <tr>
                <td colspan="4" align="center">查找不到充值记录</td>
            </tr>
        {{/if}}
        
    </script>

    <script type="text/jquery-tmpl-x" id="j-tmpl-charge-max_analysis">
        	<li>
				<div class="left peity_bar_all"><span>2,4,9,7,12,10,12,2,4,9,7,12,10,12,2,4,9,7,12,10,12,2,4,9,7,12,10,12</span>${Stat.LTotalMoneyPre}</div>
				<div class="right">
					<strong>${Stat.TotalMoney}</strong>
					总充值金额
				</div>
			</li>
			<li>
				<div class="left peity_bar_per"><span>20,15,18,14,10,9,9,9</span>${Stat.LMaxSingleMoneyPre}</div>
				<div class="right">
					<strong>${Stat.MaxSingleMoney}</strong>
					最高单笔充值
				</div>
			</li>
			<li>
				<div class="left peity_bar_count"><span>3,5,9,7,12,20,10</span>${Stat.LUserCountPre}</div>
				<div class="right">
					<strong>${Stat.UserCount}</strong>
					充值人数
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
                $("#sidebar .sadebaer_dbs").addClass("active open").find(".sidebar_chargestat").addClass("active");

                $('#j-charge-tab a').click(function (e) {
                    var type = $(this).parent().index();
                    $(this).tab('show');
                    mpage.getDetail(type);
                    return false;
                });

                mpage.getDetail(0);
            },

            getDetail: function (type) {
                var mpage = this;

                $.post(mpage.hander + "getchargestat", { type: type, start: 0, limit: 10 }, function (data) {
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
                        $("#j-charge-max_analysis").html($("#j-tmpl-charge-max_analysis").tmpl(data.data));

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
                        $("#j-charge-list").html($("#j-tmpl-charge-rankitem").tmpl(data.data));
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
