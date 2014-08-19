/**
 * Unicorn Admin Template
 * Diablo9983 -> diablo9983@gmail.com
**/
$(document).ready(function () {

    var login = $('#loginform');
    var recover = $('#recoverform');
    var speed = 400;
    $(document).keydown(function (event) {
        if (event.keyCode == 13) {
            flogin();
        }
    });

    $('#to-recover').click(function () {
        //login.fadeTo(speed, 0.01).css('z-index', '100');
        //recover.fadeTo(speed, 1).css('z-index', '200');
        login.hide();
        recover.show();
        //if (_window.event.keyCode == 13) _window.event.keyCode = 0
        //$(document).keydown(function (event) {
        //    if (event.keyCode == 13) {
        //        getPwd();
        //    }
        //});
    });

    $('#to-login').click(function () {
        //recover.fadeTo(speed, 0.01).css('z-index', '100');
        //login.fadeTo(speed, 1).css('z-index', '200');
        //if (_window.event.keyCode == 13) _window.event.keyCode = 0
        //$(document).keydown(function (event) {
        //    if (event.keyCode == 13) {
        //        flogin();
        //    }
        //});
        recover.hide();
        login.show();
    });

    $("#login-submit").click(function () {
        flogin();
    });
    $("#get-user-submit").click(function () {
        getPwd();
    })

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

    //function reset() {
    //    $(document).keydown(function (event) {
    //        if (event.keyCode == 13) {
    //            return;
    //        }
    //    });
    //}

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
        });
    }

    function getPwd() {
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

});