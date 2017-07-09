var loginAPI = contextPath + '/api/login';

function loginCallback(data, status) {
    $('#loginStatus').removeClass('hidden');
    if (data.result == 'success') {
        $('#loginStatus').html(shortSuccessText('登录成功！'));
        setTimeout(function () {
            window.location.reload();
        }, 1000);
    }
    else if (data.msg)
        $('#loginStatus').html(shortFailText(data.msg));
    else if (status != 'success')
        $('#loginStatus').html(shortFailText(status));
    else
        $('#loginStatus').html(shortFailText('发生未知错误'));
}

function doLogin() {
    var username = $('#loginUsername').val();
    var password = $('#loginPassword').val();
    var postData = {
        'username': username,
        'password': password
    };
    $.post(loginAPI, postData, loginCallback).fail(function (xhr, status, error) {
        loginCallback(tryJSONParse(xhr.responseText), error);
    });
}

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