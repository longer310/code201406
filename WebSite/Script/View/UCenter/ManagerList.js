﻿//入口
jQuery(function ($) {
    page.getList();

    $('#clickmymodal').on('click', function () {
        $("#roletype").val("二级管理员");
        $("#username").val("");
        $("#pwd").val("");
        page.modifyid = 0;
        $.layer({
            type: 1,
            title: "添加管理员", //显示标题栏
            shade: [0], //不显示遮罩
            offset: ['50px', ''],
            area: ['500px', '360px'],
            page: { html: $("#alertbody").html() }
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
    curCount: 0,
    modifyid: 0,
    modifytype:0,

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

    //关闭弹窗
    closealert: function () {
        layer.closeAll();
    },

    //删除数据 弹框
    deldataalert: function (id,e) {
        page.modifyid = id;

        var $tr = $(e.target).parents("tr");
        var username = $tr.children(".username").html();
        var msg = "你确定要删除管理员[" + username + "]?";
        $.layer({
            shade: [0],
            offset: ['100px', ''],
            area: ['auto', 'auto'],
            dialog: {
                msg: msg,
                btns: 2,
                type: 4,
                btn: ['确定', '取消'],
                yes: function () {
                    page.deldata();
                }, no: function () {
                    layer.closeAll();
                }
            }
        });
    },

    deldata:function() {
        $.getJSON(page.url.Format("deldata"), { id: page.modifyid}, function (data) {
            if (!data.error) {
                layer.msg('删除成功', 2, -1);
                page.getList(page.pageIndex);
            } else {
                layer.msg('删除失败', 2, -1);
            }
        });
    },

    //更新数据 弹框
    updatedataalert: function (id, e) {
        page.modifyid = id;
        var $tr = $(e.target).parents("tr");
        var username = $tr.children(".username").html();
        var pwd = $tr.children(".pwd").html();
        var roletype = parseInt($tr.children(".roletype").html()) + 1;
        var html = $("#alertbody").html();
        $.layer({
            type: 1,
            title: "更新管理员", //显示标题栏
            shade: [0], //不显示遮罩
            offset: ['50px', ''],
            area: ['500px', '360px'],
            page: { html: html }
        });
        $(".xubox_main #username").val(username);
        $(".xubox_main #pwd").val(pwd);
        $(".xubox_main #roletype").val(roletype);
    },

    updatedata: function () {
        var username = $(".xubox_main #username").val();
        var pwd = $(".xubox_main #pwd").val();
        var roletype = $(".xubox_main #roletype ").val();
        $.getJSON(page.url.Format("updatedata"), { id: page.modifyid, username: username, pwd: pwd, roletype: roletype }, function (data) {
            layer.closeAll();
            if (!data.error && data.num > 0) {
                if(page.modifyid == 0)
                    layer.msg('添加成功', 2, -1);
                else
                    layer.msg('更新成功', 2, -1);
                page.getList(page.pageIndex);
            } else {
                if (page.modifyid == 0)
                    layer.msg('添加失败', 2, -1);
                else
                    layer.msg('更新失败', 2, -1);
            }
        });
    },

}