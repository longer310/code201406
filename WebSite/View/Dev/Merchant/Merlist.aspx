﻿<%@ Page Title="" Language="C#" MasterPageFile="~/View/DevMaster.Master" AutoEventWireup="true" CodeBehind="Merlist.aspx.cs" Inherits="Backstage.View.Dev.Merchant.Merlist" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Header" runat="server">
    <link rel="shortcut icon" href="<%=DomainUrl %>/Css/img/favicon.ico">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Content" runat="server">
    
	<div class="widget-box" >
		<div class="widget-title">
			<span class="icon">
				<i class="icon-gift"></i>
			</span>
			<h5>商户列表</h5>
			<div class="buttons">
				<a href="#" class="btn btn-primary btn-mini" id="j-btn-saveAll"><i class="icon-ok icon-white"></i> 保存</a>
				<a href="#" class="btn btn-danger btn-mini" id="j-btn-delSelected"><i class="icon-remove icon-white"></i> 删除</a>
			</div>
		</div>
		<div class="widget-content">
			<ul class="nav nav-tabs" id="j-shop-category-tab">
						
			</ul>
			<table class="table table-bordered table-striped with-check">
				<thead>
					<tr>
						<th><input type="checkbox" id="j-btn-selectAll" name="title-table-checkbox" /></th>
						<th style="width:40px;"><a href="javascript:;" class="j-orderby" data-orderby="0">编号<i class="icon-arrow-down icon-green" style="display:none;"></i></a></th>
						<th>图片</th>
						<th>名称</th>
						<th><a href="javascript:;" class="j-orderby" data-orderby="1">服务期<i class="icon-arrow-up icon-green" style="display:none;"></i></a></th>
						<th>分类</th>
						<th><a href="javascript:;" class="j-orderby" data-orderby="2">用户量<i class="icon-arrow-up icon-green" style="display:none;"></i></a></th>
						<th><a href="javascript:;" class="j-orderby" data-orderby="3">营业额<i class="icon-arrow-up icon-green" style="display:none;"></i></a></th>
						<th>操作</th>
					</tr>
				</thead>
				<tbody id="j-shop-list">
				</tbody>
			</table>
		</div>

		<div class="widget-footer">
			<div class="pagination alternate" id="j-shop-pagination">
                <ul class="page-main"></ul>
			</div>
		</div>
	</div>
    
        <!--页面js-->
    <script type="text/javascript" src="<%=DomainUrl %>/Script/js/ue.pager.js"></script>

    <script type="text/jquery-tmpl-x" id="j-tmpl-shop-listitem">
        {{each(i, v) list}}
	        <tr data-gid="1">
				<td><input type="checkbox" class="j-select" /></td>
				<td style="width:40px;">1</td>
				<td style="width:45px;"><img src="http://placehold.it/45x45"></td>
				<td>宁德市米克中式餐饮</td>
				<td>2015-01-12</td>
				<td>酒吧类</td>
				<td>56</td>
				<td>12123</td>
				<td style="width:200px;">
					<%--<div class="pull-left" style="height:45px;">
						<label class="checkbox"><input type="checkbox" class="j-isrecommend"> 推荐</label>
					</div>--%>

					<div class="pull-right">
						<a class="btn btn-primary btn-mini" href="shop_edit.html?id=111"><i class="icon-pencil icon-white"></i> 查看</a>
						<a class="btn btn-success btn-mini" href="shop_config.html?id=111"><i class="icon-cog icon-white"></i> 登陆管理</a>
					</div>
				</td>
			</tr>
		{{/each}}
    </script>

    <script type="text/javascript">
        var Shop_Category = [
        	{
        		id: 0,
        		name: "全部分类"
        	},
        	{
        		id: 1,
        		name: "餐饮类"
        	},
        	{
        		id: 2,
        		name: "超市类"
        	},
        	{
        		id: 3,
        		name: "酒吧类"
        	},
        	{
        		id: 4,
        		name: "KTV类"
        	}
        ];

    </script>

    <script type="text/javascript">
        var MPage = {
            cid: 0,//当前分类 默认是全部分类
            orderBy: 0,//排序类型 默认按找编号
            orderByType: 0,//升降序 默认是降序
            pageNum: 1,//当前页

            init: function () {
                var mpage = this;

                mpage.showShopCategoryTab();
                mpage.getShopList(mpage.pageNum, mpage.cid, mpage.orderBy, mpage.orderByType);

                mpage.bind();
            },

            bind: function () {
                var mpage = this;

                //绑定全选
                $("#j-btn-selectAll").bind("change", function () {
                    if ($(this).attr("checked")) {
                        $("#j-shop-list .j-select:checkbox").attr("checked", "checked");
                    } else {
                        $("#j-shop-list .j-select:checkbox").removeAttr("checked");
                    }

                    return false;
                });


                //绑定批量保存
                $("#j-btn-saveAll").bind("click", function () {
                    var $checked = $("#j-shop-list .j-select:checked");

                    var data_save = [];

                    $checked.each(function () {
                        var $item = $(this).parents("tr");
                        data_save.push(
        				{
        					id: $item.attr("data-gid"),
        					isrecommend: $item.find(".j-isrecommend").attr("checked") ? 1 : 0
        				});
                    });

                    console.log(data_save);

                    if (data_save.length > 0) {
                        Common.confirm({
                            title: "保存确认提示",
                            content: "您确定要保存当前选择的所有修改吗？",
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

                //绑定排序
                $(".j-orderby").bind("click", function () {
                    var orderBy = +$(this).attr("data-orderby"),
						orderByType;

                    if (mpage.orderBy == orderBy) {
                        orderByType = mpage.orderByType == 0 ? 1 : 0;
                    } else {//切换排序字段，重置排序类型
                        orderByType = 0;
                    }
                    mpage.getShopList(1, mpage.cid, orderBy, orderByType);
                });
            },

            showShopCategoryTab: function () {
                var mpage = this,
        			tmpl = '';

                $.each(Shop_Category, function (i, v) {
                    tmpl += '<li class="' + (v.id == mpage.cid ? 'active' : '') + '" data-id="' + v.id + '"><a href="#">' + v.name + '</a></li>';
                });

                $("#j-shop-category-tab").html(tmpl);

                //绑定tab
                $('#j-shop-category-tab a').bind("click", function (e) {
                    var id = $(this).parent().attr("data-id");
                    $(this).tab('show');
                    mpage.cid = id;
                    mpage.getShopList(1, id, mpage.orderBy, mpage.orderByType);
                    return false
                });
            },

            showOrderBy: function () {
                var mpage = this;

                $(".j-orderby").each(function (i, v) {
                    if (mpage.orderByType == 0) {
                        $(v).find("i").removeClass("icon-arrow-up").addClass("icon-arrow-down");
                    } else {
                        $(v).find("i").removeClass("icon-arrow-down").addClass("icon-arrow-up");
                    }

                    if ($(v).attr("data-orderby") == mpage.orderBy) {
                        $(v).find("i").show();
                    } else {
                        $(v).find("i").hide();
                    }
                });
            },

            //p 页码
            //type tab 类型
            getShopList: function (p, type, orderBy, orderByType) {
                var mpage = this;

                mpage.pageNum = p;
                mpage.cid = type;
                mpage.orderBy = orderBy;
                mpage.orderByType = orderByType;
                mpage.showOrderBy();

                //$.getJSON("", { p: p, type : type, orderBy : orderBy, orderByType : orderByType}， function(json){

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

                $("#j-shop-list").html($("#j-tmpl-shop-listitem").tmpl(json.result));

                ue.pager({
                    //target : $(".list_pager"),//放置分页的元素
                    pagerTarget: $("#j-shop-pagination ul"),
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
                        mpage.getShopList(page, type, orderBy, orderByType);
                    }
                });

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