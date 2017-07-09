var $mainTable = $('#mainTable');
var $detailTable = $('#detailTable');

var allCategoriesAPI = contextPath + '/admin/api/categories/all';
var categoryDetailAPI = contextPath + '/admin/api/categories/detail';
var addCategoryAPI = contextPath + '/admin/api/categories/add';
var updateCategoryAPI = contextPath + '/admin/api/categories/update';
var deleteCategoryAPI = contextPath + '/admin/api/categories/delete';
var addBookToCategoryAPI = contextPath + '/admin/api/categories/addBook';
var deleteBookFromCategoryAPI = contextPath + '/admin/api/categories/deleteBook';

function addCategoryRow(id, name, createTime, updateTime) {
    $mainTable.append('<tr id="category-' + id + '">  \
             <th scope="row" class="col-md-1">' + id + '</th>  \
             <td class="col-md-5">' + escapeHtml(name) + '</td>  \
             <td class="col-md-2">' + createTime + '</td>  \
             <td class="col-md-2">' + updateTime + '</td>  \
             <td class="col-md-2">  \
                 <button type="button" class="btn btn-primary btn-sm" data-toggle="modal" data-target="#categoryDetailDialog" data-id="' + id + '">  \
                     <span class="glyphicon glyphicon-option-horizontal"></span>  \
                 </button>  \
                 <button type="button" class="btn btn-success btn-sm" data-toggle="modal" data-target="#addBookToCategoryDialog" data-id="' + id + '">  \
                     <span class="glyphicon glyphicon-plus"></span>  \
                 </button>  \
                 <button type="button" class="btn btn-info btn-sm" data-toggle="modal" data-target="#updateCategoryDialog" data-id="' + id + '">  \
                     <span class="glyphicon glyphicon-edit"></span>  \
                 </button>  \
                 <button type="button" class="btn btn-danger btn-sm" data-toggle="modal" data-target="#deleteCategoryDialog" data-id="' + id + '">  \
                     <span class="glyphicon glyphicon-trash"></span>  \
                 </button>  \
             </td>  \
         </tr>');
}

function addCategoryDetailRow(id, bookId, bookName) {
    $detailTable.append('<tr id="bc-' + id + '">  \
             <th scope="row" class="col-md-2">' + bookId + '</th> \
             <td class="col-md-8">' + escapeHtml(bookName) + '</td> \
             <td class="col-md-2">  \
                 <button type="button" class="btn btn-danger btn-sm delete-bc" data-id="' + id + '">  \
                     <span class="glyphicon glyphicon-trash"></span>  \
                 </button>  \
             </td>  \
         </tr>');
}

function addCategoryCallback(data, status, newName) {
    $('#addCategoryStatus').removeClass('hidden');
    if (data.result == 'success') {
        $('#addCategoryStatus').html(shortSuccessText('添加分类成功！'));
        setTimeout(function () {
            $('#addCategoryDialog').modal('hide');
            $('#addCategoryName').val('');
        }, 1000);
        var currentTime = new Date().format('yyyy-mm-dd HH:MM:ss');
        addCategoryRow(data.param, newName, currentTime, currentTime);
    }
    else {
        $('#btnAddCategory').removeAttr('disabled');
        if (data.msg)
            $('#addCategoryStatus').html(shortFailText(data.msg));
        else if (status != 'success')
            $('#addCategoryStatus').html(shortFailText(status));
        else
            $('#addCategoryStatus').html(shortFailText('发生未知错误'));
    }
}

function updateCategoryCallback(data, status, id, newName) {
    $('#updateCategoryStatus').removeClass('hidden');
    if (data.result == 'success') {
        $('#updateCategoryStatus').html(shortSuccessText('修改分类名称成功！'));
        setTimeout(function () {
            $('#updateCategoryDialog').modal('hide');
        }, 1000);
        $('#category-' + id).children().first().next().text(newName);
        $('#category-' + id).children().first().next().next().next().text(new Date().format('yyyy-mm-dd HH:MM:ss'));
    }
    else {
        $('#btnUpdateCategory').removeAttr('disabled');
        if (data.msg)
            $('#updateCategoryStatus').html(shortFailText(data.msg));
        else if (status != 'success')
            $('#updateCategoryStatus').html(shortFailText(status));
        else
            $('#updateCategoryStatus').html(shortFailText('发生未知错误'));
    }
}

function deleteCategoryCallback(data, status, id) {
    $('#deleteCategoryStatus').removeClass('hidden');
    if (data.result == 'success') {
        $('#deleteCategoryStatus').html(shortSuccessText('删除分类成功！'));
        setTimeout(function () {
            $('#deleteCategoryDialog').modal('hide');
        }, 1000);
        $('#category-' + id).remove();
    }
    else {
        $('#btnDeleteCategory').removeAttr('disabled');
        if (data.msg)
            $('#deleteCategoryStatus').html(shortFailText(data.msg));
        else if (status != 'success')
            $('#deleteCategoryStatus').html(shortFailText(status));
        else
            $('#deleteCategoryStatus').html(shortFailText('发生未知错误'));
    }
}

function addBookToCategoryCallback(data, status) {
    $('#addBookToCategoryStatus').removeClass('hidden');
    if (data.result == 'success') {
        $('#addBookToCategoryStatus').html(shortSuccessText('添加成功！'));
        setTimeout(function () {
            $('#addBookToCategoryDialog').modal('hide');
        }, 1000);
    }
    else {
        $('#btnAddBookToCategory').removeAttr('disabled');
        if (data.msg)
            $('#addBookToCategoryStatus').html(shortFailText(data.msg));
        else if (status != 'success')
            $('#addBookToCategoryStatus').html(shortFailText(status));
        else
            $('#addBookToCategoryStatus').html(shortFailText('发生未知错误'));
    }
}

function deleteBookFromCategoryCallback(data, status, id) {
    $('#categoryDetailStatus').removeClass('hidden');
    if (data.result == 'success') {
        $('#categoryDetailStatus').html(shortSuccessText('删除成功！'));
        setTimeout(function () {
            $('#categoryDetailStatus').addClass('hidden');
        }, 1000);
        $('#bc-' + id).remove();
    }
    else {
        if (data.msg)
            $('#categoryDetailStatus').html(shortFailText(data.msg));
        else if (status != 'success')
            $('#categoryDetailStatus').html(shortFailText(status));
        else
            $('#categoryDetailStatus').html(shortFailText('发生未知错误'));
    }
} 

$(document).ready(function () {
    $.get(allCategoriesAPI, function (data, status) {
        var categoryCount = data.length;
        for (var i = 0; i < categoryCount; ++i) {
            addCategoryRow(data[i][0], data[i][1], data[i][2], data[i][3]);
        }
        $('.alert-info').alert('close');
    }).fail(function (xhr, status, error) {
        $('.alert').remove();
        $('h1').after(errorAlertHTML('加载分类信息失败！<br>错误：' + error));
    });
});

$('#addCategoryDialog').on('show.bs.modal', function () {
    $('#addCategoryStatus').addClass('hidden');
    $('#btnAddCategory').removeAttr('disabled');
});

$('#addCategoryDialog').on('shown.bs.modal', function () {
    $('#addCategoryName').focus();
});

$('#addCategoryName').keydown(function (event) {
    if (event.keyCode == 13)
        return false;
});

$('#btnAddCategory').click(function () {
    $('#btnAddCategory').attr('disabled', 'disabled');
    var newName = $('#addCategoryName').val();
    var postData = {'name': newName};
    $.post(addCategoryAPI, postData, function (data, status) {
        addCategoryCallback(data, status, newName);
    }).fail(function (xhr, status, error) {
        addCategoryCallback(tryJSONParse(xhr.responseText), error, newName);
    });
});

$('#updateCategoryDialog').on('show.bs.modal', function (event) {
    var updateId = $(event.relatedTarget).data('id');
    var updateName = $('#category-' + updateId).children().first().next().text();
    $('#updateCategoryDialogLabel').text('修改分类名称 - 编号：' + updateId);
    $('#updateCategoryId').val(updateId);
    $('#updateCategoryName').val(updateName);
    $('#updateCategoryStatus').addClass('hidden');
    $('#btnUpdateCategory').removeAttr('disabled');
});

$('#updateCategoryDialog').on('shown.bs.modal', function () {
    $('#updateCategoryName').focus();
});

$('#updateCategoryName').keydown(function (event) {
    if (event.keyCode == 13)
        return false;
});

$('#btnUpdateCategory').click(function () {
    $('#btnUpdateCategory').attr('disabled', 'disabled');
    var id = $('#updateCategoryId').val();
    var newName = $('#updateCategoryName').val();
    var postData = {
        'id': id,
        'name': newName
    };
    $.post(updateCategoryAPI, postData, function (data, status) {
        updateCategoryCallback(data, status, id, newName);
    }).fail(function (xhr, status, error) {
        updateCategoryCallback(tryJSONParse(xhr.responseText), error, id, newName);
    });
});

$('#deleteCategoryDialog').on('show.bs.modal', function (event) {
    var deleteId = $(event.relatedTarget).data('id');
    var deleteName = $('#category-' + deleteId).children().first().next().text();
    $('#deleteCategoryId').val(deleteId);
    $('#deleteCategoryText').html('您确实要删除编号为 <strong>' + deleteId + '</strong> 的分类 <strong>' + escapeHtml(deleteName) + '</strong> 吗？');
    $('#deleteCategoryStatus').addClass('hidden');
    $('#btnDeleteCategory').removeAttr('disabled');
});

$('#btnDeleteCategory').click(function () {
    $('#btnDeleteCategory').attr('disabled', 'disabled');
    var id = $('#deleteCategoryId').val();
    var postData = {'id': id};
    $.post(deleteCategoryAPI, postData, function (data, status) {
        deleteCategoryCallback(data, status, id);
    }).fail(function (xhr, status, error) {
        deleteCategoryCallback(tryJSONParse(xhr.responseText), error, id);
    });
});

$('#categoryDetailDialog').on('show.bs.modal', function (event) {
    var detailId = $(event.relatedTarget).data('id');
    var categoryName = $('#category-' + detailId).children().first().next().text();
    $('#categoryDetailDialogLabel').html('<strong>' + escapeHtml(categoryName) + '</strong> 分类中的书籍');
    $('#categoryDetailStatus').removeClass('hidden');
    $('#categoryDetailStatus').html(shortProcessingText('正在加载分类详情...'));
    $detailTable.empty();
    $.get(categoryDetailAPI + '?id=' + detailId, function (data, status) {
        $('#categoryDetailStatus').addClass('hidden');
        var bcCount = data.length;
        for (var i = 0; i < bcCount; ++i) {
            addCategoryDetailRow(data[i][0], data[i][1], data[i][2]);
        }
    }).fail(function (xhr, status, error) {
        $('#categoryDetailStatus').html(shortFailText('加载分类详情失败！错误：' + error));
    });
});

$('#addBookToCategoryDialog').on('show.bs.modal', function (event) {
    var categoryId = $(event.relatedTarget).data('id');
    var categoryName = $('#category-' + categoryId).children().first().next().text();
    $('#addBookToCategoryCategoryId').val(categoryId);
    $('#addBookToCategoryBookId').val('');
    $('#addBookToCategoryDialogLabel').html('添加书籍到 <strong>' + escapeHtml(categoryName) + '</strong> 分类');
    $('#addBookToCategoryStatus').addClass('hidden');
    $('#btnAddBookToCategory').removeAttr('disabled');
});

$('#addBookToCategoryDialog').on('shown.bs.modal', function () {
    $('#addBookToCategoryBookId').focus();
});

$('#btnAddBookToCategory').click(function () {
    $('#btnAddBookToCategory').attr('disabled', 'disabled');
    var id = $('#addBookToCategoryCategoryId').val();
    var bookId = $('#addBookToCategoryBookId').val();
    var postData = {'id': id, 'bookId': bookId};
    $.post(addBookToCategoryAPI, postData, addBookToCategoryCallback).fail(function (xhr, status, error) {
        addBookToCategoryCallback(tryJSONParse(xhr.responseText), error);
    });
});

$(document).on('click', '.delete-bc', function () { // Delegated event!
    var deleteBCId = $(this).attr('data-id');
    var deleteBCBookName = $('#bc-' + deleteBCId).children().first().next().text();
    if (!confirm('确实要从当前分类中删除书籍 ' + deleteBCBookName + ' 吗？'))
        return;
    var postData = {'id': deleteBCId};
    $.post(deleteBookFromCategoryAPI, postData, function (data, status) {
        deleteBookFromCategoryCallback(data, status, deleteBCId);
    }).fail(function (xhr, status, error) {
        deleteBookFromCategoryCallback(tryJSONParse(xhr.responseText), error, deleteBCId);
    });
});