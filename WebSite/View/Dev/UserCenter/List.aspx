<%@ Page Title="" Language="C#" MasterPageFile="~/View/DevMaster.Master" AutoEventWireup="true" CodeBehind="List.aspx.cs" Inherits="Backstage.View.Dev.UserCenter.List" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Header" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Content" runat="server">
    <div class="widget-box">
        <div class="widget-title">
            <span class="icon">
                <i class="icon-cog"></i>
            </span>
            <h5>账户设置</h5>
            <div class="buttons">
                <a href="#" class="btn btn-danger btn-mini" id="j-btn-delSelected"><i class="icon-remove icon-white"></i>删除</a>
            </div>
        </div>
        <div class="widget-content">
            <ul class="nav nav-tabs">
                                <li class="active"><a href="List.aspx">管理员列表</a></li>
                <li><a href="Add.aspx">添加管理员</a></li>
                <li><a href="PwdEdit.aspx">密码修改</a></li>
            </ul>
            <table class="table table-bordered table-striped with-check">
                <thead>
                    <tr>
                        <th>
                            <input type="checkbox" id="j-btn-selectAll" name="title-table-checkbox" /></th>
                        <th>管理员账号</th>
                        <th>名称</th>
                        <th>管理员级别</th>
                        <th>最近登录</th>
                        <th>操作</th>
                    </tr>
                </thead>
                <tbody id="j-list">
                </tbody>
            </table>
        </div>

        <div class="widget-footer">
            <div class="pagination alternate" id="j-pagination">
                <ul class="page-main"></ul>
            </div>
        </div>
    </div>


</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Footer" runat="server">
    <!--页面js-->
    <script src="<%=DomainUrl %>/script/js/ue.pager.js"></script>

    <script type="text/jquery-tmpl-x" id="j-tmpl-listitem">
        	{{each(i, v) list}}
	        	<tr data-gid="${v.Id}">
					<td><input type="checkbox" class="j-select" /></td>
                    <td>${v.Id}</td>
                    <td>${v.NickName}</td>
					<td>${v.RoleType}</td>
					<td style="width:140px;">${v.LastLoginTime}</td>
					<td style="width:120px;">
                        <a href="Edit.aspx?id=${v.Id}" class="btn btn-primary btn-mini"><i class="icon-pencil icon-white"></i> 编辑</a>
						<a class="btn btn-danger btn-mini j-btn-del" href="javascript:;"><i class="icon-remove icon-white"></i> 删除</a>
					</td>
				</tr>
			{{/each}}
        </script>

    <script type="text/javascript">

        var MPage = {
            cid: 0,//当前分类 默认是全部分类
            pageNum: 1,//当前页

            init: function () {
                var mpage = this;

                mpage.getList(1);

                //绑定全选
                $("#j-btn-selectAll").bind("change", function () {
                    if ($(this).attr("checked")) {
                        $("#j-list .j-select:checkbox").attr("checked", "checked");
                    } else {
                        $("#j-list .j-select:checkbox").removeAttr("checked");
                    }

                    return false;
                });

                //绑定批量删除
                $("#j-btn-delSelected").bind("click", function () {
                    var $checked = $("#j-list :checked");

                    var ids = [];
                    $checked.each(function () {
                        ids.push($(this).parents("tr").attr("data-gid"));
                    });

                    if (ids.length > 0) {
                        Common.confirm({
                            title: "删除确认提示",
                            content: "您确定要删除当前选择的所有数据吗？",
                            confirm: function () {
                                //执行确认回调
                                $.ajax({
                                    url: "../../../Handler/Backstage/DevSystemHandler.ashx?action=deladmin&ids="+ids,
                                    type: "get",
                                    dataType: "json"
                                    //context: document.body
                                }).success(function (data) {
                                    //删除成功后刷新本页
                                    mpage.getList(mpage.pageNum);
                                });
                            },
                            cancel: function () {
                                //执行取消回调
                            }
                        });
                    } else {
                        Common.alert({
                            title: "提示",
                            content: "请至少选择一项",
                            confirm: function () {
                                //执行确认回调
                            }
                        });
                    }

                    return false;
                });
            },


            //p 页码
            //type tab 类型
            getList: function (p) {
                var mpage = this;

                mpage.pageNum = p;
                //$.getJSON("", { p: p}, function(json){
                var json = {
                    code: 0,
                    msg: "",
                    result: {
                        count: 59,
                        list: [
                            {},
                            {},
                            {},
                            {},
                            {},
                            {}
                        ]
                    }
                };
                $.ajax({
                    url: "../../../Handler/Backstage/DevSystemHandler.ashx?action=getadmins&start=" + (p - 1) + "&limit=8",
                    type: "Get",
                    dataType: "json"
                    //context: document.body
                }).success(function (data) {
                    json.result.count = data.data.TotalCount;
                    json.result.list = data.data.Results;

                    $("#j-list").html($("#j-tmpl-listitem").tmpl(json.result));

                    ue.pager({
                        //target : $(".list_pager"),//放置分页的元素
                        pagerTarget: $("#j-pagination ul"),
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
                        now: p,//当前页
                        maxPage: 5,//显示的最多页数
                        per: 6,//每页显示几个
                        count: json.result.count,
                        onchange: function (page) {//切换页数回调函数
                            mpage.getList(page);
                        }
                    });

                    //绑定提款
                    $("#j-list .j-btn-del").bind("click", function () {
                        var $item = $(this).parents("tr");
                        var id = $item.attr("data-gid");

                        Common.confirm({
                            title: "删除确认提示",
                            content: "您确定要删除当前管理员？",
                            confirm: function () {
                                $.ajax({
                                    url: "../../../Handler/Backstage/DevSystemHandler.ashx?action=deladmin&ids=" + id,
                                    type: "Get",
                                    dataType: "json"
                                    //context: document.body
                                }).success(function (data) {
                                    alert("删除成功");
                                });

                                $item.remove();
                            },
                            cancel: function () {
                                
                            }
                        });
                        return false;
                    });
                });


                //});

            }
        }

        $(function () {
            MPage.init();
        });

        </script>

</asp:Content>
