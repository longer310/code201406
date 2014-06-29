//入口
var pop = null;
jQuery(function ($) {
    page.init();
});



var page = {
    url: "/Handler/SourceMaterial/DefaultHandler.ashx?action={0}",
    pageSize: 7,
    pageIndex: 0,
    itemIndex: 1,
    dataType: "json",
    type: "post",
    curCount: 0,
    cuurentId: 0,
    pop: null,
    current: {
        Name: "",
        Address: "",
        Remark: ""
    },
    init: function () {
        this.getList();
        var self = this;
        $("#clickmymodal").bind("click", function () {
            if (self.pop == null)
                $("#source_wrap").dialog({ title: "新增素材" });
        });
    },
    getList: function (pageIndex) {//得到列表
        if (typeof pageIndex == 'undefined') pageIndex = 0;
        page.pageIndex = pageIndex;
        page.itemIndex = page.pageIndex * page.pageSize + 1;

        $.getJSON(page.url.Format("getList"), { pageSize: page.pageSize, pageIndex: page.pageIndex }, function (data) {
            page.showData(data);
            page.curCount = data.curcount;
            if (page.pageIndex == 0) {
                page.showPaper(data.count);
            }
        });
    },

    add: function () {


        $.getJSON(page.url.Format("create"), { pageSize: page.pageSize, pageIndex: page.pageIndex }, function (data) {
            page.showData(data);
            page.curCount = data.curcount;
            if (page.pageIndex == 0) {
                page.showPaper(data.count);
            }
        });
    },
    del: function () {
        if (cuurentId == 0)
            alert("请选择要删除的素材");
        $.getJSON(page.url.Format("delete"), { pageSize: page.pageSize, pageIndex: page.pageIndex }, function (data) {
            page.showData(data);
            page.curCount = data.curcount;
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