<%@ Page Title="" Language="C#" MasterPageFile="~/View/merchant.Master" AutoEventWireup="true" CodeBehind="Pcategory.aspx.cs" Inherits="Backstage.View.Position.Pcategory" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Header" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Content" runat="server">

    <div class="widget-box">
        <div class="widget-title">
            <span class="icon">
                <i class="icon-gift"></i>
            </span>
            <h5>添加分类</h5>
        </div>
        <div class="widget-content">
            <form action="#" method="post" class="form-horizontal" id="j-categroy-addForm" />
            <div class="control-group">
                <label class="control-label">分类名称</label>
                <div class="controls">
                    <input type="text" id="j-type-title" />
                </div>
            </div>

            <div class="control-group">
                <label class="control-label">可容纳人数</label>
                <div class="controls">
                    <input type="text" id="j-type-num" />
                </div>
            </div>

            <div class="control-group">
                <label class="control-label">最低消费</label>
                <div class="controls">
                    <input type="text" id="j-type-low" />
                </div>
            </div>

            <div class="form-actions">
                <button type="reset" class="btn"><i class="icon-refresh"></i>清除重置</button>
                <button type="submit" class="btn btn-primary"><i class="icon-ok icon-white"></i>完成保存</button>
            </div>
            </form>
			
        </div>
    </div>

    <div class="widget-box">
        <div class="widget-title">
            <span class="icon">
                <i class="icon-gift"></i>
            </span>
            <h5>分类列表</h5>
            <div class="buttons">
                <a href="#" class="btn btn-primary btn-mini" id="j-btn-saveAll"><i class="icon-ok icon-white"></i>保存分类列表</a>
                <a href="#" class="btn btn-danger btn-mini" id="j-btn-delSelected"><i class="icon-remove icon-white"></i>删除</a>
            </div>
        </div>
        <div class="widget-content">
            <table class="table table-bordered table-striped with-check">
                <thead>
                    <tr>
                        <th>
                            <input type="checkbox" id="j-btn-selectAll" name="title-table-checkbox" /></th>
                        <th>序号</th>
                        <th>分类名称</th>
                        <th>容纳人数</th>
                        <th>最低消费</th>
                        <th>操作</th>
                    </tr>
                </thead>
                <tbody id="j-categroy-list">
                </tbody>
            </table>
        </div>
    </div>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Footer" runat="server">
    <!--页面js-->
    <script src="<%=DomainUrl %>/Script/js/ue.pager.js"></script>

    <script charset="utf-8" src="<%=DomainUrl %>/Script/kindeditor/kindeditor-min.js"></script>
    <script charset="utf-8" src="<%=DomainUrl %>/Script/kindeditor/lang/zh_CN.js"></script>

    <script type="text/jquery-tmpl-x" id="j-tmpl-listitem">
        	{{each(i, v) list}}
	        	<tr data-cid="${v.id}">
					<td><input type="checkbox" class="j-select" /></td>
					<td><input type="text" value="${v.Title}" class="j-categroy-title"></td>
					<td>${v.HoldNum}</td>
					<td>${v.Lowest}</td>
					<td style="width:140px;">
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

                $("#sidebar li").removeClass("active open");
                $("#sidebar .sadebaer_pms").addClass("active open").find(".sidebar_pms_pc").addClass("active");

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
                                $.ajax({
                                    url: "../../Handler/Backstage/PositionHandler.ashx?action=deletecategory&ids=" + ids,
                                    dataType: "json",
                                    type: "get"
                                }).success(function (data) {
                                    window.location.reload();
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

                //绑定批量保存
                $("#j-btn-saveAll").bind("click", function () {
                    var $checked = $("#j-categroy-list .j-select:checked");

                    var data_save = [];

                    $checked.each(function () {
                        var $item = $(this).parents("tr");
                        data_save.push(
                        {
                            Id: $item.attr("data-cid"),
                            Title: $item.find(".j-categroy-title").val()
                        });
                    });


                    if (data_save.length > 0) {
                        Common.confirm({
                            title: "保存确认提示",
                            content: "您确定要保存当前选择的所有修改吗？",
                            confirm: function () {
                                //执行确认回调
                                $.ajax({
                                    url: "../../Handler/Backstage/PositionHandler.ashx?action=savetypes&sellerId=" + sellerId,
                                    dataType: "json",
                                    data: data_save,
                                    type: "post"
                                }).success(function (data) {
                                    alert("保存成功！");
                                });
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
                            }
                        });
                    }

                    return false;
                });

                //绑定提交表单
                $("#j-categroy-addForm").bind("submit", function () {
                    var save_data = {
                        title: $.trim($("#j-type-title").val()),
                        holdnum: $.trim($("#j-type-num").val()),
                        lowest: $.trim($("#j-type-low").val())
                    }
                    $.ajax({
                        url: "../../Handler/Backstage/PositionHandler.ashx?action=addCateory&sellerId=" + sellerId,
                        dataType: "json",
                        data: save_data,
                        type: "post"
                    }).success(function (data) {
                        alert("保存成功！");
                        window.location.reload();
                    });
                    return false;
                });

                //绑定重置表单
                $("#j-categroy-addForm").bind("reset", function () {
                    $("#j-categroy-title").val('');
                    return false;
                });
            },

            getCategroyList: function () {
                var mpage = this;

                $.ajax({
                    url: "../../Handler/Backstage/PositionHandler.ashx?action=categorys&sellerId=" + sellerId,
                    dataType: "json",
                    type: "get",
                }).success(function () {
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

                    json.result.list = data.data;

                    $("#j-categroy-list").html($("#j-tmpl-listitem").tmpl(json.result));

                    //绑定单个删除
                    $("#j-categroy-list .j-btn-del").bind("click", function () {
                        var $item = $(this).parents("tr");
                        var id = $item.attr("data-cid");

                        Common.confirm({
                            title: "删除确认提示",
                            content: "您确定要删除当前活动？",
                            confirm: function () {
                                //执行确认回调
                                $.ajax({
                                    url: "../../Handler/Backstage/PositionHandler.ashx?action=deletecategory&ids=" + id,
                                    dataType: "",
                                    type: "get"
                                }).success(function () {
                                    alert("删除成功！");
                                    $item.remove();
                                })
                            },
                            cancel: function () {
                                //执行取消回调
                            }
                        });
                        return false;
                    });

                    ////绑定上下移动
                    //$("#j-categroy-list .j-categroy-up,#j-categroy-list .j-categroy-down").bind("click", function () {
                    //    var $btn = $(this),
                    //        $item = $(this).parents("tr");

                    //    if ($btn.hasClass("disabled")) {
                    //        return false;
                    //    }

                    //    var change_index,
                    //        $change_item;

                    //    if ($btn.hasClass("j-categroy-up")) {
                    //        $change_item = $item.prev();
                    //        $item.insertBefore($change_item);
                    //    } else {
                    //        $change_item = $item.next();
                    //        $item.insertAfter($change_item);
                    //    }

                    //    change_index = $change_item.find(".j-categroy-index").html();
                    //    $change_item.find(".j-categroy-index").html($item.find(".j-categroy-index").html());
                    //    $item.find(".j-categroy-index").html(change_index);

                    //    $("#j-categroy-list .j-categroy-up").removeClass("disabled").first().addClass("disabled");
                    //    $("#j-categroy-list .j-categroy-down").removeClass("disabled").last().addClass("disabled");
                    //    return false;
                    //});
                    ////});
                });



            }
        }

        $(function () {
            MPage.init();
        });

        </script>
</asp:Content>
