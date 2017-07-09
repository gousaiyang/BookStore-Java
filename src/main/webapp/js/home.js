$container = $('#bookContainer');

var allBooksAPI = contextPath + '/api/books/all';
var searchBookAPI = contextPath + '/api/books/search';
var bookDetailAPI = contextPath + '/api/books/detail';
var addToCartAPI = contextPath + '/api/cart/add';

function addBookBlock(id, name, image, price) {
    $container.append('<div class="col-xs-6 col-sm-4 col-md-3" id="book-' + id + '"> \
            <div class="thumbnail"> \
                <img class="book-image" src="' + showBookImage(image) + '"> \
                <div class="caption"> \
                    <h4>' + escapeHtml(name) + '</h4> \
                    <p>&#65509;' + parseFloat(price).toFixed(2) + '</p> \
                    <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#detailDialog" data-id="' + id + '">查看详情</button> \
                </div> \
            </div> \
        </div>');
}

function addToCartCallback(data, status) {
    $('#detailStatus').removeClass('hidden');
    if (data.result == 'success') {
        $('#detailStatus').html(shortSuccessText('成功添加至购物车！', true));
        setTimeout(function () {
            $('#detailDialog').modal('hide');
        }, 1000);
        updateCartCount();
    }
    else {
        $('#btnAddToCart').removeAttr('disabled');
        if (data.msg)
            $('#detailStatus').html(shortFailText(data.msg, true));
        else if (status != 'success')
            $('#detailStatus').html(shortFailText(status, true));
        else
            $('#detailStatus').html(shortFailText('发生未知错误', true));
    }
}

$(document).ready(function () {
    updateCartCount();
    $.get(allBooksAPI, function (data, status) {
        var bookCount = data.length;
        for (var i = 0; i < bookCount; ++i) {
            addBookBlock(data[i][0], data[i][1], data[i][2], data[i][3] / 100.0);
        }
        $('.alert-info').alert('close');
    }).fail(function (xhr, status, error) {
        $('.alert').remove();
        $('#bookMainContainer').append(errorAlertHTML('加载书籍信息失败！<br>错误：' + error));
    });
});

function doSearch() {
    var category = $('#selectCategory').val();
    var keyword = $('#searchBookInput').val();
    $.get(searchBookAPI, {'category': category, 'keyword': keyword}, function (data, status) {
        $container.empty();
        var bookCount = data.length;
        if (bookCount > 0) {
            for (var i = 0; i < bookCount; ++i) {
                addBookBlock(data[i][0], data[i][1], data[i][2], data[i][3] / 100.0);
            }
        }
        else {
            $container.append('无搜索结果');
        }
    }).fail(function (xhr, status, error) {
        $container.empty();
        $container.append('无搜索结果');
    });
}

$('#searchBookInput').keydown(function (event) {
    if (event.keyCode == 13)
        return false;
});

$('#selectCategory').change(doSearch);

$('#searchBookInput').on('input', function (event) {
    doSearch();
});

$('#detailDialog').on('show.bs.modal', function (event) {
    var detailId = $(event.relatedTarget).data('id');
    $('#bookDetailId').val(detailId);
    $('#bookDetailImage').attr('src', defaultBookImage);
    $('#bookDetailName').text('');
    $('#bookDetailAuthor').text('');
    $('#bookDetailPress').text('');
    $('#bookDetailPrice').text('');
    $('#bookDetailCategories').text('');
    $('#bookDetailDescription').text('');
    $('#detailStatus').removeClass('hidden');
    $('#detailStatus').html(shortProcessingText('正在加载书籍详情...', true));
    $('#addQuantity').val(1);
    $('#btnAddToCart').attr('disabled', 'disabled');
    $.get(bookDetailAPI + '?id=' + detailId, function (data, status) {
        $('#bookDetailImage').attr('src', showBookImage(data.image));
        $('#bookDetailName').text(data.name);
        $('#bookDetailAuthor').text('作者：' + (isNotEmptyString(data.author) ? data.author : '暂无作者信息'));
        $('#bookDetailPress').text('出版社：' + (isNotEmptyString(data.press) ? data.press : '暂无出版社信息'));
        $('#bookDetailPrice').html('&#65509;' + (data.price / 100.0).toFixed(2));
        $('#bookDetailDescription').text(data.description);
        $('#detailStatus').addClass('hidden');
        $('#bookDetailCategories').text('分类：');
        var categoryCount = data.categories.length;
        if (categoryCount > 0) {
            for (var i = 0; i < categoryCount; ++i)
                $('#bookDetailCategories').append('<span class="label label-success large-label">' + escapeHtml(data.categories[i]) + '</span> ');
        } else {
            $('#bookDetailCategories').append('暂无分类信息');
        }
        $('#btnAddToCart').removeAttr('disabled');
    }).fail(function (xhr, status, error) {
        $('#detailStatus').html(shortFailText('加载书籍详情失败！错误：' + error, true));
    });
});

$('#detailDialog').on('shown.bs.modal', function (event) {
    $('#addQuantity').focus();
});

$('#addQuantity').keydown(function (event) {
    if (event.keyCode == 13)
        return false;
});

$('#btnAddToCart').click(function () {
    $('#btnAddToCart').attr('disabled', 'disabled');
    var bookId = $('#bookDetailId').val();
    var quantity = $('#addQuantity').val();
    var postData = {
        'bookId': bookId,
        'quantity': quantity
    };
    $.post(addToCartAPI, postData, addToCartCallback).fail(function (xhr, status, error) {
        addToCartCallback(tryJSONParse(xhr.responseText), error);
    });
});
