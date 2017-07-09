<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>

<jsp:include page="./layout/page_head.jsp" />

<jsp:include page="./layout/content_navbar.jsp" />

<div class="container">
    <h1>书籍管理
        <button type="button" class="btn btn-success btn-sm" data-toggle="modal" data-target="#addDialog">
            <span class="glyphicon glyphicon-plus"></span>
        </button>
    </h1>
    <div class="alert alert-info fade in" role="alert">正在加载书籍信息...</div>
    <div class="table-responsive">
        <table class="table table-hover">
            <thead>
                <tr>
                    <th>编号</th>
                    <th>书名</th>
                    <th>单价</th>
                    <th>库存量</th>
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
                <h4 class="modal-title" id="addDialogLabel">添加书籍</h4>
            </div>
            <div class="modal-body">
                <div class="media">
                    <div class="media-body">
                        <form class="form-horizontal">
                            <div class="form-group">
                                <label for="addBookName" class="col-sm-2 control-label">书名</label>
                                <div class="col-sm-10">
                                    <input type="text" class="form-control" id="addBookName" placeholder="书籍名称">
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="addBookAuthor" class="col-sm-2 control-label">作者</label>
                                <div class="col-sm-10">
                                    <input type="text" class="form-control" id="addBookAuthor" placeholder="书籍作者">
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="addBookPress" class="col-sm-2 control-label">出版社</label>
                                <div class="col-sm-10">
                                    <input type="text" class="form-control" id="addBookPress" placeholder="书籍出版社">
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="addBookPrice" class="col-sm-2 control-label">单价</label>
                                <div class="col-sm-10">
                                    <div class="input-group">
                                        <span class="input-group-addon">&#65509;</span>
                                        <input type="text" class="form-control" id="addBookPrice" placeholder="书籍单价">
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="addBookStock" class="col-sm-2 control-label">库存</label>
                                <div class="col-sm-10">
                                    <div class="input-group">
                                        <input type="text" class="form-control" id="addBookStock" placeholder="库存量">
                                        <span class="input-group-addon">本</span>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                    <div class="media-right">
                        <img class="media-object" src="/BookStore/img/default.png" alt="暂无图片">
                        <p>&nbsp;</p>
                        <button type="button" class="btn btn-block btn-primary" id="addBookImage">上传书籍图片</button>
                    </div>
                </div>
                <form class="form-horizontal">
                    <div class="form-group">
                        <div class="col-sm-12">
                            <textarea class="form-control" rows="5" id="addBookDescription" placeholder="写一些关于书籍的简要介绍"></textarea>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-success" data-dismiss="modal" id="btnAddBook">添加</button>
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
                <h4 class="modal-title" id="updateDialogLabel">书籍详情</h4>
            </div>
            <div class="modal-body">
                <div class="media">
                    <div class="media-body">
                        <form class="form-horizontal">
                            <input type="text" class="form-control hidden" id="updateBookId">
                            <div class="form-group">
                                <label for="updateBookName" class="col-sm-2 control-label">书名</label>
                                <div class="col-sm-10">
                                    <input type="text" class="form-control" id="updateBookName" placeholder="书籍名称">
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="updateBookAuthor" class="col-sm-2 control-label">作者</label>
                                <div class="col-sm-10">
                                    <input type="text" class="form-control" id="updateBookAuthor" placeholder="书籍作者">
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="updateBookPress" class="col-sm-2 control-label">出版社</label>
                                <div class="col-sm-10">
                                    <input type="text" class="form-control" id="updateBookPress" placeholder="书籍出版社">
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="updateBookPrice" class="col-sm-2 control-label">单价</label>
                                <div class="col-sm-10">
                                    <div class="input-group">
                                        <span class="input-group-addon">&#65509;</span>
                                        <input type="text" class="form-control" id="updateBookPrice" placeholder="书籍单价">
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="updateBookStock" class="col-sm-2 control-label">库存</label>
                                <div class="col-sm-10">
                                    <div class="input-group">
                                        <input type="text" class="form-control" id="updateBookStock" placeholder="库存量">
                                        <span class="input-group-addon">本</span>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                    <div class="media-right">
                        <img class="media-object" src="/BookStore/img/default.png" alt="暂无图片">
                        <p>&nbsp;</p>
                        <button type="button" class="btn btn-block btn-primary" id="updateBookImage">更换书籍图片</button>
                    </div>
                </div>
                <form class="form-horizontal">
                    <div class="form-group">
                        <div class="col-sm-12">
                            <textarea class="form-control" rows="5" id="updateBookDescription" placeholder="写一些关于书籍的简要介绍"></textarea>
                        </div>
                    </div>
                </form>
                <div class="row" id="timeDetailText"></div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-info" data-dismiss="modal" id="btnUpdateBook">保存</button>
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
                <h4 class="modal-title" id="deleteDialogLabel">删除书籍</h4>
            </div>
            <div class="modal-body">
                <p id="deleteText"></p>
                <input type="text" class="form-control hidden" id="deleteBookId">
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-danger" data-dismiss="modal" id="btnDeleteBook">删除</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
            </div>
        </div>
    </div>
</div>

<jsp:include page="./layout/content_footer.jsp" />

<jsp:include page="./layout/common_js.jsp" />

<script>

var $table = $('tbody');

function addBookRow(id, name, price, stock, createTime, updateTime) {
    $table.append('<tr id="book-'+ id + '">  \
             <th scope="row" class="col-md-1">' + id + '</th>  \
             <td class="col-md-4">' + escapeHtml(name) + '</td>  \
             <td class="col-md-1">' + parseFloat(price).toFixed(2) + '</td>  \
             <td class="col-md-1">' + stock + '</td>  \
             <td class="col-md-2">' + createTime + '</td>  \
             <td class="col-md-2">' + updateTime + '</td>  \
             <td class="col-md-1">  \
                 <button type="button" class="btn btn-info btn-sm" data-toggle="modal" data-target="#updateDialog" data-id="' + id + '">  \
                     <span class="glyphicon glyphicon-option-horizontal"></span>  \
                 </button>  \
                 <button type="button" class="btn btn-danger btn-sm" data-toggle="modal" data-target="#deleteDialog" data-id="' + id + '">  \
                     <span class="glyphicon glyphicon-trash"></span>  \
                 </button>  \
             </td>  \
         </tr>');
}

$('document').ready(function () {
    $.get('/BookStore/allbooks', function (data, status) {
        var bookCount = data.length;
        for (var i = 0; i < bookCount; ++i) {
            addBookRow(data[i][0], data[i][1], data[i][2] / 100.0, data[i][3], data[i][4], data[i][5]);
        }
        $('.alert-info').alert('close');
    }).fail(function (xhr, errorText, errorType) {
        $('.alert').remove();
        $('h1').after(alertFailHTML + '加载书籍信息失败！<br>错误：' + errorType + '，请联系管理员。' + alertDismissHTML);
    });
});

$('#addDialog').on('shown.bs.modal', function () {
    $('#addBookName').focus();
});

$('#btnAddBook').click(function() {
    var newName = $('#addBookName').val();
    var newAuthor = $('#addBookAuthor').val();
    var newPress = $('#addBookPress').val();
    var newPrice = $('#addBookPrice').val();
    var newStock = $('#addBookStock').val();
    var newDescription = $('#addBookDescription').val();
    var postData = {
        'name': newName,
        'author': newAuthor,
        'press': newPress,
        'price': newPrice,
        'stock': newStock,
        'description': newDescription
    };
    $.post('/BookStore/addbook', postData, function (data, status) {
        $('.alert').remove();
        if (data.result == 'success') {
            $('h1').after(alertSuccessHTML('success') + '添加书籍成功！' + alertDismissHTML);
            $('#addBookName').val('');
            $('#addBookAuthor').val('');
            $('#addBookPress').val('');
            $('#addBookPrice').val('');
            $('#addBookStock').val('');
            $('#addBookDescription').val('');
            var currentTime = new Date().format('yyyy-mm-dd HH:MM:ss');
            addBookRow(data.id, newName, newPrice, newStock, currentTime, currentTime);
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
    $('#updateDialogLabel').text('书籍详情 - 编号：' + updateId);
    $('#updateBookId').val(updateId);
    $('#updateBookName').val('');
    $('#updateBookAuthor').val('');
    $('#updateBookPress').val('');
    $('#updateBookPrice').val('');
    $('#updateBookStock').val('');
    $('#updateBookDescription').val('');
    $('#timeDetailText').html('<div class="col-md-12 text-info">正在加载书籍详情...</div>');
    $.get('/BookStore/bookdetail?id=' + updateId, function (data, status) {
        $('#updateBookName').val(data.name);
        $('#updateBookAuthor').val(data.author);
        $('#updateBookPress').val(data.press);
        $('#updateBookPrice').val((data.price / 100.0).toFixed(2));
        $('#updateBookStock').val(data.stock);
        $('#updateBookDescription').val(data.description);
        $('#timeDetailText').html('<div class="col-md-6">创建时间：' + data.createTime + '</div>  \
            <div class="col-md-6 text-right">修改时间：' + data.updateTime + '</div>');
    }).fail(function (xhr, errorText, errorType) {
        $('.alert').remove();
        $('h1').after(alertFailHTML + '加载书籍详情失败！<br>错误：' + errorType + '，请联系管理员。' + alertDismissHTML);
        $('#timeDetailText').html('<div class="col-md-12 text-danger">加载书籍详情失败！</div>');
    });
});

$('#updateDialog').on('shown.bs.modal', function () {
    $('#updateBookName').focus();
});

$('#btnUpdateBook').click(function() {
    var id = $("#updateBookId").val();
    var newName = $('#updateBookName').val();
    var newAuthor = $('#updateBookAuthor').val();
    var newPress = $('#updateBookPress').val();
    var newPrice = $('#updateBookPrice').val();
    var newStock = $('#updateBookStock').val();
    var newDescription = $('#updateBookDescription').val();
    var postData = {
        'id': id,
        'name': newName,
        'author': newAuthor,
        'press': newPress,
        'price': newPrice,
        'stock': newStock,
        'description': newDescription
    };
    $.post('/BookStore/updatebook', postData, function (data, status) {
        $('.alert').remove();
        $('html, body').animate({scrollTop: 0});
        if (data.result == 'success') {
            $('h1').after(alertSuccessHTML('info') + '修改书籍信息成功！' + alertDismissHTML);
            $('#book-' + id).children().first().next().text(newName);
            $('#book-' + id).children().first().next().next().text(parseFloat(newPrice).toFixed(2));
            $('#book-' + id).children().first().next().next().next().text(newStock);
            $('#book-' + id).children().first().next().next().next().next().next().text(new Date().format('yyyy-mm-dd HH:MM:ss'));
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
    var deleteName = $('#book-' + deleteId).children().first().next().text();
    $('#deleteBookId').val(deleteId);
    $('#deleteText').html('您确实要删除编号为 <strong>' + deleteId + '</strong> 的书籍 <strong>' + escapeHtml(deleteName) + '</strong> 吗？');
});

$('#btnDeleteBook').click(function() {
    var id = $('#deleteBookId').val();
    var postData = {
        'id': id
    };
    $.post('/BookStore/deletebook', postData, function (data, status) {
        $('.alert').remove();
        $('html, body').animate({scrollTop: 0});
        if (data.result == 'success') {
            $('h1').after(alertSuccessHTML('warning') + '删除书籍成功！' + alertDismissHTML);
            $('#book-' + id).remove();
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

