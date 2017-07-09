var registerAPI = contextPath + '/api/register';
var loginAPI = contextPath + '/api/login';

function registerCallback(data, status) {
    $('#registerStatus').removeClass('hidden');
    if (data.result == 'success') {
        $('#registerStatus').html(shortSuccessText('注册成功！'));
        setTimeout(function () {
            window.location.reload();
        }, 1000);
    }
    else {
        $('#btnRegister').removeAttr('disabled');
        if (data.msg)
            $('#registerStatus').html(shortFailText(data.msg));
        else if (status != 'success')
            $('#registerStatus').html(shortFailText(status));
        else
            $('#registerStatus').html(shortFailText('发生未知错误'));
    }
}

function loginCallback(data, status) {
    $('#loginStatus').removeClass('hidden');
    if (data.result == 'success') {
        $('#loginStatus').html(shortSuccessText('登录成功！'));
        setTimeout((function (isAdmin) {
            if (isAdmin) {
                return function () {
                    window.location.href = contextPath + '/admin/books';
                }
            }
            else {
                return function () {
                    window.location.reload();
                }
            } 
        })(data.param), 1000);
    }
    else if (data.msg)
        $('#loginStatus').html(shortFailText(data.msg));
    else if (status != 'success')
        $('#loginStatus').html(shortFailText(status));
    else
        $('#loginStatus').html(shortFailText('发生未知错误'));
}

function doLogin() {
    var postData = {
        'username': $('#loginUsername').val(),
        'password': $('#loginPassword').val()
    };
    $.post(loginAPI, postData, loginCallback).fail(function (xhr, status, error) {
        loginCallback(tryJSONParse(xhr.responseText), error);
    });
}

$('#registerDialog').on('show.bs.modal', function () {
    $('#registerStatus').addClass('hidden');
    $('#btnRegister').removeAttr('disabled');
});

$('#registerDialog').on('shown.bs.modal', function () {
    $('#registerUsername').focus();
});

$('#btnRegister').click(function () {
    $('#btnRegister').attr('disabled', 'disabled');
    var postData = {
        'username': $('#registerUsername').val(),
        'password': $('#registerPassword').val(),
        'passwordConfirm': $('#registerPasswordConfirm').val()
    };
    $.post(registerAPI, postData, registerCallback).fail(function (xhr, status, error) {
        registerCallback(tryJSONParse(xhr.responseText), error);
    });
});

$('#loginDialog').on('show.bs.modal', function () {
    $('#loginUsername').val('');
    $('#loginPassword').val('');
    $('#loginStatus').addClass('hidden');
});

$('#loginDialog').on('shown.bs.modal', function () {
    $('#loginUsername').focus();
});

$('#btnLogin').click(doLogin);
$('#loginPassword').keyup(function (event) {
    if (event.keyCode == 13)
        doLogin();
});