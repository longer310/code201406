<%@ Page Title="" Language="C#" MasterPageFile="~/View/merchant.Master" AutoEventWireup="true" CodeBehind="List.aspx.cs" Inherits="Backstage.View.Coupon.List" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Header" runat="server">

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Content" runat="server">
    
			<div class="widget-box" >
				<div class="widget-title">
					<span class="icon">
						<i class="icon-tags"></i>
					</span>
					<h5>电子券列表</h5>
					<div class="buttons">
						<a href="#" class="btn btn-info btn-mini" id="j-btn-pauseAll"><i class="icon-pause icon-white"></i> 批量下架</a>
						<a href="#" class="btn btn-danger btn-mini" id="j-btn-delSelected"><i class="icon-remove icon-white"></i> 删除</a>
					</div>
				</div>
				<div class="widget-content">
					<ul class="nav nav-tabs" id="j-ticket-tab">
						<li class="active">
							<a href="#">所有电子券</a>
						</li>
						<li><a href="#">使用中电子券</a></li>
						<li><a href="#">已下架电子券</a></li>
					</ul>
					<table class="table table-bordered table-striped with-check">
						<thead>
							<tr>
								<th><input type="checkbox" id="j-btn-selectAll" name="title-table-checkbox" /></th>
								<th>图片</th>
								<th>内容</th>
								<th>所需积分</th>
								<th>下载次数</th>
								<th>使用次数</th>
								<th>操作</th>
							</tr>
						</thead>
						<tbody id="j-ticket-list">
						</tbody>
					</table>
				</div>

				<div class="widget-footer">
					<div class="pagination alternate" id="j-ticket-pagination">
						<ul class="page-main">
							<li class="disabled"><a href="#">首页</a></li>
							<li class="disabled"><a href="#">上一页</a></li>
							<li class="active">
								<a href="#">1</a>
							</li>
							<li><a href="#">2</a></li>
							<li><a href="#">3</a></li>
							<li><a href="#">4</a></li>
							<li><a href="#">下一页</a></li>
							<li><a href="#">末页</a></li>
							<li class="page-info"><b class="text-info">1</b>/8页 共<b class="text-info">18</b>条记录</li>
						</ul>
					</div>
				</div>
			</div>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Footer" runat="server">
     <!--页面js-->
        <script src="../../script/js/ue.pager.js"></script>

        <script type="text/jquery-tmpl-x" id="j-tmpl-ticket-listitem">
        	{{each(i, v) list}}
	        	<tr data-gid="${v.id}">
					<td><input type="checkbox" class="j-select" /></td>
					<td style="width:180px;"><img src="${v.imgurl}"></td>
					<td>
						<dl class="dl-horizontal">
							<dt>电子券名称：</dt>
							<dd>${v.tilte}</dd>
							<dt>使用细则说明：</dt>
							<dd class="text-success">购物满${v.fullmoney}元立减${v.discountmoney}元</dd>
							<dt>有效期至：</dt>
							<dd class="text-error">${v.expiry}</dd>
						</dl>	
					</td>
					<td><b class="text-error">${v.extcredit}</b>分</td>
					<td><b class="text-error">${v.downloadtimes}</b>次</td>
					<td><b class="text-error">${v.usertimes}</b>次</td>
					<td style="width:200px;">
						<a class="btn btn-primary btn-mini" href="ticket_edit.html?id=111"><i class="icon-pencil icon-white"></i> 编辑</a>
						<a class="btn btn-info btn-mini j-btn-pause" href=""><i class="icon-pause icon-white"></i> 下架</a>
						<a class="btn btn-danger btn-mini j-btn-del" href=""><i class="icon-remove icon-white"></i> 删除</a>
					</td>
				</tr>
			{{/each}}
        </script>
        <script type="text/javascript">
            var sellerId = '<%=SellerId%>';
            var MPage = {
                init: function () {
                    var mpage = this;

                    mpage.getTicketList(1, 0);

                    //绑定tab
                    $('#j-ticket-tab a').click(function (e) {
                        var type = $(this).parent().index();
                        $(this).tab('show');
                        mpage.getTicketList(1, type);
                        return false
                    });

                    //绑定全选
                    $("#j-btn-selectAll").bind("change", function () {
                        if ($(this).attr("checked")) {
                            $("#j-ticket-list .j-select:checkbox").attr("checked", "checked");
                        } else {
                            $("#j-ticket-list .j-select:checkbox").removeAttr("checked");
                        }

                        return false;
                    });

                    //绑定批量删除
                    $("#j-btn-delSelected").bind("click", function () {
                        var $checked = $("#j-ticket-list .j-select:checked");

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
                                    alert('执行确认回调');

                                    //删除成功后刷新本页
                                    mpage.getTicketList(mpage.currentPage, mpage.currentType);
                                },
                                cancel: function () {
                                    //执行取消回调
                                    alert('执行取消回调');
                                }
                            });
                        } else {
                            Common.alert({
                                title: "提示",
                                content: "请至少选择一项",
                                confirm: function () {
                                    //执行确认回调
                                    alert('执行确认回调');
                                }
                            });
                        }

                        return false;
                    });

                    //绑定批量下架
                    $("#j-btn-pauseAll").bind("click", function () {
                        var $checked = $("#j-ticket-list .j-select:checked");

                        var data_save = [];

                        $checked.each(function () {
                            var $item = $(this).parents("tr");
                            data_save.push(
        					{
        					    id: $item.attr("data-gid")
        					});
                        });

                        console.log(data_save);

                        if (data_save.length > 0) {
                            Common.confirm({
                                title: "下架确认提示",
                                content: "您确定要下架当前所选择的电子券？",
                                confirm: function () {
                                    //执行确认回调
                                    alert('执行确认回调');

                                },
                                cancel: function () {
                                    //执行取消回调
                                    alert('执行取消回调');
                                }
                            });
                        } else {
                            Common.alert({
                                title: "提示",
                                content: "请至少选择一项",
                                confirm: function () {
                                    //执行确认回调
                                    alert('执行确认回调');
                                }
                            });
                        }

                        return false;
                    });
                },

                //p 页码
                //type tab 类型
                getTicketList: function (p, type) {
                    var mpage = this;

                    //$.getJSON("", { p: p, type : type}， function(json){
                    mpage.currentPage = p;
                    mpage.currentType = type;
                    $("#j-btn-selectAll").removeAttr("checked");
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
                        url: "../../Handler/Backstage/CouponHandler.ashx?action=getlist&sellerId=" + sellerId + "&start=" + (p - 1) + "&limit=6",
                        type: "Get",
                        dataType: "json"
                        //context: document.body
                    }).success(function (data) {
                        json.result.count = data.data.totalcount;
                        json.result.list = data.data.results;

                        $("#j-ticket-list").html($("#j-tmpl-ticket-listitem").tmpl(json.result));

                        ue.pager({
                            //target : $(".list_pager"),//放置分页的元素
                            pagerTarget: $("#j-ticket-pagination ul"),
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
                                mpage.getTicketList(page, type);
                            }
                        });

                        //绑定单个删除
                        $("#j-ticket-list .j-btn-del").bind("click", function () {
                            var $item = $(this).parents("tr");
                            var id = $item.attr("data-gid");

                            Common.confirm({
                                title: "删除确认提示",
                                content: "您确定要删除当前电子券？",
                                confirm: function () {
                                    //执行确认回调
                                    alert('执行确认回调');

                                    $item.remove();
                                },
                                cancel: function () {
                                    //执行取消回调
                                    alert('执行取消回调');
                                }
                            });
                            return false;
                        });

                        //绑定单个下架
                        $("#j-ticket-list .j-btn-pause").bind("click", function () {
                            var $item = $(this).parents("tr");
                            var id = $item.attr("data-gid");

                            Common.confirm({
                                title: "删除确认提示",
                                content: "您确定要下架当前电子券？",
                                confirm: function () {
                                    //执行确认回调
                                    alert('执行确认回调');

                                    $item.remove();
                                },
                                cancel: function () {
                                    //执行取消回调
                                    alert('执行取消回调');
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
