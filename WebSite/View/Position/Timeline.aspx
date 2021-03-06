﻿<%@ Page Title="" Language="C#" MasterPageFile="~/View/merchant.Master" AutoEventWireup="true" CodeBehind="Timeline.aspx.cs" Inherits="Backstage.View.Position.Timeline" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Header" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Content" runat="server">
    <div class="widget-box">
        <div class="widget-title">
            <span class="icon">
                <i class="icon-gift"></i>
            </span>
            <h5>添加时段</h5>
        </div>
        <div class="widget-content">
            <div class="form-horizontal" id="j-time-addForm">
                <div class="control-group">
                    <label class="control-label">时段名称</label>
                    <div class="controls">
                        <input type="text" id="j-time-title" />
                    </div>
                </div>

                <div class="control-group">
                    <label class="control-label">时段选择(格式：00:00，注意":"冒号要英文)</label>
                    <div class="controls">
                        <input type="text" id="j-time-begin" class="input-small" />
                        点至
                        <input type="text" id="j-time-end"  class="input-small" />
                        点
						
                    </div>
                </div>

                <div class="form-actions">
                    <button type="reset" class="btn"><i class="icon-refresh"></i>清除重置</button>
                    <button id="j-time-click" class="btn btn-primary"><i class="icon-ok icon-white"></i>完成保存</button>
                </div>
            </div>
        </div>
    </div>

    <div class="widget-box">
        <div class="widget-title">
            <span class="icon">
                <i class="icon-gift"></i>
            </span>
            <h5>时段列表</h5>
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
	        	<tr data-cid="${v.Id}">
					<td><input type="checkbox" class="j-select" /></td>
					<td>${v.Title}</td>
					<td>${v.Time}</td>
					<td style="width:140px;">
						<a class="btn btn-danger btn-mini j-btn-del" href=""><i class="icon-remove icon-white"></i> 删除</a>
					</td>
				</tr>
			{{/each}}
        </script>

    <script type="text/javascript">
        Date.prototype.Format = function (fmt) { //author: meizz 
            var o = {
                "M+": this.getMonth() + 1, //月份 
                "d+": this.getDate(), //日 
                "h+": this.getHours(), //小时 
                "m+": this.getMinutes(), //分 
                "s+": this.getSeconds(), //秒 
                "q+": Math.floor((this.getMonth() + 3) / 3), //季度 
                "S": this.getMilliseconds() //毫秒 
            };
            if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
            for (var k in o)
                if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
            return fmt;
        }

        var sellerId = '<%=SellerId%>';
        var positionId = '<%=PositionId%>'
        var MPage = {
            init: function () {
                var mpage = this;

                mpage.getimes();

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
                                    url: "../../Handler/Backstage/PositionHandler.ashx?action=deltimes&ids=" + ids,
                                    type: "get",
                                    dataType: "json"
                                    //context: document.body
                                }).success(function (data) {
                                    alert("删除成功！");
                                    mpage.getimes();
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
                var self = this;

                //绑定提交表单
                $("#j-time-click").bind("click", function () {
                    var save_data = {
                        title: $.trim($("#j-time-title").val()),
                        positionId: positionId,
                        sellerId: sellerId,
                        begin: self.formatTime($.trim($("#j-time-begin").val())).Format("yyyy-MM-dd hh:mm:ss"),
                        end: self.formatTime($.trim($("#j-time-end").val())).Format("yyyy-MM-dd hh:mm:ss")
                    }
                    $.ajax({
                        url: "../../Handler/Backstage/PositionHandler.ashx?action=addtime&sellerId=" + sellerId,
                        dataType: "json",
                        type: "post",
                        data: save_data
                    }).success(function () {
                        alert('添加成功');
                        //添加成功后重新获取分类列表
                        mpage.getimes();
                        return false;
                    });
                });

                //绑定重置表单
                $("#j-time-addForm").bind("reset", function () {
                    $("#j-time-title").val('');
                    return false;
                });
            },
            formatTime: function (string_time) {
                var hour = parseInt(string_time.substr(0, 2));
                var minites = parseInt(string_time.substr(3, 2));

                var time = new Date();
                time.setHours(hour);
                time.setMinutes(minites);
                return time;
            },


            getimes: function () {
                var mpage = this;

                $.ajax({
                    url: "../../Handler/Backstage/PositionHandler.ashx?action=times&positionId=" + positionId,
                    dataType: "json",
                    type: "get"
                }).success(function (data) {
                    $("#j-btn-selectAll").removeAttr("checked");
                    var json = {
                        code: 0,
                        msg: "",
                        result: {
                            count: 59,
                            list: []
                        }
                    };
                    json.result.list = data.data;
                    $("#j-time-list").html($("#j-tmpl-listitem").tmpl(json.result));

                    //绑定单个删除
                    $("#j-time-list .j-btn-del").bind("click", function () {
                        var $item = $(this).parents("tr");
                        var id = $item.attr("data-cid");

                        Common.confirm({
                            title: "删除确认提示",
                            content: "您确定要删除当前分类？",
                            confirm: function () {
                                //执行确认回调
                               
                                $.ajax({
                                    url: "../../Handler/Backstage/PositionHandler.ashx?action=deltimes&ids=" + id,
                                    dataType: "json",
                                    type: "get"
                                }).success(function (data) {
                                    alert("删除成功！");
                                });
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

            }
        }

        $(function () {
            MPage.init();
        });


        </script>
</asp:Content>
