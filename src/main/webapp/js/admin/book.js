var $table = $('tbody');

var allBooksAdminAPI = contextPath + '/admin/api/books/all';
var bookDetailAdminAPI = contextPath + '/admin/api/books/detail';
var addBookAPI = contextPath + '/admin/api/books/add';
var updateBookAPI = contextPath + '/admin/api/books/update';
var deleteBookAPI = contextPath + '/admin/api/books/delete';

var bookUploaders = [null, null];

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

function loadAllBooks() {
    $.get(allBooksAdminAPI, function (data, status) {
        var bookCount = data.length;
        for (var i = 0; i < bookCount; ++i) {
            addBookRow(data[i][0], data[i][1], data[i][2] / 100.0, data[i][3], data[i][4], data[i][5]);
        }
        $('.alert-info').alert('close');
    }).fail(function (xhr, status, error) {
        $('.alert').remove();
        $('h1').after(errorAlertHTML('加载书籍信息失败！<br>错误：' + error));
    });
}

function addBookCallback(data, status, newName, newPrice, newStock) {
    $('#addBookStatus').removeClass('hidden');
    if (data.result == 'success') {
        $('#addBookStatus').html(shortSuccessText('添加书籍成功！'));
        setTimeout(function () {
            $('#addDialog').modal('hide');
            $('#addBookName').val('');
            $('#addBookImage').val('');
            $('#addBookAuthor').val('');
            $('#addBookPress').val('');
            $('#addBookPrice').val('');
            $('#addBookStock').val('');
            $('#addBookDescription').val('');
        }, 1000);
        var currentTime = new Date().format('yyyy-mm-dd HH:MM:ss');
        addBookRow(data.param, newName, newPrice, newStock, currentTime, currentTime);
    }
    else {
        $('#btnAddBook').removeAttr('disabled');
        if (data.msg)
            $('#addBookStatus').html(shortFailText(data.msg));
        else if (status != 'success')
            $('#addBookStatus').html(shortFailText(status));
        else
            $('#addBookStatus').html(shortFailText('发生未知错误'));
    }
}

function updateBookCallback(data, status, id, newName, newPrice, newStock) {
    if (data.result == 'success') {
        $('#timeDetailText').html(shortSuccessText('修改书籍信息成功！', true));
        setTimeout(function () {
            $('#updateDialog').modal('hide');
        }, 1000);
        $('#book-' + id).children().first().next().text(newName);
        $('#book-' + id).children().first().next().next().text(parseFloat(newPrice).toFixed(2));
        $('#book-' + id).children().first().next().next().next().text(newStock);
        $('#book-' + id).children().first().next().next().next().next().next().text(new Date().format('yyyy-mm-dd HH:MM:ss'));
    }
    else {
        $('#btnUpdateBook').removeAttr('disabled');
        if (data.msg)
            $('#timeDetailText').html(shortFailText(data.msg, true));
        else if (status != 'success')
            $('#timeDetailText').html(shortFailText(status, true));
        else
            $('#timeDetailText').html(shortFailText('发生未知错误', true));
    }
}

function deleteBookCallback(data, status, id) {
    $('#deleteBookStatus').removeClass('hidden');
    if (data.result == 'success') {
        $('#deleteBookStatus').html(shortSuccessText('删除书籍成功！'));
        setTimeout(function () {
            $('#deleteDialog').modal('hide');
        }, 1000);
        $('#book-' + id).remove();
    }
    else {
        $('#btnDeleteBook').removeAttr('disabled');
        if (data.msg)
            $('#deleteBookStatus').html(shortFailText(data.msg));
        else if (status != 'success')
            $('#deleteBookStatus').html(shortFailText(status));
        else
            $('#deleteBookStatus').html(shortFailText('发生未知错误'));
    }
}

function bindFileUploadButtons() {
    var actions = ['add', 'update'];
    for (i in [0, 1]) {
        bookUploaders[i] = new ss.SimpleUpload({
            button: $('#' + actions[i] + 'BookUploadBtn'),
            url: uploadImageAPI,
            name: 'image',
            maxSize: maxFileSize,
            allowedExtensions: imageExtensions,
            responseType: 'json',
            onSubmit: (function (action) {
                return function () {
                    $('#' + action + 'BookUploadTips').html(shortProcessingText('上传图片中...'));
                };
            })(actions[i]),
            onSizeError: (function (action) {
                return function() {
                    $('#' + action + 'BookUploadTips').html(shortFailText('文件大小不能超过 2M'));
                };
            })(actions[i]),
            onExtError: (function (action) {
                return function() {
                    $('#' + action + 'BookUploadTips').html(shortFailText('仅支持 JPG、PNG、BMP、GIF 格式的图片文件'));
                };
            })(actions[i]),
            onComplete: (function (action) {
                return function (filename, response) {
                    uploadCallback($('#' + action + 'BookUploadTips'), $('#' + action + 'BookImage'), $('#' + action + 'BookImageShow'), defaultBookImage, response);
                };
            })(actions[i]),
            onError: (function (action) {
                return function (filename, errorType, status, statusText, response) {
                    uploadCallback($('#' + action + 'BookUploadTips'), $('#' + action + 'BookImage'), $('#' + action + 'BookImageShow'), defaultBookImage, tryJSONParse(response), statusText);
                };
            })(actions[i])
        });
    }
}

$('document').ready(function () {
    loadAllBooks();
    bindFileUploadButtons();
});

$('#addDialog').on('show.bs.modal', function () {
    if ($('#addBookImage').val() == '')
        $('#addBookImageShow').attr('src', defaultBookImage);
    $('#addBookUploadTips').html(supportImgHTML);
    $('#addBookStatus').addClass('hidden');
    $('#btnAddBook').removeAttr('disabled');
});

$('#addDialog').on('shown.bs.modal', function () {
    $('#addBookName').focus();
});

$('#btnAddBook').click(function () {
    $('#btnAddBook').attr('disabled', 'disabled');
    var newName = $('#addBookName').val();
    var newImage = $('#addBookImage').val();
    var newAuthor = $('#addBookAuthor').val();
    var newPress = $('#addBookPress').val();
    var newPrice = $('#addBookPrice').val();
    var newStock = $('#addBookStock').val();
    var newDescription = $('#addBookDescription').val();
    var postData = {
        'name': newName,
        'image': newImage,
        'author': newAuthor,
        'press': newPress,
        'price': newPrice,
        'stock': newStock,
        'description': newDescription
    };
    $.post(addBookAPI, postData, function (data, status) {
        addBookCallback(data, status, newName, newPrice, newStock);
    }).fail(function (xhr, status, error) {
        addBookCallback(tryJSONParse(xhr.responseText), error, newName, newPrice, newStock);
    });
});

$('#updateDialog').on('show.bs.modal', function (event) {
    var updateId = $(event.relatedTarget).data('id');
    $('#updateDialogLabel').text('书籍详情 - 编号：' + updateId);
    $('#updateBookId').val(updateId);
    $('#updateBookName').val('');
    $('#updateBookImage').val('');
    $('#updateBookAuthor').val('');
    $('#updateBookPress').val('');
    $('#updateBookPrice').val('');
    $('#updateBookStock').val('');
    $('#updateBookDescription').val('');
    $('#updateBookImageShow').attr('src', defaultBookImage);
    $('#updateBookUploadTips').html(supportImgHTML);
    $('#bookCategories').html('');
    $('#timeDetailText').html(shortProcessingText('正在加载书籍详情...', true));
    $('#btnUpdateBook').removeAttr('disabled');
    $.get(bookDetailAdminAPI + '?id=' + updateId, function (data, status) {
        $('#updateBookName').val(data.name);
        $('#updateBookImage').val(data.image);
        $('#updateBookAuthor').val(data.author);
        $('#updateBookPress').val(data.press);
        $('#updateBookPrice').val((data.price / 100.0).toFixed(2));
        $('#updateBookStock').val(data.stock);
        $('#updateBookDescription').val(data.description);
        $('#updateBookImageShow').attr('src', showBookImage(data.image));
        var categoryCount = data.categories.length;
        if (categoryCount > 0) {
            for (var i = 0; i < categoryCount; ++i)
                $('#bookCategories').append('<span class="label label-success large-label">' + data.categories[i] + '</span> ');
        } else {
            $('#bookCategories').append('暂无分类信息');
        }
        $('#timeDetailText').html('<div class="col-md-6"><span class="glyphicon glyphicon-check"></span> 创建时间：' + data.createTime + '</div>  \
            <div class="col-md-6 text-right"><span class="glyphicon glyphicon-edit"></span> 修改时间：' + data.updateTime + '</div>');
    }).fail(function (xhr, status, error) {
        $('#timeDetailText').html(shortFailText('加载书籍详情失败！错误：' + error, true));
    });
});

$('#updateDialog').on('shown.bs.modal', function () {
    $('#updateBookName').focus();
});

$('#deleteBookImageBtn').click(function () {
    $('#updateBookImage').val('');
    $('#updateBookImageShow').attr('src', defaultBookImage);
    $('#updateBookUploadTips').html(supportImgHTML);
});

$('#btnUpdateBook').click(function () {
    $('#btnUpdateBook').attr('disabled', 'disabled');
    var id = $('#updateBookId').val();
    var newName = $('#updateBookName').val();
    var newImage = $('#updateBookImage').val();
    var newAuthor = $('#updateBookAuthor').val();
    var newPress = $('#updateBookPress').val();
    var newPrice = $('#updateBookPrice').val();
    var newStock = $('#updateBookStock').val();
    var newDescription = $('#updateBookDescription').val();
    var postData = {
        'id': id,
        'name': newName,
        'image': newImage,
        'author': newAuthor,
        'press': newPress,
        'price': newPrice,
        'stock': newStock,
        'description': newDescription
    };
    $.post(updateBookAPI, postData, function (data, status) {
        updateBookCallback(data, status, id, newName, newPrice, newStock);
    }).fail(function (xhr, status, error) {
        updateBookCallback(tryJSONParse(xhr.responseText), error, id, newName, newPrice, newStock);
    });
});

$('#deleteDialog').on('show.bs.modal', function (event) {
    var deleteId = $(event.relatedTarget).data('id');
    var deleteName = $('#book-' + deleteId).children().first().next().text();
    $('#deleteBookId').val(deleteId);
    $('#deleteText').html('您确实要删除编号为 <strong>' + deleteId + '</strong> 的书籍 <strong>' + escapeHtml(deleteName) + '</strong> 吗？');
    $('#deleteBookStatus').addClass('hidden');
    $('#btnDeleteBook').removeAttr('disabled');
});

$('#btnDeleteBook').click(function () {
    $('#btnDeleteBook').attr('disabled', 'disabled');
    var id = $('#deleteBookId').val();
    var postData = {'id': id};
    $.post(deleteBookAPI, postData, function (data, status) {
        deleteBookCallback(data, status, id);
    }).fail(function (xhr, status, error) {
        deleteBookCallback(tryJSONParse(xhr.responseText), error, id);
    });
});
