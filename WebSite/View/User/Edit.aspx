﻿<%@ Page Title="" Language="C#" MasterPageFile="~/View/merchant.Master" AutoEventWireup="true" CodeBehind="Edit.aspx.cs" Inherits="Backstage.View.User.Edit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Header" runat="server">
    <link rel="shortcut icon" href="<%=DomainUrl %>/Css/img/favicon.ico">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Content" runat="server">

    <div class="widget-box">
        <div class="widget-title">
            <span class="icon">
                <i class="icon-user"></i>
            </span>
            <h5>会员信息</h5>
            <div class="buttons">
            </div>
        </div>
        <div class="widget-content">
            <form action="#" method="get" class="form-horizontal user-detail">
                <div id="j-user-detail">
                </div>

                <div class="form-actions">
                    <a href="javascript:history.back();" class="btn">返回</a>
                    <%--<button type="submit" class="btn btn-primary">保存修改</button>--%>
                    <a href="javascript:void(0);" id="save" class="btn btn-primary"><i class="icon-ok icon-white"></i>保存修改</a>
                </div>
            </form>
        </div>

        <div class="widget-footer">
        </div>
    </div>

    <div id="footer">
        <p>关于淘宝合作伙伴营销中心廉正举报联系客服开放平台诚征英才联系我们网站地图法律声明© 2003-2014 Taobao.com 版权所有</p>
        <p>网络文化经营许可证：文网文[2010]040号|增值电信业务经营许可证：浙B2-20080224-1|信息网络传播视听节目许可证：1109364号 </p>
    </div>

    <!--页面js-->
    <script type="text/jquery-tmpl-x" id="j-tmpl-user-detail">
        	<table class="table table-striped table-bordered">
                <tbody>
                	<tr>
                		<td rowspan="3" style="text-align:center; width:120px;"><img width="100" height="100" src="${User.Avatar}" /></td>
                		<th>会员账号：</th>
                        <td><span class="text-info">${User.UserName}</span></td>
                        <th>性　　别：</th>
                        <td>
                            <span class="text-info">
                                {{if User.Sex == 0}}男
                                {{else}}女
                                {{/if}}
                            </span>
                        </td>
                	</tr>
                    <tr>
                        <th>昵　　称：</th>
                        <td><span class="text-info">${User.NickName}</span></td>
                        <th>手机号码：</th>
                        <td><span class="text-info">${User.Phone}</span></td>
                    </tr>

                    <tr>
                        <th>折　　扣：</th>
                        <td><span class="text-info"><input type="text" value="${User.Discount}" readonly="readonly" class="text-input" style="width:30px;" id="j-user-discount"> 折</span></td>
                        <th>会员类型：</th>
                        <td><select id="j-user-type">
                        	<%--<option data-discount="10" {{if RoleType%10==0}}selected="selected"{{/if}} value="0">普通会员</option>
                        	<option data-discount="8" {{if RoleType%10==1}}selected="selected"{{/if}} value="1">高级会员</option>--%>
                            {{each(i, v) UserLevels}}
                        		<option value="${v.Id}" data-discount="${v.Discount}" {{if User.RoleType%10 == v.Id}}selected="selected"{{/if}}>${v.Title}</option>
                        	{{/each}}
                        </select></td>
					</dl></td>
                    </tr>
                </tbody>
            </table>

			<table class="table table-striped table-bordered">

                <tbody>
                    <tr>
                    	<th style="width:16.66%">收货地址：</th>
                        <td style="width:16.66%"><span class="text-info">${User.Address}</span></td>
                        <th style="width:16.66%">联系人：</th>
                        <td style="width:16.66%"><span class="text-info">${User.LinkMan}</td>
                        <th style="width:16.66%">联系电话：</th>
                        <td style="width:16.66%"><span class="text-info">${User.Phone}</span></td>
                    </tr>
                </tbody>
            </table>

            <table class="table table-striped table-bordered">
                <tbody>
                    <tr>
                        <th style="width:16.66%">账户余额：</th>
                        <td style="width:16.66%"><b class="text-error">${User.Money}</b>元</td>
                        <th style="width:16.66%">累计登陆次数：</th>
                        <td style="width:16.66%"><b class="text-error">${User.TotalLoginCount}</b>次</td>
                        <th style="width:16.66%">累计消费金额：</th>
                        <td style="width:16.66%"><b class="text-error">${User.TotalConsume}</b>元</td>
                    </tr>

                    <tr>
                        <th style="width:16.66%">积分：</th>
                        <td style="width:16.66%"><b class="text-error">${User.Integral}</b>分</td>
                        <th style="width:16.66%">最近登录时间：</th>
                        <td style="width:16.66%"><span class="text-info">${User.LastLoginTime.ToDate().Format("yyyy-MM-dd hh:mm:ss")}</span></td>
                        <th style="width:16.66%">累计充值金额：</th>
                        <td style="width:16.66%"><b class="text-error">${User.TotalRecharge}</b>元</td>
                    </tr>

                    <tr>
                        <th style="width:16.66%"></th>
                        <td style="width:16.66%"></td>
                        <th style="width:16.66%">注册日期：</th>
                        <td style="width:16.66%"><span class="text-info">${User.RegisterTime.ToDate().Format("yyyy-MM-dd hh:mm:ss")}</span></td>
                        <th style="width:16.66%">累计订单数：</th>
                        <td style="width:16.66%"><b class="text-error">${User.TotalOrdersCount}</b>次</td>
                    </tr>

                </tbody>
            </table>

            <div class="control-group">
				<label class="control-label">用户备注</label>
				<div class="controls">
					<textarea id="j_user_remark">${User.Remark}</textarea>
				</div>
			</div>
        </script>
    <script type="text/javascript">
        var sellerId = '<%=SellerId%>';
        var MPage = {
            hander: "<%=DomainUrl %>/Handler/Merchant/UserHandler.ashx?sellerId=" + sellerId + "&action=",
            uid: 0,
            init: function () {
                var mpage = this;

                //去掉之前选中打开的项 选中产品列表
                $("#sidebar li").removeClass("active open");
                $("#sidebar .sidebar_user").addClass("active open");

                //解析url中的id
                /\?id=(\d+)/.test(document.location.href);
                var user_id = RegExp.$1;
                if (user_id) {
                    mpage.getUserDetail(user_id);
                } else {
                    alert("该用户不存在");
                    window.history.back();
                }

                $("#save").bind("click", function () {
                    mpage.saveUser();
                });
            },

            getUserDetail: function (userid) {
                var mpage = this;
                mpage.uid = userid;
                $.post(mpage.hander + "getUserDetail", { userid: userid }, function (data) {
                    if (!data.error) {
                        $("#j-user-detail").html($("#j-tmpl-user-detail").tmpl(data.data));
                        
                        $("#j-user-type").bind("change", function () {
                            var discount = $(this).find("option:checked").attr("data-discount");

                            $("#j-user-discount").val(discount);
                        });
                    } else {
                        Common.tip({ type: "error", content: data.error });
                        //Common.alert({
                        //    title: "提示",
                        //    content: data.error,
                        //    confirm: function () {
                        //    }
                        //});
                    }
                }, "JSON");
            },

            saveUser: function () {
                var mpage = this;
                var discount = $("#j-user-discount").val();
                var remark = $("#j_user_remark").val();
                var roletype = $("#j-user-type").find("option:selected").val();
                $.post(mpage.hander + "saveUser", { uid: mpage.uid, discount: discount, remark: remark, roletype: roletype },
                    function (data) {
                        if (!data.error) {
                            Common.tip({ type: "success", content: data.success });
                            window.location.href = "<%=DomainUrl %>/View/User/User.aspx?sellerId=" + sellerId;
                        } else {
                            Common.tip({ type: "error", content: data.error });
                            //Common.alert({
                            //    title: "提示",
                            //    content: data.error,
                            //    confirm: function () {
                            //    }
                            //});
                        }
                    }, "JSON");
            }
        };

            $(function () {
                MPage.init();
            });

        </script>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Footer" runat="server">
</asp:Content>


