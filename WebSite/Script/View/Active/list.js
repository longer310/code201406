var MPage = {
    init: function () {
        var mpage = this;
       
        mpage.getActivityList(1);

        //绑定全选
        $("#j-btn-selectAll").bind("click", function () {
            if (!$(this).data("checked")) {
                $("#j-activity-list :checkbox").attr("checked", "checked");
                $(this).data("checked", true).html('<i class="icon-check icon-white"></i> 取消全选');
            } else {
                $("#j-activity-list :checkbox").removeAttr("checked");
                $(this).data("checked", false).html('<i class="icon-check icon-white"></i> 全选');
            }

            return false;
        });

        //绑定批量删除
        $("#j-btn-delSelected").bind("click", function () {
            var $checked = $("#j-activity-list :checked");

            var ids = [];
            $checked.each(function () {
                ids.push($(this).parents("li").attr("data-id"));
            });

            if (ids.length > 0) {
                Common.confirm({
                    title: "删除确认提示",
                    content: "您确定要删除当前选择的所有数据吗？",
                    confirm: function () {
                        //执行确认回调
                        alert('执行确认回调');

                        //删除成功后刷新本页
                        mpage.getActivityList(mpage.activityCurrentPage);
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

    getActivityList: function (p) {
        var mpage = this;
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
            url: "../../Handler/Backstage/ActiveHandler.ashx?action=getlist&sellerid=" + sellerid + "&start=" + p + "&limit=" + 6,
            type: "get",
            dataType: "json"
            //context: document.body
        }).success(function (data) {
            json.result.count = data.data.totalcount;
            json.result.list = data.data.results;
            mpage.activityCurrentPage = p;
            $("#j-btn-selectAll").data("checked", false).html('<i class="icon-check icon-white"></i> 全选');
            //console.log(json);
            $("#j-activity-list").html($("#j-tmpl-activity-listitem").tmpl(json.result));
            ue.pager({
                //target : $(".list_pager"),//放置分页的元素
                pagerTarget: $("#j-activity-pagination ul"),
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
                per: 10,//每页显示几个
                count: data.data.totalcount,
                onchange: function (page) {//切换页数回调函数
                    mpage.getActivityList(page);
                }
            });

            //绑定单个删除
            $("#j-activity-list .j-btn-del").bind("click", function () {
                var $item = $(this).parents("li");
                var id = $item.attr("data-id");

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
            //window.location.href = "View/Index.aspx";
        });
        //$.getJSON("", { p: p}， function(json){
        
        //});
    }
}

$(function () {
    MPage.init();
});