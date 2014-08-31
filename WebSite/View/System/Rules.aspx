<%@ Page Title="" Language="C#" MasterPageFile="~/View/merchant.Master" AutoEventWireup="true" CodeBehind="Rules.aspx.cs" Inherits="Backstage.View.System.Rules" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Header" runat="server">
    <link href="../Script/kindeditor/themes/default/default.css" type="text/css" rel="stylesheet" />
    <link href="../css/css/select2.css" type="text/css" rel="stylesheet" />
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
                                <option value="1">充值总额</option>
                                <option value="2">获得积分</option>
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
                            <input type="text" value="3" class="input-small" id="j-charge" />
                            元 

									

                            <label class="inline" style="margin-left: 20px;">满</label>
                            <input type="text" value="3" class="input-small" id="j-comment" />
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
    <script src="../scirpts/js/ue.pager.js"></script>

    <script type="text/jquery-x-tmpl" id="j-tmpl-level">
      		{{each(i, v) list}}
	      		<div class="control-group">
					<div class="controls">
						<label class="inline">级别${v.id}名称</label>
						<input type="text" value="${v.name}" class="input-small j-level_name" />
						<label class="inline" style="margin-left:20px;">享受折扣</label>
						<input type="text" value="${v.discount}" class="input-mini j-level_discount" /> 折
						<label class="inline j-level_condition_text" style="margin-left:20px;">{{if type == 0}}消费总额{{else type == 1}}充值总额{{else}}获得积分{{/if}}需</label>
						<input type="text" value="${v.condition}" class="input-small j-level_condition" /> 元
					</div>
				</div>
			{{/each}}
      	</script>

    <script type="text/javascript">
        var sellerId = '<%=SellerId%>';
        var MPage = {
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

                        case 1:
                            text = "充值总额需";
                            break;

                        case 2:
                            text = "获得积分需";
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
                        type: type,
                        list: [
                            {
                                id: count
                            }
                        ]
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
                    var data = {

                    };

                    $.ajax({
                        url: "../../Handler/Backstage/DevSystemHandler.ashx?action=addadmin",
                        type: "POST",
                        data: save_data,
                        dataType: "json"
                        //context: document.body
                    }).success(function (data) {
                       
                    });
                    return false;
                });

                mpage.initForm();
            },

            initForm: function () {
                var mpage = this;

                var rule_data = {
                    levels: {
                        type: 1,
                        list: [
                            {
                                id: 1,
                                name: "白金会员",
                                discount: "6.0",
                                condition: "10000"
                            },

                            {
                                id: 2,
                                name: "黄金会员",
                                discount: "7.0",
                                condition: "8000"
                            },

                            {
                                id: 3,
                                name: "铜牌会员",
                                discount: "7.5",
                                condition: "6000"
                            },

                            {
                                id: 4,
                                name: "普通会员",
                                discount: "8.0",
                                condition: "2000"
                            }
                        ]
                    }
                }

                mpage.addLevel(rule_data.levels);
                $("#j-level_condition_type").val(rule_data.levels.type);
                $("#j-level_count").val(rule_data.levels.list.length);
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
