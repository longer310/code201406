﻿<%@ Page Title="" Language="C#" MasterPageFile="~/View/merchant.Master" AutoEventWireup="true" CodeBehind="Add.aspx.cs" Inherits="Backstage.View.Cash.Add" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Header" runat="server">
    <!--页面样式-->
    <link href="../../script/kindeditor/themes/default/default.css" type="text/css" rel="stylesheet" />
    <link href="../../script/css/select2.css" type="text/css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Content" runat="server">
    <div class="widget-box" >
				<div class="widget-title">
					<span class="icon">
						<i class="icon-cog"></i>
					</span>
					<h5>提现</h5>
				</div>
				<div class="widget-content">
					<div class="widget-box" >

						<div class="widget-content">
						
							<form action="#" method="get" class="form-horizontal" id="j-activity-addForm" />
								<div class="control-group control-group-text">
									<label class="control-label">当前账户可提现金额</label>
									<div class="controls">
										￥3233.00
									</div>
								</div>

								<div class="control-group control-group-text">
									<label class="control-label">冻结金额</label>
									<div class="controls">
										￥3233.00
									</div>
								</div>

								<div class="control-group control-group-text">
									<label class="control-label">您的签约模式</label>
									<div class="controls text-error">
										模式B，所有提现将扣除5%的手续费
									</div>
								</div>

								<div class="control-group">
									<label class="control-label">提现金额</label>
									<div class="controls">
										<input type="text" id="j-realname" /> 元
									</div>
								</div>

								<div class="control-group control-group-text">
									<label class="control-label"></label>
									<div class="controls text-error">
										（注：体现周期为1个工作日，节假日不可到帐）
									</div>
								</div>

								<div class="form-actions">
									<button type="submit" class="btn btn-primary"><i class="icon-share-alt icon-white"></i> 确认提现</button>
								</div>
							</form>				
							
						</div>
					</div>

					<div class="widget-box" >
						<div class="widget-title">
							<h5>收款信息</h5>
						</div>
						<div class="widget-content">
							<form action="#" method="get" class="form-horizontal" id="j-activity-addForm" />
								<div class="control-group">
									<label class="control-label">银行信息</label>
									<div class="controls">
										<select id="j-bank">
											<option>中国银行</option>
										</select>
									</div>
								</div>

								<div class="control-group">
									<label class="control-label">开户行</label>
									<div class="controls">
										<input type="text" id="j-bank_open" />
									</div>
								</div>

								<div class="control-group">
									<label class="control-label">银行卡号</label>
									<div class="controls">
										<input type="text" id="j-card" />
									</div>
								</div>

								<div class="control-group">
									<label class="control-label">开户名</label>
									<div class="controls">
										<input type="text" id="j-realname" />
									</div>
								</div>

								<div class="form-actions">
									<button type="submit" class="btn btn-primary"><i class="icon-ok icon-white"></i> 保存</button>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Footer" runat="server">
    <!--页面js-->
        <script src="../../script/js/ue.pager.js"></script>
      	
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

		<script>
		    var sellerId = '<%=SellerId%>';
		    var MPage = {
		        init: function () {
		            var mpage = this;


		            //绑定提交表单
		            $("#j-rule_form").bind("submit", function () {


		                alert('提交数据');
		                return false;
		            });

		            mpage.initForm();
		        },

		        initForm: function () {
		            var mpage = this;
		        }
		    }

		    $(function () {
		        MPage.init();
		    });

        </script>

</asp:Content>