<%@ Page Title="" Language="C#" MasterPageFile="~/View/merchant.Master" AutoEventWireup="true" CodeBehind="List.aspx.cs" Inherits="Backstage.View.Position.List" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Header" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Content" runat="server">
    <div class="widget-box">
        <div class="widget-title">
            <span class="icon">
                <i class="icon-gift"></i>
            </span>
            <h5>包厢列表</h5>
            <div class="buttons">
                <a href="#" class="btn btn-danger btn-mini" id="j-btn-delSelected"><i class="icon-remove icon-white"></i>删除</a>
            </div>
        </div>
        <div class="widget-content">
            <div class="clearfix" style="position: relative;">
                <select id="j-pkg-status" style="position: absolute; right: 0; top: 0px;">
                    <option value="-1">所有包厢状态</option>
                    <option value="0">空闲</option>
                    <option value="2">占用</option>
                    <option value="1">已定</option>
                </select>
            </div>
            <table class="table table-bordered table-striped with-check">
                <thead>
                    <tr>
                        <th>
                            <input type="checkbox" id="j-btn-selectAll" name="title-table-checkbox" /></th>
                        <th>包厢号</th>
                        <th>分类</th>
                        <th>低消</th>
                        <th>操作</th>
                    </tr>
                </thead>
                <tbody id="j-pkg-list">
                </tbody>
            </table>
        </div>

        <div class="widget-footer">
            <div class="pagination alternate" id="j-pkg-pagination">
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

    <div id="footer">
        <p>关于淘宝合作伙伴营销中心廉正举报联系客服开放平台诚征英才联系我们网站地图法律声明© 2003-2014 Taobao.com 版权所有</p>
        <p>网络文化经营许可证：文网文[2010]040号|增值电信业务经营许可证：浙B2-20080224-1|信息网络传播视听节目许可证：1109364号 </p>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Footer" runat="server">
    <!--页面js-->
    <script src="<%=DomainUrl %>/Script/js/ue.pager.js"></script>
    <script src="<%=DomainUrl %>/Script/js/bootstrap-datepicker.js"></script>

    <div id="j-comment-modal" class="modal hide">
        <form action="#" method="get" class="form-horizontal">
            <div class="modal-header">
                <button data-dismiss="modal" class="close" type="button">×</button>
                <h3>提交预约</h3>
            </div>
            <div class="modal-body">

                <div class="control-group">
                    <label class="control-label">联系信息</label>
                    <div class="controls">
                        <input type="text" id="j-time-title" />
                    </div>
                </div>

                <div class="control-group">
                    <label class="control-label">到店时间</label>
                    <div class="controls">
                        <input type="text" class="j-datepicker" id="j-time-title" />
                    </div>
                </div>

                <div class="control-group">
                    <label class="control-label">选择时段</label>
                    <div class="controls">
                        <select id="select-timeline">
                            <option>时段1</option>
                            <option>时段2</option>
                            <option>时段3</option>
                            <option>时段4</option>
                        </select>
                    </div>
                </div>


                <div class="form-actions">
                    <button type="submit" class="btn btn-primary">提交</button>
                </div>

            </div>
            <div class="modal-footer">
            </div>
        </form>
    </div>

    <script type="text/jquery-tmpl-x" id="j-tmpl-pkg-listitem">
        	{{each(i, v) list}}
	        	<tr data-gid="${v.Id}">
					<td><input type="checkbox" class="j-select" /></td>
					<td style="width:45px;">${v.BoxNumber}</td>
					<td style="width:30px;">${v.BoxTypeTitle}</td>
					<td>${v.Lowest}</td>
					<td style="width:120px;">
						<div class="pull-right">
							<a class="btn btn-primary btn-mini" href="Edit.aspx?id=${v.Id}"><i class="icon-pencil icon-white"></i> 编辑</a>
							<a class="btn btn-danger btn-mini j-btn-del" href=""><i class="icon-remove icon-white"></i> 删除</a>
						</div>
					</td>
				</tr>
			{{/each}}
        </script>

    <script type="text/javascript">
        var sellerId = '<%=SellerId%>';
        var MPage = {
            init: function () {
                var mpage = this;

                mpage.getPkgList(1, 0);

                //绑定tab
                $('#j-pkg-tab a').click(function (e) {
                    var type = $(this).parent().index();
                    var status = parseInt($("#j-pkg-status").val());

                    $(this).tab('show');
                    mpage.getPkgList(1, type, status);
                    return false
                });

                //绑定全选
                $("#j-btn-selectAll").bind("change", function () {
                    if ($(this).attr("checked")) {
                        $("#j-pkg-list .j-select:checkbox").attr("checked", "checked");
                    } else {
                        $("#j-pkg-list .j-select:checkbox").removeAttr("checked");
                    }

                    return false;
                });

                //绑定批量删除
                $("#j-btn-delSelected").bind("click", function () {
                    var $checked = $("#j-pkg-list .j-select:checked");

                    var ids = [];
                    $checked.each(function () {
                        ids.push($(this).parents("tr").attr("data-gid"));
                    });

                    if (ids.length > 0) {
                        Common.confirm({
                            title: "删除确认提示",
                            content: "您确定要删除当前选择的所有数据吗？",
                            confirm: function () {
                                $.ajax({
                                    url: "../../Handler/Backstage/PositionHandler.ashx?action=del&ids=" + ids,
                                    dataType: "json",
                                    type: "Get"
                                }).success(function (data) {
                                    alert("删除成功")
                                });

                                //删除成功后刷新本页
                                mpage.getPkgList(mpage.curPage, mpage.curType, mpage.curStatus);
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
                                //alert('执行确认回调');
                            }
                        });
                    }

                    return false;
                });

                $('.j-datepicker').datepicker();

                $("#j-pkg-status").bind("change", function () {
                    var status = parseInt($(this).val());
                    var type = $("#j-pkg-tab li.active").index();
                    mpage.getPkgList(1, type, status);
                });
            },

            //p 页码
            //type tab 类型
            getPkgList: function (p, type, status) {
                var mpage = this;

                $.ajax({
                    url: "../../Handler/Backstage/PositionHandler.ashx?action=getlist&sellerId=" + sellerId + "&start=" + (p - 1) + "&limit=8",
                    data: {
                        type: type,
                        status: status
                    },
                    type: "Get",
                    dataType: "json"
                    //context: document.body
                }).success(function (data) {
                    //$.getJSON("", { p: p, type : type, status : status}， function(json){

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
                    json.result.list = data.data.Results;
                    json.result.count = data.data.TotalCount;

                    $("#j-pkg-list").html($("#j-tmpl-pkg-listitem").tmpl(json.result));

                    ue.pager({
                        //target : $(".list_pager"),//放置分页的元素
                        pagerTarget: $("#j-pkg-pagination ul"),
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
                        per: 8,//每页显示几个
                        count: json.result.count,
                        onchange: function (page) {//切换页数回调函数
                            mpage.getPkgList(page, type, status);
                        }
                    });

                    //绑定单个删除
                    $("#j-pkg-list .j-btn-del").bind("click", function () {
                        var $item = $(this).parents("tr");
                        var id = $item.attr("data-gid");

                        Common.confirm({
                            title: "删除确认提示",
                            content: "您确定要删除当前活动？",
                            confirm: function () {
                                //执行确认回调
                                $.ajax({
                                    url: "../../Handler/Backstage/PositionHandler.ashx?action=del&ids=" + id,
                                    dataType: "json",
                                    type: "Get"
                                }).success(function (data) {
                                    alert("删除成功");
                                    setTimeout(function () {
                                        window.location.reload();
                                    }, 500);
                                });
                                
                            },
                            cancel: function () {
                                //执行取消回调
                                //alert('执行取消回调');
                            }
                        });
                        return false;
                    });

                    ////绑定状态修改
                    //$("#j-pkg-list .j-btn-change_status").bind("click", function () {
                    //    var $item = $(this).parents("tr");
                    //    var id = $item.attr("data-gid");
                    //    var status = $(this).attr("data-status");

                    //    return false;
                    //});
                });



                //});

            },

            showProfileForm: function () {


                $('#j-comment-modal').modal('show');
                $("#j-comment-modal").height("auto");
                var height = $("#j-comment-modal").height();
                $("#j-comment-modal").css({
                    height: height,
                    "margin-top": -height / 2
                });

                //绑定回复
                //$("#j-comment-modal form").unbind("submit").bind("submit", function () {
                    

                //    $.ajax({
                //        url: "../../Handler/Backstage/PositionHandler.ashx?action=gettimes",
                //        type: "Get",
                //        data: {
                //           pid:
                //        },
                //        dataType: ""

                //    });
                //    return false;
                //});
            }
        }

        $(function () {
            MPage.init();
        });

        </script>
</asp:Content>
