<%@ Page Title="" Language="C#" MasterPageFile="~/View/merchant.Master" AutoEventWireup="true" CodeBehind="Rules.aspx.cs" Inherits="Backstage.View.System.Rules" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Header" runat="server">
    <link href="<%=DomainUrl %>/Script/kindeditor/themes/default/default.css" type="text/css" rel="stylesheet" />
    <link href="<%=DomainUrl %>/css/css/select2.css" type="text/css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Content" runat="server">
    <div class="widget-box">
        <div class="widget-title">
            <span class="icon">
                <i class="icon-cog"></i>
            </span>
            <h5>规则设置</h5>
        </div>
        <div class="widget-content">

            <form action="#" method="get" class="form-horizontal" id="j-rule_form" />
            <div class="widget-box">
                <div class="widget-title">
                    <h5>会员设置</h5>
                </div>
                <div class="widget-content">

                    <div class="control-group">
                        <div class="controls">
                            <label class="inline">会员级别</label>
                            <input type="text" value="3" class="input-small" readonly="readonly" id="j-level_count" />
                            级
									
                            <a href="javascript:;" title="增加一级" class="icon icon-plus-sign" id="j-add_level"></a>
                            <a href="javascript:;" title="减少一级" class="icon icon-minus-sign" id="j-remove_level"></a>

                            <label class="inline" style="margin-left: 20px;">级别判断</label>
                            <select id="j-level_condition_type">
                                <option value="0">消费总额</option>
                                <%--<option value="1">充值总额</option>
                                <option value="2">获得积分</option>--%>
                            </select>
                        </div>
                    </div>

                    <div id="j-level_list">
                    </div>

                </div>
            </div>

            <div class="widget-box">
                <div class="widget-title">
                    <h5>积分获得设置</h5>
                </div>
                <div class="widget-content">

                    <div class="control-group">
                        <div class="controls">
                            <label class="inline">充值获得比例：1元=</label>
                            <input type="text" value="3" class="input-small" id="j-charge" />
                            分 
                           
                            <label class="inline" style="margin-left: 20px;">留言评论获得：</label>
                            <input type="text" value="3" class="input-small" id="j-comment" />
                            分 
								
                        </div>
                    </div>

                    <div class="control-group">
                        <div class="controls">
                            <label class="inline">消费获得比例：1元=</label>
                            <input type="text" value="3" class="input-small" id="j-cost" />
                            分 
	
									

                            <label class="inline" style="margin-left: 20px;">分享平台获得：</label>
                            <input type="text" value="3" class="input-small" id="j-share" />
                            分 
								
                        </div>
                    </div>
                </div>
            </div>

            <div class="widget-box">
                <div class="widget-title">
                    <h5>其他设置</h5>
                </div>
                <div class="widget-content">

                    <div class="control-group">
                        <div class="controls">
                            <label class="inline">运费</label>
                            <input type="text" value="3" class="input-small" id="j-freight" />
                            元 
                           
                            <label class="inline" style="margin-left: 20px;">满</label>
                            <input type="text" value="3" class="input-small" id="j-freefreight" />
                            免运费 
                       
                        </div>
                    </div>
                </div>
            </div>

            <div class="form-actions">
                <button type="submit" class="btn btn-primary"><i class="icon-ok icon-white"></i>完成保存</button>
            </div>
            </form>
			
        </div>
    </div>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Footer" runat="server">
    <script src="<%=DomainUrl %>/Script/js/ue.pager.js"></script>

    <script type="text/jquery-x-tmpl" id="j-tmpl-level">
      		
	      		<div class="control-group css-levels" data-id="${Id}" data-level="${Level}">
					<div class="controls">
						<label class="inline">级别${Level}名称</label>
						<input type="text" value="${Title}" class="input-small j-level_name" />
						<label class="inline" style="margin-left:20px;">享受折扣</label>
						<input type="text" value="${Discount}" class="input-mini j-level_discount" /> 折
						<label class="inline j-level_condition_text" style="margin-left:20px;">消费总额需</label>
						<input type="text" value="${NeedMoney}" class="input-small j-level_condition" /> 元
					</div>
				</div>
			
      	</script>

    <script type="text/javascript">
        var sellerId = '<%=SellerId%>';
        var MPage = {
            levels: [],
            init: function () {
                var mpage = this;
                var count;
                //会员设置
                $("#j-level_condition_type").bind("change", function () {
                    var type = parseInt($("#j-level_condition_type").val()) || 0;

                    var text = "";

                    switch (type) {
                        case 0:
                            text = "消费总额需";
                            break;
                    }

                    $("#j-level_list .j-level_condition_text").html(text);
                });

                $("#j-add_level").bind("click", function () {
                    count = parseInt($("#j-level_count").val()) || 0,
                        type = parseInt($("#j-level_condition_type").val()) || 0;

                    count++;
                    $("#j-level_count").val(count);
                    mpage.addLevel({

                        Id: 0,
                        Level: count
                    });
                });

                $("#j-remove_level").bind("click", function () {
                    count = parseInt($("#j-level_count").val()) || 0;
                    count--;
                    if (count < 0) {
                        count = 0;
                    }
                    $("#j-level_count").val(count);
                    mpage.removeLevel();
                });

                //积分获得设置

                //绑定提交表单
                $("#j-rule_form").bind("submit", function () {
                    var save_data = {
                        levels: mpage.getsubmitLevels(),
                        cmi: $("#j-comment").val(),
                        costi: $("#j-cost").val(),
                        ri: $("#j-charge").val(),
                        si: $("#j-share").val(),
                        fe: $("#j-freight").val(),
                        nffe: $("#j-freefreight").val()
                    };

                    $.ajax({
                        url: "../../Handler/Backstage/SystemHandler.ashx?action=updaterules&sellerId=" + sellerId,
                        type: "POST",
                        data: save_data,
                        dataType: "json"
                        //context: document.body
                    }).success(function (data) {
                        alert("更新成功");
                    });
                    return false;
                });

                mpage.initForm();
            },
            getsubmitLevels: function () {
                var $arr = $(".css-levels");
                var levels = [];
                $arr.each(function () {
                    var level = {
                        Id: parseInt($(this).attr("data-id")),
                        Level: parseInt($(this).attr("data-level")),
                        Title: $(this).find(".j-level_name").val(),
                        Discount: $(this).find(".j-level_discount").val(),
                        SellerId: sellerId,
                        NeedMoney: $(this).find(".j-level_condition").val()
                    }
                    levels.push(level);
                });

                var json = JSON.stringify(levels);
                return json;
            },
            initForm: function () {
                var mpage = this;

                var rule_data = {
                    levels: {
                        type: 1,
                        list: [
                            {
                                Level: 1,
                                Title: "",
                                Discount: "6.0",
                                NeedMoney: "10000"
                            }
                        ]
                    }
                }
                $.ajax({
                    url: "../../Handler/Backstage/SystemHandler.ashx?action=getrules&sellerId=" + sellerId,
                    dataType: "json",
                    type: "get"
                }).success(function (data) {
                    mpage.levels = data.data.Userlevels;
                    $("#j-charge").val(data.data.ReChargeIntegral);
                    $("#j-comment").val(data.data.CommentIntegral);
                    $("#j-cost").val(data.data.ConsumptionIntegral);
                    $("#j-share").val(data.data.ShareIntegral);
                    $("#j-level_count").val(data.data.Userlevels.length);
                    $("#j-freight").val(data.data.Freight);
                    $("#j-freefreight").val(data.data.NeedToFreeFreight);
                    mpage.addLevel(data.data.Userlevels);
                });
            },

            addLevel: function (data) {
                $("#j-level_list").append($("#j-tmpl-level").tmpl(data));
            },

            removeLevel: function () {
                $("#j-level_list .control-group").last().remove();
            }
        }

        $(function () {
            MPage.init();
        });

        </script>
</asp:Content>
