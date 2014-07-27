/**
 * Unicorn Admin Template
 * Diablo9983 -> diablo9983@gmail.com
**/
$(document).ready(function () {

    var login = $('#loginform');
    var recover = $('#recoverform');
    var speed = 400;

    $('#to-recover').click(function () {
        login.fadeTo(speed, 0.01).css('z-index', '100');
        recover.fadeTo(speed, 1).css('z-index', '200');
    });

    $('#to-login').click(function () {
        recover.fadeTo(speed, 0.01).css('z-index', '100');
        login.fadeTo(speed, 1).css('z-index', '200');
    });
    $(document).keydown(function (event) {
        if (event.keyCode == 13) {
            flogin();
        }
    });
    $("#login-submit").click(function () {
        flogin();
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
        }).success(function () {
            window.location.href = "View/Index.aspx";
        });
    }

});