﻿//入口
jQuery(function ($) {
    page.getList();

    //$('#addmanager').click(function () {
    //    //显示在正中央
    //    //request data for centering
    //    var windowWidth = document.body.clientWidth + 276;
    //    var windowHeight = document.body.clientHeight;
    //    var popupHeight = $(".theme-popover").height();
    //    var popupWidth = $(".theme-popover").width();
    //    //centering
    //    $(".theme-popover").css({
    //        "position": "absolute",
    //        "top": windowHeight / 2 - popupHeight / 2,
    //        "left": windowWidth / 2 - popupWidth / 2
    //    });

    //    //$('.theme-popover-mask').fadeIn(100);
    //    $('.theme-popover').slideDown(200);
    //})
    //$('.theme-poptit .close').click(function () {
    //    $('.theme-popover-mask').fadeOut(100);
    //    $('.theme-popover').slideUp(200);
    //})
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
        alert(1);
        $('#addmanager').modal('show');
    },
}