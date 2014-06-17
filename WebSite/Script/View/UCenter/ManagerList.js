//入口
jQuery(function ($) {
    page.getList();
});

var page = {
    url: "/Handler/UCenter/DefaultHandler.ashx?action={0}",
    pageSize: 10,
    pageIndex: 0,
    itemIndex: 0,
    dataType: "json",
    type: "post",

    getList: function (pageIndex) {//得到列表
        if (typeof pageIndex != 'undefined') {
            page.pageIndex = pageIndex;
        }
        var id = $.trim($("#Id").val());
        page.itemIndex = 0;
        $.getJSON(page.url.Format("getManagerList"), { pageSize: page.pageSize, pageIndex: page.pageIndex +1, r: Math.random() }, function (data) {
            page.showData(data);
            if (page.pageIndex == 0) {
                page.showPaper(data.count);
            }
        });
    },

    showData: function (json) {//显示列表
        $("#managerList").html(TrimPath.processDOMTemplate("template_jst_list", json));
    },

    showPaper: function (totalCount) {//分页显示
        if (totalCount >= page.pageSize)
            $('#pager').pagination(totalCount, {
                items_per_page: page.pageSize,
                current_page: page.pageIndex,
                prev_text: "上一页",
                next_text: "下一页",
                callback: page.getList
            });
        else $('#pager').html('');
    }
}