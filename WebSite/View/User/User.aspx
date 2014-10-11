<%@ Page Title="" Language="C#" MasterPageFile="~/View/merchant.Master" AutoEventWireup="true" CodeBehind="User.aspx.cs" Inherits="Backstage.View.User.User" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Header" runat="server">
    <link rel="shortcut icon" href="<%=DomainUrl %>/Css/img/favicon.ico">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Content" runat="server">

    <div class="widget-box">
        <div class="widget-title">
            <span class="icon">
                <i class="icon-user"></i>
            </span>
            <h5>会员列表</h5>
            <div class="buttons">
                <a href="#" class="btn btn-danger btn-mini" id="j-btn-delSelected"><i class="icon-remove icon-white"></i>删除</a>
            </div>
        </div>
        <div class="widget-content">
            <table class="table table-bordered table-striped with-check">
                <thead>
                    <tr>
                        <th>
                            <input type="checkbox" id="j-btn-selectAll" name="title-table-checkbox" /></th>
                        <th>注册时间</th>
                        <th>会员账号</th>
                        <th>昵称</th>
                        <th>会员类型</th>
                        <th>性别</th>
                        <th>折扣</th>
                        <th>账户余额</th>
                        <th>积分</th>
                        <th>累计消费</th>
                        <th>最后登录</th>
                        <th>操作</th>
                    </tr>
                </thead>
                <tbody id="j-user-list">
                </tbody>
            </table>
        </div>

        <div class="widget-footer">
            <div class="pagination alternate" id="j-user-pagination">
                <ul class="page-main"></ul>
            </div>
        </div>
    </div>

    <div id="footer">
        <p>关于淘宝合作伙伴营销中心廉正举报联系客服开放平台诚征英才联系我们网站地图法律声明© 2003-2014 Taobao.com 版权所有</p>
        <p>网络文化经营许可证：文网文[2010]040号|增值电信业务经营许可证：浙B2-20080224-1|信息网络传播视听节目许可证：1109364号 </p>
    </div>

    <!--页面js-->
    <script type="text/javascript" src="<%=DomainUrl %>/Script/js/ue.pager.js"></script>

    <script type="text/jquery-tmpl-x" id="j-tmpl-user-listitem">
        	{{each(i, v) list}}
	        	<tr data-gid="${v.Id}">
					<td><input type="checkbox" class="j-select" /></td>
					<td>${v.CreateTime.ToDate().Format("yyyy-MM-dd hh:mm:ss")}</td>
					<td>${v.UserName}</td>
					<td>${v.NickName}</td>
					<td>
                        {{if v.RoleType % 10 == 0}}普通会员
                        {{else}}超级会员
                        {{/if}}
                    </td>
					<td>
                        {{if v.Sex == 0}}男
                        {{else}}女
                        {{/if}}
                    </td>
					<td>${v.Discount}</td>
					<td>￥<b class="text-error">${v.Money}</b></td>
					<td><b class="text-success">${v.Integral}</b>分</td>
					<td>￥<b class="text-error">${v.TotalConsume}</b></td>
					<td>${v.LastLoginTime.ToDate().Format("yyyy-MM-dd hh:mm:ss")}</td>
					<td style="width:120px;">
						<a class="btn btn-primary btn-mini" href="<%=DomainUrl %>/view/user/edit.aspx?id=${v.Id}&sellerId=<%=SellerId%>"><i class="icon-pencil icon-white"></i> 编辑</a>
						<a class="btn btn-danger btn-mini j-btn-del" href="javascript:void(0);"><i class="icon-remove icon-white"></i> 删除</a>
					</td>
				</tr>
			{{/each}}
    </script>

    <script type="text/javascript">
        var sellerId = '<%=SellerId%>';
        var MPage = {
            hander: "<%=DomainUrl %>/Handler/Merchant/UserHandler.ashx?sellerId=" + sellerId + "&action=",
            maxpage: 5,     //最多显示的页数
            start: 0,       //页码
            limit: 10,       //一页条数
            init: function () {
                var mpage = this;

                //去掉之前选中打开的项 选中产品列表
                $("#sidebar li").removeClass("active open");
                $("#sidebar .sidebar_user").addClass("active open");

                mpage.getUserList(1, 0);

                //绑定全选
                $("#j-btn-selectAll").bind("change", function () {
                    if ($(this).attr("checked")) {
                        $("#j-user-list .j-select:checkbox").attr("checked", "checked");
                    } else {
                        $("#j-user-list .j-select:checkbox").removeAttr("checked");
                    }

                    return false;
                });

                //绑定批量删除
                $("#j-btn-delSelected").bind("click", function () {
                    var $checked = $("#j-user-list .j-select:checked");

                    var ids = [];
                    $checked.each(function () {
                        ids.push($(this).parents("tr").attr("data-gid"));
                    });

                    if (ids.length > 0) {
                        Common.confirm({
                            title: "删除确认提示",
                            content: "您确定要删除当前选择的所有数据吗？",
                            confirm: function () {
                                mpage.delUserList(ids.join(","));
                                //删除成功后刷新本页
                                mpage.getUserList(mpage.currentPage);
                            }
                        });
                    } else {
                        Common.alert({
                            title: "提示",
                            content: "请至少选择一项"
                        });
                    }

                    return false;
                });
            },

            //删除单个用户 id:用户id
            //delUser: function (id) {
            //    var mpage = this;
            //    Common.confirm({
            //        title: "删除确认提示",
            //        content: Str.format("您确定要删除编号为{0}的会员？", id),
            //        confirm: function () {
            //            //执行确认回调
            //            mpage.delUserList(id);
            //        }
            //    });
            //},

            //删除用户列表
            delUserList: function (ids) {
                var mpage = this;
                $.post(mpage.hander + "delUserList", { ids: ids }, function (data) {
                    if (!data.error) {
                        Common.tip({ type: "success", content: data.success });
                        mpage.getUserList(mpage.start);
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

            //p 页码
            //type tab 类型
            getUserList: function (start) {
                var mpage = this;
                mpage.start = start;

                //$.getJSON("", { p: p}， function(json){
                //mpage.currentPag = p;
                $("#j-btn-selectAll").removeAttr("checked");
                //var json = {
                //    code: 0,
                //    msg: "",
                //    result: {
                //        count: 59,
                //        list: [
                //            {},
                //            {},
                //            {},
                //            {},
                //            {},
                //            {}
                //        ]
                //    }
                //};
                $.post(mpage.hander + "getUserList", { start: mpage.start - 1, limit: mpage.limit }, function (data) {
                    if (!data.error) {
                        $("#j-user-list").html($("#j-tmpl-user-listitem").tmpl(data));

                        ue.pager({
                            //target : $(".list_pager"),//放置分页的元素
                            pagerTarget: $("#j-user-pagination ul"),
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
                            maxPage: mpage.maxpage,//显示的最多页数
                            per: mpage.limit,//每页显示几个
                            count: data.count,
                            onchange: function (page) {//切换页数回调函数
                                mpage.getUserList(page);
                            }
                        });

                        //绑定单个删除
                        $("#j-user-list .j-btn-del").bind("click", function () {
                            var $item = $(this).parents("tr");
                            var id = $item.attr("data-gid");

                            Common.confirm({
                                title: "删除确认提示",
                                content: "您确定要删除当前用户？",
                                confirm: function () {
                                    //执行确认回调
                                    mpage.delUserList(id);
                                    //$item.remove();
                                },
                                cancel: function () {
                                    //执行取消回调
                                    alert('执行取消回调');
                                }
                            });
                            return false;
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



                //});

            }
        }

        $(function () {
            MPage.init();
        });

    </script>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Footer" runat="server">
</asp:Content>


