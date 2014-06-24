//入口
jQuery(function ($) {
    page.getList();

    $('#clickmymodal').on('click', function () {
        $.layer({
            type: 1,
            title: "添加管理员", //不显示默认标题栏
            shade: [0], //不显示遮罩
            area: ['600px', '360px'],
            page: {html:'<div class="form-group"><label for="inputEmail1" class="col-lg-3 control-label">Input</label><div class="col-lg-9"><input type="email" class="form-control"id="inputEmail1"placeholder="Type something here"></div></div>'}
        });
    });
});

var page = {
    url: "../../Handler/UCenter/DefaultHandler.ashx?action={0}",
    pageSize: 7,
    pageIndex: 0,
    itemIndex: 1,
    dataType: "json",
    type: "post",
    curCount:0,

    getList: function (pageIndex) {//得到列表
        if (typeof pageIndex == 'undefined') pageIndex = 0;
        page.pageIndex = pageIndex;
        page.itemIndex = page.pageIndex * page.pageSize + 1;

        $.getJSON(page.url.Format("getManagerList"), { pageSize: page.pageSize, pageIndex: page.pageIndex }, function (data) {
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
    },

    alertBox: function () {
        $('#manmanager').modal('show');
    },
}