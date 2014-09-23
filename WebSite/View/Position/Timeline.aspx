<%@ Page Title="" Language="C#" MasterPageFile="~/View/merchant.Master" AutoEventWireup="true" CodeBehind="Timeline.aspx.cs" Inherits="Backstage.View.Position.Timeline" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Header" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Content" runat="server">
    <div class="widget-box" >
				<div class="widget-title">
					<span class="icon">
						<i class="icon-gift"></i>
					</span>
					<h5>添加时段</h5>
				</div>
				<div class="widget-content">
					<form action="#" method="post" class="form-horizontal" id="j-time-addForm" >
						<div class="control-group">
							<label class="control-label">时段名称</label>
							<div class="controls">
								<input type="text" id="j-time-title" />
							</div>
						</div>

						<div class="control-group">
							<label class="control-label">时段选择</label>
							<div class="controls">
								<input type="text" class="input-small"> 点至 <input type="text" class="input-small"> 点
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
					<h5>时段列表</h5>
					<div class="buttons">
						<a href="#" class="btn btn-danger btn-mini" id="j-btn-delSelected"><i class="icon-remove icon-white"></i> 删除</a>
					</div>
				</div>
				<div class="widget-content">
					<table class="table table-bordered table-striped with-check">
						<thead>
							<tr>
								<th><input type="checkbox" id="j-btn-selectAll" name="title-table-checkbox" /></th>
								<th>时段名称</th>
								<th>时段</th>
								<th>操作</th>
							</tr>
						</thead>
						<tbody id="j-time-list">
						</tbody>
					</table>
				</div>
			</div>
			
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Footer" runat="server">
    
		<script type="text/jquery-tmpl-x" id="j-tmpl-listitem">
        	{{each(i, v) list}}
	        	<tr data-cid="${v.id}">
					<td><input type="checkbox" class="j-select" /></td>
					<td>123</td>
					<td>12</td>
					<td style="width:140px;">
						<a class="btn btn-danger btn-mini j-btn-del" href=""><i class="icon-remove icon-white"></i> 删除</a>
					</td>
				</tr>
			{{/each}}
        </script>

        <script type="text/javascript">
            var MPage = {
                init: function () {
                    var mpage = this;

                    mpage.getCategroyList();

                    //绑定全选
                    $("#j-btn-selectAll").bind("change", function () {
                        if ($(this).attr("checked")) {
                            $("#j-time-list .j-select:checkbox").attr("checked", "checked");
                        } else {
                            $("#j-time-list .j-select:checkbox").removeAttr("checked");
                        }

                        return false;
                    });

                    //绑定批量删除
                    $("#j-btn-delSelected").bind("click", function () {
                        var $checked = $("#j-time-list .j-select:checked");

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
                                    $.ajax({
                                        url: "../../Handler/Backstage/SourceMaterialHandler.ashx?action=deleteTime&ids=" + ids,
                                        type: "get",
                                        dataType: "json"
                                        //context: document.body
                                    }).success(function (data) {
                                        alert("删除成功！");
                                    });

                                    //删除成功后刷新本页
                                    mpage.getCategroyList();
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


                    //绑定提交表单
                    $("#j-time-addForm").bind("submit", function () {
                        var save_data = {
                            title: $.trim($("#j-time-title").val()),
                            thumbnail: $('#j-img-placehold').attr("src")
                        }

                        console.log(save_data);
                        alert('提交数据');
                        //添加成功后重新获取分类列表
                        mpage.getCategroyList();
                        return false;
                    });

                    //绑定重置表单
                    $("#j-time-addForm").bind("reset", function () {
                        $("#j-time-title").val('');
                        return false;
                    });
                },

                getCategroyList: function () {
                    var mpage = this;

                    //$.getJSON("", { p: p, type : type}， function(json){
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

                    $("#j-time-list").html($("#j-tmpl-listitem").tmpl(json.result));

                    //绑定单个删除
                    $("#j-time-list .j-btn-del").bind("click", function () {
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

                }
            }

            $(function () {
                MPage.init();
            });

        </script>
</asp:Content>
