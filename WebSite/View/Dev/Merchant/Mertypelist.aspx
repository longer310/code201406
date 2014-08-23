﻿<%@ Page Title="" Language="C#" MasterPageFile="~/View/DevMaster.Master" AutoEventWireup="true" CodeBehind="Mertypelist.aspx.cs" Inherits="Backstage.View.Dev.Merchant.Mertypelist" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Header" runat="server">
    <link rel="shortcut icon" href="<%=DomainUrl %>/Css/img/favicon.ico">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Content" runat="server">

    
			<div class="widget-box" >
				<div class="widget-title">
					<span class="icon">
						<i class="icon-gift"></i>
					</span>
					<h5>添加分类</h5>
				</div>
				<div class="widget-content">
					<form action="#" method="post" class="form-horizontal" id="j-addForm" />
						<div class="control-group">
							<label class="control-label">分类名称</label>
							<div class="controls">
								<input type="text" id="j-title" />
							</div>
						</div>
						
						<div class="control-group">
							<label class="control-label">所属模块</label>
							<div class="controls">
								<select id="j-list">
									<option>餐饮超市分类1</option>
									<option>餐饮超市分类2</option>
									<option>餐饮超市分类3</option>
									<option>餐饮超市分类4</option>
									<option>餐饮超市分类5</option>
								</select>
							</div>
						</div>

						<div class="form-actions">
							<button type="reset" class="btn"><i class="icon-refresh"></i> 清除重置</button>
							<button type="submit" class="btn btn-primary"><i class="icon-ok icon-white"></i> 完成保存</button>
						</div>
					</form>
				</div>
			</div>

			<div class="widget-box" >
				<div class="widget-title">
					<span class="icon">
						<i class="icon-gift"></i>
					</span>
					<h5>分类列表</h5>
					<div class="buttons">
						<a href="#" class="btn btn-primary btn-mini" id="j-btn-saveAll"><i class="icon-ok icon-white"></i> 保存分类列表</a>
						<a href="#" class="btn btn-danger btn-mini" id="j-btn-delSelected"><i class="icon-remove icon-white"></i> 删除</a>
					</div>
				</div>
				<div class="widget-content">
					<table class="table table-bordered table-striped with-check">
						<thead>
							<tr>
								<th><input type="checkbox" id="j-btn-selectAll" name="title-table-checkbox" /></th>
								<th>序号</th>
								<th>分类名称</th>
								<th>商户数量</th>
								<th>所属模块</th>
								<th>操作</th>
							</tr>
						</thead>
						<tbody id="j-categroy-list">
						</tbody>
					</table>
				</div>
			</div>

    <!--页面js-->
    <script type="text/javascript" src="<%=DomainUrl %>/Script/js/ue.pager.js"></script>
    
        <script type="text/javascript">
            var Shop_Category = [
        		{
        		    id: 0,
        		    name: "所有模版"
        		},
        		{
        		    id: 1,
        		    name: "餐饮超市类"
        		},
        		{
        		    id: 2,
        		    name: "夜场类"
        		},
        		{
        		    id: 3,
        		    name: "企业类"
        		}
            ];

        </script>

        <script type="text/jquery-tmpl-x" id="j-tmpl-optionitem">
        	{{each(i, v) list}}
        		<option value="${v.id}">${v.name}</option>
        	{{/each}}
        </script>

		<script type="text/jquery-tmpl-x" id="j-tmpl-categroy-listitem">
        	{{each(i, v) list}}
	        	<tr data-cid="${v.id}">
					<td><input type="checkbox" class="j-select" /></td>
					<td style="width:45px;">
						<span class="j-categroy-index">${v.index}</span>
					</td>
					<td><input type="text" value="水煮活鱼水煮活鱼水煮活鱼" class="j-categroy-title"></td>
					<td>56</td>
					<td>夜场类</td>
					<td style="width:140px;">
						<a class="btn btn-primary btn-mini" href="shop_list.html?cid=111"><i class="icon-pencil icon-white"></i> 管理商户</a>
						<a class="btn btn-danger btn-mini j-btn-del" href=""><i class="icon-remove icon-white"></i> 删除</a>
					</td>
				</tr>
			{{/each}}
        </script>

        <script type="text/javascript">
            var MPage = {
                hander: "<%=DomainUrl %>/Handler/Platform/AnnouncementHandler.ashx?action=",
                init: function () {
                    var mpage = this;

                    //去掉之前选中打开的项 选中产品列表
                    $("#sidebar li").removeClass("active open");
                    $("#sidebar .sidebar_merchant").addClass("active open").find(".sidebar_mertype").addClass("active");

                    mpage.showCategroyList();

                    mpage.getCategroyList();

                    //绑定全选
                    $("#j-btn-selectAll").bind("change", function () {
                        if ($(this).attr("checked")) {
                            $("#j-categroy-list .j-select:checkbox").attr("checked", "checked");
                        } else {
                            $("#j-categroy-list .j-select:checkbox").removeAttr("checked");
                        }

                        return false;
                    });

                    //绑定批量删除
                    $("#j-btn-delSelected").bind("click", function () {
                        var $checked = $("#j-categroy-list .j-select:checked");

                        var ids = [];
                        $checked.each(function () {
                            ids.push($(this).parents("tr").attr("data-cid"));
                        });

                        if (ids.length > 0) {
                            Common.confirm({
                                title: "删除确认提示",
                                content: "您确定要删除当前选择的所有数据吗？",
                                confirm: function () {
                                    //执行确认回调
                                    alert('执行确认回调');

                                    //删除成功后刷新本页
                                    mpage.getCategroyList();
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

                    //绑定批量保存
                    $("#j-btn-saveAll").bind("click", function () {
                        var $checked = $("#j-categroy-list .j-select:checked");

                        var data_save = [];

                        $checked.each(function () {
                            var $item = $(this).parents("tr");
                            data_save.push(
        					{
        					    id: $item.attr("data-cid"),
        					    index: parseInt($item.find(".j-categroy-index").html()),
        					    title: $item.find(".j-categroy-title").val(),
        					    thumbnail: $item.find(".j-categroy-thumbnail").attr("src")
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

                    //绑定提交表单
                    $("#j-categroy-addForm").bind("submit", function () {
                        var save_data = {
                            title: $.trim($("#j-title").val()),
                            thumbnail: $('#j-list').val()
                        }

                        console.log(save_data);
                        alert('提交数据');
                        //添加成功后重新获取分类列表
                        mpage.getCategroyList();
                        return false;
                    });

                    //绑定重置表单
                    $("#j-categroy-addForm").bind("reset", function () {
                        return false;
                    });
                },

                getCategroyList: function () {
                    var mpage = this;

                    //$.getJSON("", {}， function(json){
                    $("#j-btn-selectAll").removeAttr("checked");
                    var json = {
                        code: 0,
                        msg: "",
                        result: {
                            count: 59,
                            list: [
                                {
                                    index: 1,
                                    id: 1,
                                },
                                {
                                    index: 2,
                                    id: 2
                                },
                                {
                                    index: 3,
                                    id: 3
                                },
                                {
                                    index: 4,
                                    id: 4
                                },
                                {
                                    index: 5,
                                    id: 5
                                },
                                {
                                    index: 6,
                                    id: 6
                                }
                            ]
                        }
                    };

                    $("#j-categroy-list").html($("#j-tmpl-categroy-listitem").tmpl(json.result));

                    //绑定单个删除
                    $("#j-categroy-list .j-btn-del").bind("click", function () {
                        var $item = $(this).parents("tr");
                        var id = $item.attr("data-cid");

                        Common.confirm({
                            title: "删除确认提示",
                            content: "您确定要删除当前活动？",
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

                    //});

                },

                showCategroyList: function () {
                    var mpage = this;

                    $("#j-list").html($("#j-tmpl-optionitem").tmpl({
                        list: Shop_Category
                    }));
                }
            }

            $(function () {
                MPage.init();
            });

        </script>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Footer" runat="server">
</asp:Content>
