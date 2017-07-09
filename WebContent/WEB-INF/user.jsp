<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>

<jsp:include page="./layout/page_head.jsp" />

<jsp:include page="./layout/content_navbar.jsp" />

<div class="container">
    <h1>用户管理
        <button type="button" class="btn btn-success btn-sm" data-toggle="modal" data-target="#addDialog">
            <span class="glyphicon glyphicon-plus"></span>
        </button>
    </h1>
    <div class="alert alert-info fade in" role="alert">正在加载用户信息...</div>
    <div class="table-responsive">
        <table class="table table-hover">
            <thead>
                <tr>
                    <th>编号</th>
                    <th>用户名</th>
                    <th>昵称</th>
                    <th>身份</th>
                    <th>创建时间</th>
                    <th>修改时间</th>
                    <th>操作</th>
                </tr>
            </thead>
            <tbody>
            <!-- Table data will be loaded by js. -->
            </tbody>
        </table>
    </div>
</div>

<div class="modal fade" id="addDialog" tabindex="-1" role="dialog" aria-labelledby="addDialogLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="addDialogLabel">添加用户</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="addUserUsername" class="col-sm-2 control-label">用户名</label>
                        <div class="col-sm-8">
                            <input type="text" class="form-control" id="addUserUsername" placeholder="用户名">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="addUserPassword" class="col-sm-2 control-label">密码</label>
                        <div class="col-sm-8">
                            <input type="password" class="form-control" id="addUserPassword" placeholder="密码">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="addUserPasswordConfirm" class="col-sm-2 control-label">确认密码</label>
                        <div class="col-sm-8">
                            <input type="password" class="form-control" id="addUserPasswordConfirm" placeholder="确认密码">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="addUserNickname" class="col-sm-2 control-label">昵称</label>
                        <div class="col-sm-8">
                            <input type="text" class="form-control" id="addUserNickname" placeholder="昵称">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">身份</label>
                        <div class="col-sm-8">
                            <label class="radio-inline">
                                <input type="radio" name="addUserRole" id="addUserRole0" value="0" checked="checked">顾客
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="addUserRole" id="addUserRole1" value="1">管理员
                            </label>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-success" data-dismiss="modal" id="btnAddUser">添加</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="updateDialog" tabindex="-1" role="dialog" aria-labelledby="updateDialogLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="updateDialogLabel">修改用户信息</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <input type="text" class="form-control hidden" id="updateUserId">
                    <div class="form-group">
                        <label for="updateUserUsername" class="col-sm-2 control-label">用户名</label>
                        <div class="col-sm-8">
                            <input type="text" class="form-control" id="updateUserUsername" placeholder="用户名">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="updateUserPassword" class="col-sm-2 control-label">密码</label>
                        <div class="col-sm-8">
                            <input type="password" class="form-control" id="updateUserPassword" placeholder="填写此栏以重置密码">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="updateUserPasswordConfirm" class="col-sm-2 control-label">确认密码</label>
                        <div class="col-sm-8">
                            <input type="password" class="form-control" id="updateUserPasswordConfirm" placeholder="填写此栏以确认重置密码">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="updateUserNickname" class="col-sm-2 control-label">昵称</label>
                        <div class="col-sm-8">
                            <input type="text" class="form-control" id="updateUserNickname" placeholder="昵称">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">身份</label>
                        <div class="col-sm-8">
                            <label class="radio-inline">
                                <input type="radio" name="updateUserRole" id="updateUserRole0" value="0">顾客
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="updateUserRole" id="updateUserRole1" value="1">管理员
                            </label>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-info" data-dismiss="modal" id="btnUpdateUser">修改</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="deleteDialog" tabindex="-1" role="dialog" aria-labelledby="deleteDialogLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="deleteDialogLabel">删除用户</h4>
            </div>
            <div class="modal-body">
                <p id="deleteText"></p>
                <input type="text" class="form-control hidden" id="deleteUserId">
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-danger" data-dismiss="modal" id="btnDeleteUser">删除</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
            </div>
        </div>
    </div>
</div>

<jsp:include page="./layout/content_footer.jsp" />

<jsp:include page="./layout/common_js.jsp" />

<script>

var $table = $('tbody');
var roles = ['顾客', '管理员'];

function addUserRow(id, username, nickname, role, createTime, updateTime) {
    $table.append('<tr id="user-'+ id + '">  \
            <th scope="row" class="col-md-1">' + id + '</th>  \
            <td class="col-md-2">' + escapeHtml(username) + '</td>  \
            <td class="col-md-3">' + escapeHtml(nickname) + '</td>  \
            <td class="col-md-1">' + roles[parseIntEx(role)] + '</td>  \
            <td class="col-md-2">' + createTime + '</td>  \
            <td class="col-md-2">' + updateTime + '</td>  \
            <td class="col-md-1">  \
                <button type="button" class="btn btn-info btn-sm" data-toggle="modal" data-target="#updateDialog" data-id="' + id + '">  \
                    <span class="glyphicon glyphicon-edit"></span>  \
                </button>  \
                <button type="button" class="btn btn-danger btn-sm" data-toggle="modal" data-target="#deleteDialog" data-id="' + id + '">  \
                    <span class="glyphicon glyphicon-trash"></span>  \
                </button>  \
            </td>  \
        </tr>');
}

$('document').ready(function () {
    $.get('/BookStore/allusers', function (data, status) {
        var userCount = data.length;
        for (var i = 0; i < userCount; ++i) {
            addUserRow(data[i][0], data[i][1], data[i][2], data[i][3], data[i][4], data[i][5]);
        }
        $('.alert-info').alert('close');
    }).fail(function (xhr, errorText, errorType) {
        $('.alert').remove();
        $('h1').after(alertFailHTML + '加载用户信息失败！<br>错误：' + errorType + '，请联系管理员。' + alertDismissHTML);
    });
});

$('#addDialog').on('shown.bs.modal', function () {
    $('#addUserUsername').focus();
});

$('#btnAddUser').click(function() {
    var newUsername = $('#addUserUsername').val();
    var newPassword = $('#addUserPassword').val();
    var newPasswordConfirm = $('#addUserPasswordConfirm').val();
    var newNickname = $('#addUserNickname').val();
    var newRole = $('input[name="addUserRole"]:checked').val();
    var postData = {
        'username': newUsername,
        'password': newPassword,
        'passwordConfirm': newPasswordConfirm,
        'nickname': newNickname,
        'role': newRole
    };
    $.post('/BookStore/adduser', postData, function (data, status) {
        $('.alert').remove();
        if (data.result == 'success') {
            $('h1').after(alertSuccessHTML('success') + '添加用户成功！' + alertDismissHTML);
            $('#addUserUsername').val('');
            $('#addUserPassword').val('');
            $('#addUserPasswordConfirm').val('');
            $('#addUserNickname').val('');
            $('input[name="addUserRole"]').removeAttr('checked');
            $('input[name="addUserRole"][value="0"]').attr('checked', 'checked');
            var currentTime = new Date().format('yyyy-mm-dd HH:MM:ss');
            addUserRow(data.id, newUsername, newNickname, newRole, currentTime, currentTime);
            setTimeout(function () {
                $('.alert-success').alert('close');
            }, 3000);
        }
        else {
            if (data.msg) {
                $('h1').after(alertFailHTML + '错误：' + data.msg + alertDismissHTML);
            }
            else {
                $('h1').after(alertFailHTML + '未知错误，请联系管理员。' + alertDismissHTML);
            }
        }
    }).fail(function (xhr, errorText, errorType) {
        $('.alert').remove();
        $('h1').after(alertFailHTML + '错误：' + errorType + '，请联系管理员。' + alertDismissHTML);
    });
});

$('#updateDialog').on('show.bs.modal', function (event) {
    var updateId = $(event.relatedTarget).data('id');
    var updateUsername = $('#user-' + updateId).children().first().next().text();
    var updateNickname = $('#user-' + updateId).children().first().next().next().text();
    var updateRole = roles.indexOf($('#user-' + updateId).children().first().next().next().next().text());
    var createTime = $('#user-' + updateId).children().first().next().next().next().next().text();
    var updateTime = $('#user-' + updateId).children().first().next().next().next().next().next().text();
    $('#updateDialogLabel').text('修改用户信息 - 编号：' + updateId);
    $('#updateUserId').val(updateId);
    $('#updateUserUsername').val(updateUsername);
    $('#updateUserPassword').val('');
    $('#updateUserPasswordConfirm').val('');
    $('#updateUserNickname').val(updateNickname);
    $('input[name="updateUserRole"]').removeAttr('checked');
    $('input[name="updateUserRole"][value="' + updateRole + '"]').attr('checked', 'checked');
});

$('#updateDialog').on('shown.bs.modal', function () {
    $('#updateUserUsername').focus();
});

$('#btnUpdateUser').click(function() {
    var id = $('#updateUserId').val();
    var newUsername = $('#updateUserUsername').val();
    var newPassword = $('#updateUserPassword').val();
    var newPasswordConfirm = $('#updateUserPasswordConfirm').val();
    var newNickname = $('#updateUserNickname').val();
    var newRole = $('input[name="updateUserRole"]:checked').val();
    var postData = {
        'id': id,
        'username': newUsername,
        'password': newPassword,
        'passwordConfirm': newPasswordConfirm,
        'nickname': newNickname,
        'role': newRole
    };
    $.post('/BookStore/updateuser', postData, function (data, status) {
        $('.alert').remove();
        $('html, body').animate({scrollTop: 0});
        if (data.result == 'success') {
            $('h1').after(alertSuccessHTML('info') + '修改用户信息成功！' + alertDismissHTML);
            $('#user-' + id).children().first().next().text(newUsername);
            $('#user-' + id).children().first().next().next().text(newNickname);
            $('#user-' + id).children().first().next().next().next().text(roles[parseInt(newRole)]);
            $('#user-' + id).children().first().next().next().next().next().next().text(new Date().format('yyyy-mm-dd HH:MM:ss'));
            setTimeout(function () {
                $('.alert-info').alert('close');
            }, 3000);
        }
        else {
            if (data.msg) {
                $('h1').after(alertFailHTML + '错误：' + data.msg + alertDismissHTML);
            }
            else {
                $('h1').after(alertFailHTML + '未知错误，请联系管理员。' + alertDismissHTML);
            }
        }
    }).fail(function (xhr, errorText, errorType) {
        $('.alert').remove();
        $('html, body').animate({scrollTop: 0});
        $('h1').after(alertFailHTML + '错误：' + errorType + '，请联系管理员。' + alertDismissHTML);
    });
});

$('#deleteDialog').on('show.bs.modal', function (event) {
    var deleteId = $(event.relatedTarget).data('id');
    var deleteUsername = $('#user-' + deleteId).children().first().next().text();
    $('#deleteUserId').val(deleteId);
    $('#deleteText').html('您确实要删除用户名为 <strong>' + escapeHtml(deleteUsername) + '</strong> 的用户吗？');
});

$('#btnDeleteUser').click(function() {
    var id = $('#deleteUserId').val();
    var postData = {
        'id': id
    };
    $.post('/BookStore/deleteuser', postData, function (data, status) {
        $('.alert').remove();
        $('html, body').animate({scrollTop: 0});
        if (data.result == 'success') {
            $('h1').after(alertSuccessHTML('warning') + '删除用户成功！' + alertDismissHTML);
            $('#user-' + id).remove();
            setTimeout(function () {
                $('.alert-warning').alert('close');
            }, 3000);
        }
        else {
            if (data.msg) {
                $('h1').after(alertFailHTML + '错误：' + data.msg + alertDismissHTML);
            }
            else {
                $('h1').after(alertFailHTML + '未知错误，请联系管理员。' + alertDismissHTML);
            }
        }
    }).fail(function (xhr, errorText, errorType) {
        $('.alert').remove();
        $('html, body').animate({scrollTop: 0});
        $('h1').after(alertFailHTML + '错误：' + errorType + '，请联系管理员。' + alertDismissHTML);
    });
});

</script>

<jsp:include page="./layout/page_end.jsp" />

