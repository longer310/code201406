/**
 * Unicorn Admin Template
 * Diablo9983 -> diablo9983@gmail.com
**/
$(document).ready(function () {

    var login = $('#loginform');
    var recover = $('#recoverform');
    var reset = $('#resetform');
    var speed = 400;
    $(document).keydown(function (event) {
        if (event.keyCode == 13) {
            flogin();
        }
    });

    $("#login-submit").click(function () {
        flogin();
    });
    $("#getcode-submit").click(function () {
        getCode();
    });
    $("#updatepwd-submit").click(function () {
        updatePwd();
    });
    $('#to-recover').click(function () {
        login.fadeTo(speed, 0.01).css('z-index', '100');
        recover.fadeTo(speed, 1).css('z-index', '200');
        return false;
    });

    $('#to-login').click(function () {
        recover.fadeTo(speed, 0.01).css('z-index', '100');
        login.fadeTo(speed, 1).css('z-index', '200');
        return false;
    });

    $("#to-reset").bind("click", function () {
        recover.fadeTo(speed, 0.01).css('z-index', '100');
        reset.fadeTo(speed, 1).css('z-index', '200');
        return false;
    });

    $("#back-recover").bind("click", function () {
        reset.fadeTo(speed, 0.01).css('z-index', '100');
        recover.fadeTo(speed, 1).css('z-index', '200');
        return false;
    });


    if ($.browser.msie == true && $.browser.version.slice(0, 3) < 10) {
        $('input[placeholder]').each(function () {

            var input = $(this);

            $(input).val(input.attr('placeholder'));

            $(input).focus(function () {
                if (input.val() == input.attr('placeholder')) {
                    input.val('');
                }
            });

            $(input).blur(function () {
                if (input.val() == '' || input.val() == input.attr('placeholder')) {
                    input.val(input.attr('placeholder'));
                }
            });
        });
    }
});

function flogin() {
    var username = $("#txt-username").val();
    var pwd = $("#txt-pwd").val();
    if (username == "" || pwd == "") {
        $(".tip-error").show();
        return;
    }

    $.ajax({
        url: "Handler/LoginHandler.ashx?action=login&userName=" + username + "&pwd=" + pwd,
        type: "get",
        dataType: "json"
        //context: document.body
    }).success(function (data) {
        if (data.success == "1") //商户
            window.location.href = "View/Index.aspx";
        else if (data.success == "2")  //平台
            window.location.href = "View/Dev/Index.aspx";

        $(".tip-error").html(data.error).show();
    }).error(function (data) {
        $(".tip-error").show();
    });
}

function getCode() {
    var username = $("#txt-getusername").val();
    if (username == "") {
        $(".tip-error").html("请输入用户名").show();
        return;
    }

    $.ajax({
        url: "Handler/LoginHandler.ashx?action=getcode&phone=" + phone,
        type: "get",
        dataType: "json"
        //context: document.body
    }).success(function (data) {
        
    });
    //console.log(1);
}

function updatePwd() {
    var mail = $("#txt-mail").val();
    if (username == "" || pwd == "") {
        $(".tip-error").show();
        return;
    }

    $.ajax({
        url: "Handler/LoginHandler.ashx?action=getpwd&mail=" + mail,
        type: "get",
        dataType: "json"
        //context: document.body
    }).success(function () {
        window.location.reload();
    });
    //console.log(1);
}