var $table = $('tbody');
var $addressForm = $('#addressForm');
var roles = ['普通用户', '管理员'];

var allUsersAPI = contextPath + '/admin/api/users/all';
var userDetailAPI = contextPath + '/admin/api/users/detail';
var addUserAPI = contextPath + '/admin/api/users/add';
var updateUserAPI = contextPath + '/admin/api/users/update';
var deleteUserAPI = contextPath + '/admin/api/users/delete';
var getAddressAPI = contextPath + '/admin/api/users/address/all';
var updateAddressAPI = contextPath + '/admin/api/users/address/update';

var userUploaders = [null, null];

function addUserRow(id, username, nickname, balance, role, createTime, updateTime) {
    $table.append('<tr id="user-' + id + '">  \
            <th scope="row" class="col-md-1">' + id + '</th>  \
            <td class="col-md-1">' + escapeHtml(username) + '</td>  \
            <td class="col-md-2">' + escapeHtml(nickname) + '</td>  \
            <td class="col-md-1">' + parseFloat(balance).toFixed(2) + '</td>  \
            <td class="col-md-1">' + roles[parseIntEx(role)] + '</td>  \
            <td class="col-md-2">' + createTime + '</td>  \
            <td class="col-md-2">' + updateTime + '</td>  \
            <td class="col-md-2">  \
                <button type="button" class="btn btn-info btn-sm" data-toggle="modal" data-target="#updateDialog" data-id="' + id + '">  \
                    <span class="glyphicon glyphicon-edit"></span>  \
                </button>  \
                <button type="button" class="btn btn-warning btn-sm" data-toggle="modal" data-target="#addressDialog" data-id="' + id + '">  \
                    <span class="glyphicon glyphicon-send"></span>  \
                </button>  \
                <button type="button" class="btn btn-danger btn-sm" data-toggle="modal" data-target="#deleteDialog" data-id="' + id + '">  \
                    <span class="glyphicon glyphicon-trash"></span>  \
                </button>  \
            </td>  \
        </tr>');
}

function loadAllUsers() {
    $.get(allUsersAPI, function (data, status) {
        var userCount = data.length;
        for (var i = 0; i < userCount; ++i) {
            addUserRow(data[i][0], data[i][1], data[i][2], data[i][3] / 100.0, data[i][4], data[i][5], data[i][6]);
        }
        $('.alert-info').alert('close');
    }).fail(function (xhr, status, error) {
        $('.alert').remove();
        $('h1').after(errorAlertHTML('加载用户信息失败！<br>错误：' + error));
    });
}

function addUserCallback(data, status, newUsername, newNickname, newBalance, newRole) {
    $('#addUserStatus').removeClass('hidden');
    if (data.result == 'success') {
        $('#addUserStatus').html(shortSuccessText('添加用户成功！', true));
        setTimeout(function () {
            $('#addDialog').modal('hide');
            $('#addUserUsername').val('');
            $('#addUserPassword').val('');
            $('#addUserPasswordConfirm').val('');
            $('#addUserNickname').val('');
            $('#addUserAvatar').val('');
            $('#addUserBalance').val('');
            $('input[name="addUserRole"]').removeAttr('checked');
            $('input[name="addUserRole"][value="0"]').attr('checked', 'checked');
        }, 1000);
        var currentTime = new Date().format('yyyy-mm-dd HH:MM:ss');
        addUserRow(data.param, newUsername, newNickname, newBalance, newRole, currentTime, currentTime);
    }
    else {
        $('#btnAddUser').removeAttr('disabled');
        if (data.msg)
            $('#addUserStatus').html(shortFailText(data.msg, true));
        else if (status != 'success')
            $('#addUserStatus').html(shortFailText(status, true));
        else
            $('#addUserStatus').html(shortFailText('发生未知错误', true));
    }
}

function updateUserCallback(data, status, id, newUsername, newNickname, newAvatar, newBalance, newRole) {
    if (data.result == 'success') {
        $('#timeDetailText').html(shortSuccessText('修改用户信息成功！', true));
        setTimeout(function () {
            $('#updateDialog').modal('hide');
        }, 1000);
        if (id == $('#currentUserId').val()) {
            $('#myNavbarNickname').text(newNickname);
            $('#myNavbarAvatar').attr('src', showUserAvatar(newAvatar));
        }
        $('#user-' + id).children().first().next().text(newUsername);
        $('#user-' + id).children().first().next().next().text(newNickname);
        $('#user-' + id).children().first().next().next().next().text(newBalance);
        $('#user-' + id).children().first().next().next().next().next().text(roles[parseInt(newRole)]);
        $('#user-' + id).children().first().next().next().next().next().next().next().text(new Date().format('yyyy-mm-dd HH:MM:ss'));
    }
    else {
        $('#btnUpdateUser').removeAttr('disabled');
        if (data.msg)
            $('#timeDetailText').html(shortFailText(data.msg, true));
        else if (status != 'success')
            $('#timeDetailText').html(shortFailText(status, true));
        else
            $('#timeDetailText').html(shortFailText('发生未知错误', true));
    }
}

function deleteUserCallback(data, status, id) {
    $('#deleteUserStatus').removeClass('hidden');
    if (data.result == 'success') {
        $('#deleteUserStatus').html(shortSuccessText('删除用户成功！'));
        setTimeout(function () {
            $('#deleteDialog').modal('hide');
        }, 1000);
        $('#user-' + id).remove();
    }
    else {
        $('#btnDeleteUser').removeAttr('disabled');
        if (data.msg)
            $('#deleteUserStatus').html(shortFailText(data.msg));
        else if (status != 'success')
            $('#deleteUserStatus').html(shortFailText(status));
        else
            $('#deleteUserStatus').html(shortFailText('发生未知错误'));
    }
}

function updateAddressCallback(data, status) {
    $('#addressStatus').removeClass('hidden');
    if (data.result == 'success') {
        $('#addressStatus').html(shortSuccessText('修改用户收货地址成功！'));
        setTimeout(function () {
            $('#addressDialog').modal('hide');
        }, 1000);
    }
    else {
        $('#btnUpdateAddress').removeAttr('disabled');
        if (data.msg)
            $('#addressStatus').html(shortFailText(data.msg));
        else if (status != 'success')
            $('#addressStatus').html(shortFailText(status));
        else
            $('#addressStatus').html(shortFailText('发生未知错误'));
    }
}

function bindFileUploadButtons() {
    var actions = ['add', 'update'];
    for (i in [0, 1]) {
        userUploaders[i] = new ss.SimpleUpload({
            button: $('#' + actions[i] + 'UserUploadBtn'),
            url: uploadImageAPI,
            name: 'image',
            maxSize: maxFileSize,
            allowedExtensions: imageExtensions,
            responseType: 'json',
            onSubmit: (function (action) {
                return function () {
                    $('#' + action + 'UserUploadTips').html(shortProcessingText('上传图片中...'));
                };
            })(actions[i]),
            onSizeError: (function (action) {
                return function() {
                    $('#' + action + 'UserUploadTips').html(shortFailText('文件大小不能超过 2M'));
                };
            })(actions[i]),
            onExtError: (function (action) {
                return function() {
                    $('#' + action + 'UserUploadTips').html(shortFailText('仅支持 JPG、PNG、BMP、GIF 格式的图片文件'));
                };
            })(actions[i]),
            onComplete: (function (action) {
                return function (filename, response) {
                    uploadCallback($('#' + action + 'UserUploadTips'), $('#' + action + 'UserAvatar'), $('#' + action + 'UserImageShow'), defaultUserAvatar, response);
                };
            })(actions[i]),
            onError: (function (action) {
                return function (filename, errorType, status, statusText, response) {
                    uploadCallback($('#' + action + 'UserUploadTips'), $('#' + action + 'UserAvatar'), $('#' + action + 'UserImageShow'), defaultUserAvatar, tryJSONParse(response), statusText);
                };
            })(actions[i])
        });
    }
}

function addAddressInput() {
    $addressForm.append('<div class="form-group address-div"> \
                            <div class="col-sm-11"> \
                                <input type="text" class="form-control address-input" placeholder="填写收货地址"> \
                            </div> \
                            <button type="button" class="btn btn-danger delete-address-btn"><span class="glyphicon glyphicon-trash"></span></button> \
                        </div>');
}

$(document).ready(function () {
    loadAllUsers();
    bindFileUploadButtons();
});

$('#addDialog').on('show.bs.modal', function () {
    if ($('#addUserAvatar').val() == '')
        $('#addUserImageShow').attr('src', defaultUserAvatar);
    $('#addUserUploadTips').html(supportImgHTML);
    $('#addUserStatus').addClass('hidden');
    $('#btnAddUser').removeAttr('disabled');
});

$('#addDialog').on('shown.bs.modal', function () {
    $('#addUserUsername').focus();
});

$('#btnAddUser').click(function () {
    $('#btnAddUser').attr('disabled', 'disabled');
    var newUsername = $('#addUserUsername').val();
    var newPassword = $('#addUserPassword').val();
    var newPasswordConfirm = $('#addUserPasswordConfirm').val();
    var newNickname = $('#addUserNickname').val();
    var newAvatar = $('#addUserAvatar').val();
    var newBalance = $('#addUserBalance').val();
    var newRole = $('input[name="addUserRole"]:checked').val();
    var postData = {
        'username': newUsername,
        'password': newPassword,
        'passwordConfirm': newPasswordConfirm,
        'nickname': newNickname,
        'avatar': newAvatar,
        'balance': newBalance,
        'role': newRole
    };
    $.post(addUserAPI, postData, function (data, status) {
        addUserCallback(data, status, newUsername, newNickname, newBalance, newRole);
    }).fail(function (xhr, status, error) {
        addUserCallback(tryJSONParse(xhr.responseText), error, newUsername, newNickname, newBalance, newRole);
    });
});

$('#updateDialog').on('show.bs.modal', function (event) {
    var updateId = $(event.relatedTarget).data('id');
    var updateUsername = $('#user-' + updateId).children().first().next().text();
    var updateNickname = $('#user-' + updateId).children().first().next().next().text();
    var updateBalance = $('#user-' + updateId).children().first().next().next().next().text();
    var updateRole = roles.indexOf($('#user-' + updateId).children().first().next().next().next().next().text());
    var createTime = $('#user-' + updateId).children().first().next().next().next().next().next().text();
    var updateTime = $('#user-' + updateId).children().first().next().next().next().next().next().next().text();
    $('#updateDialogLabel').text('修改用户基本信息 - 编号：' + updateId);
    $('#updateUserId').val(updateId);
    $('#updateUserUsername').val(updateUsername);
    $('#updateUserPassword').val('');
    $('#updateUserPasswordConfirm').val('');
    $('#updateUserNickname').val(updateNickname);
    $('#updateUserBalance').val(updateBalance);
    $('input[name="updateUserRole"]').removeAttr('checked');
    $('input[name="updateUserRole"][value="' + updateRole + '"]').attr('checked', 'checked');
    $('#updateUserAvatar').val('');
    $('#updateUserImageShow').attr('src', defaultUserAvatar);
    $('#updateUserUploadTips').html(shortProcessingText('正在加载用户头像...'));
    $('#timeDetailText').html('<div class="col-md-6"><span class="glyphicon glyphicon-check"></span> 创建时间：' + createTime + '</div>  \
            <div class="col-md-6 text-right"><span class="glyphicon glyphicon-edit"></span> 修改时间：' + updateTime + '</div>');
    $('#btnUpdateUser').attr('disabled', 'disabled');
    $.get(userDetailAPI + '?id=' + updateId, function (data, status) {
        $('#updateUserAvatar').val(data.avatar);
        $('#updateUserImageShow').attr('src', showUserAvatar(data.avatar));
        $('#updateUserUploadTips').html(supportImgHTML);
        $('#btnUpdateUser').removeAttr('disabled');
    }).fail(function (xhr, status, error) {
        $('#updateUserUploadTips').html(shortFailText('加载用户头像失败！错误：' + error));
    });
});

$('#updateDialog').on('shown.bs.modal', function () {
    $('#updateUserUsername').focus();
});

$('#deleteUserImageBtn').click(function () {
    $('#updateUserAvatar').val('');
    $('#updateUserImageShow').attr('src', defaultUserAvatar);
    $('#updateUserUploadTips').html(supportImgHTML);
});

$('#btnUpdateUser').click(function () {
    $('#btnUpdateUser').attr('disabled', 'disabled');
    var id = $('#updateUserId').val();
    var newUsername = $('#updateUserUsername').val();
    var newPassword = $('#updateUserPassword').val();
    var newPasswordConfirm = $('#updateUserPasswordConfirm').val();
    var newNickname = $('#updateUserNickname').val();
    var newAvatar = $('#updateUserAvatar').val();
    var newBalance = $('#updateUserBalance').val();
    var newRole = $('input[name="updateUserRole"]:checked').val();
    var postData = {
        'id': id,
        'username': newUsername,
        'password': newPassword,
        'passwordConfirm': newPasswordConfirm,
        'nickname': newNickname,
        'avatar': newAvatar,
        'balance': newBalance,
        'role': newRole
    };
    $.post(updateUserAPI, postData, function (data, status) {
        updateUserCallback(data, status, id, newUsername, newNickname, newAvatar, newBalance, newRole);
    }).fail(function (xhr, status, error) {
        updateUserCallback(tryJSONParse(xhr.responseText), error, id, newUsername, newNickname, newAvatar, newBalance, newRole);
    });
});

$('#addressDialog').on('show.bs.modal', function (event) {
    var addressId = $(event.relatedTarget).data('id');
    $('#addressDialogLabelText').text('修改用户收货地址 - 编号：' + addressId + ' ');
    $('#addressUserId').val(addressId);
    $('#addressStatus').removeClass('hidden');
    $('#addressStatus').html(shortProcessingText('正在加载用户收货地址...'));
    $('.address-div').remove();
    $('#btnUpdateAddress').attr('disabled', 'disabled');
    $.get(getAddressAPI + '?id=' + addressId, function (data, status) {
        $('#addressStatus').addClass('hidden');
        if (data.length == 0) {
            addAddressInput();
        } else {
            var i = 0;
            for (i = 0; i < data.length; ++i)
                addAddressInput();
            i = 0;
            $('.address-input').each(function () {
                $(this).val(data[i]);
                ++i;
            });
        }
        $('#btnUpdateAddress').removeAttr('disabled');
    }).fail(function (xhr, status, error) {
        $('#addressStatus').html(shortFailText('加载用户收货地址失败！错误：' + error));
    });
});

$('#addressDialog').on('shown.bs.modal', function () {
    $('.address-input').focus();
});

$('#btnAddAddress').click(function () {
    addAddressInput();
    $('.address-input').focus();
});

$(document).on('click', '.delete-address-btn', function () {
    $(this).parent().remove();
    $('.address-input').focus();
});

$('#btnUpdateAddress').click(function () {
    $('#btnUpdateAddress').attr('disabled', 'disabled');
    var addresses = [];
    $('.address-input').each(function () {
        var address = $(this).val().trim();
        if (isNotEmptyString(address))
            addresses.push(address);
    });
    var postData = {
        'id': $('#addressUserId').val(),
        'addresses': JSON.stringify(addresses)
    }
    $.post(updateAddressAPI, postData, updateAddressCallback).fail(function (xhr, status, error) {
        updateAddressCallback(tryJSONParse(xhr.responseText), error);
    });
});

$('#deleteDialog').on('show.bs.modal', function (event) {
    var deleteId = $(event.relatedTarget).data('id');
    var deleteUsername = $('#user-' + deleteId).children().first().next().text();
    $('#deleteUserId').val(deleteId);
    $('#deleteText').html('您确实要删除用户名为 <strong>' + escapeHtml(deleteUsername) + '</strong> 的用户吗？');
    $('#deleteUserStatus').addClass('hidden');
    $('#btnDeleteUser').removeAttr('disabled');
});

$('#btnDeleteUser').click(function () {
    $('#btnDeleteUser').attr('disabled', 'disabled');
    var id = $('#deleteUserId').val();
    var postData = {'id': id};
    $.post(deleteUserAPI, postData, function (data, status) {
        deleteUserCallback(data, status, id);
    }).fail(function (xhr, status, error) {
        deleteUserCallback(tryJSONParse(xhr.responseText), error, id);
    });
});
