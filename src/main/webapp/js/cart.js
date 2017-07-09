$table = $('tbody');

var cartDetailAPI = contextPath + '/api/cart/detail';
var cartUpdateAPI = contextPath + '/api/cart/update';
var cartDeleteAPI = contextPath + '/api/cart/delete';
var cartSummaryAPI = contextPath + '/api/cart/summary';
var cartPayAPI = contextPath + '/api/cart/pay';

function addCartRow(id, name, price, quantity, subtotalPrice) {
    $table.append('<tr id="item-' + id + '">  \
             <td class="col-md-4">' + escapeHtml(name) + '</td>  \
             <td class="col-md-2">' + parseFloat(price).toFixed(2) + '</td>  \
             <td class="col-md-2">' + quantity + '</td>  \
             <td class="col-md-2 subtotal">' + parseFloat(subtotalPrice).toFixed(2) + '</td>  \
             <td class="col-md-2">  \
                 <button type="button" class="btn btn-info btn-sm" data-toggle="modal" data-target="#updateDialog" data-id="' + id + '">  \
                     <span class="glyphicon glyphicon-edit"></span>  \
                 </button> \
                 <button type="button" class="btn btn-danger btn-sm" data-toggle="modal" data-target="#deleteDialog" data-id="' + id + '">  \
                     <span class="glyphicon glyphicon-trash"></span>  \
                 </button>  \
             </td>  \
         </tr>');
}

function updateTotalPrice() {
    var totalPrice = 0.0;
    $('.subtotal').each(function () {
        totalPrice += parseFloat($(this).text());
    });
    $('#totalPriceText').html('总价：&#65509;' + totalPrice.toFixed(2));
}

function cartUpdateCallback(data, status, id, newQuantity) {
    $('#updateStatus').removeClass('hidden');
    if (data.result == 'success') {
        $('#updateStatus').html(shortSuccessText('修改数量成功！'));
        setTimeout(function () {
            $('#updateDialog').modal('hide');
        }, 1000);
        var price = $('#item-' + id).children().first().next().text();
        $('#item-' + id).children().first().next().next().text(newQuantity);
        $('#item-' + id).children().first().next().next().next().text((parseFloat(price) * parseInt(newQuantity)).toFixed(2));
        updateTotalPrice();
    }
    else {
        if (data.msg)
            $('#updateStatus').html(shortFailText(data.msg));
        else if (status != 'success')
            $('#updateStatus').html(shortFailText(status));
        else
            $('#updateStatus').html(shortFailText('发生未知错误'));
    }
}

function cartDeleteCallback(data, status, id) {
    $('#deleteItemStatus').removeClass('hidden');
    if (data.result == 'success') {
        $('#deleteItemStatus').html(shortSuccessText('删除购物车条目成功！'));
        setTimeout(function () {
            $('#deleteDialog').modal('hide');
            updateCartCount();
        }, 1000);
        $('#item-' + id).remove();
        updateTotalPrice();
    }
    else {
        $('#btnDeleteItem').removeAttr('disabled');
        if (data.msg)
            $('#deleteItemStatus').html(shortFailText(data.msg));
        else if (status != 'success')
            $('#deleteItemStatus').html(shortFailText(status));
        else
            $('#deleteItemStatus').html(shortFailText('发生未知错误'));
    }
}

function payCallback(data, status) {
    $('#payStatus').removeClass('hidden');
    if (data.result == 'success') {
        $('#payStatus').html(shortSuccessText('支付成功！'));
        setTimeout(function () {
            window.location.href = contextPath + '/orders';
        }, 1000);
    }
    else {
        $('#btnPay').removeAttr('disabled');
        if (data.msg)
            $('#payStatus').html(shortFailText(data.msg));
        else if (status != 'success')
            $('#payStatus').html(shortFailText(status));
        else
            $('#payStatus').html(shortFailText('发生未知错误'));
    }
}

$(document).ready(function () {
    updateCartCount();
    $.get(cartDetailAPI, function (data, status) {
        var cartDetailCount = data.length;
        for (var i = 0; i < cartDetailCount; ++i) {
            addCartRow(data[i][0], data[i][1], data[i][2] / 100.0, data[i][3], data[i][4] / 100.0);
        }
        $('.alert-info').alert('close');
        updateTotalPrice();
    }).fail(function (xhr, status, error) {
        $('.alert').remove();
        $('h1').after(errorAlertHTML('加载购物车内容失败！<br>错误：' + error));
    });
});

$('#updateDialog').on('show.bs.modal', function (event) {
    var updateItemId = $(event.relatedTarget).data('id');
    var updateItemBookName = $('#item-' + updateItemId).children().first().text();
    var updateItemQuantity = $('#item-' + updateItemId).children().first().next().next().text();
    $('#updateItemId').val(updateItemId);
    $('#updateItemBookName').text(updateItemBookName);
    $('#updateItemQuantity').val(updateItemQuantity);
    $('#updateStatus').addClass('hidden');
});

$('#updateDialog').on('shown.bs.modal', function () {
    $('#updateItemQuantity').focus();
});

function doUpdate() {
    var id = $('#updateItemId').val();
    var newQuantity = $('#updateItemQuantity').val();
    var postData = {
        'itemId': id,
        'quantity': newQuantity
    };
    $.post(cartUpdateAPI, postData, function (data, status) {
        cartUpdateCallback(data, status, id, newQuantity);
    }).fail(function (xhr, status, error) {
        cartUpdateCallback(tryJSONParse(xhr.responseText), error, id, newQuantity);
    });
}

$('#btnUpdate').click(doUpdate);
$('#updateItemQuantity').keyup(function (event) {
    if (event.keyCode == 13)
        doUpdate();
});

$('#deleteDialog').on('show.bs.modal', function (event) {
    var deleteItemId = $(event.relatedTarget).data('id');
    var deleteBookName = $('#item-' + deleteItemId).children().first().text();
    var deleteQuantity = $('#item-' + deleteItemId).children().first().next().next().text();
    $('#deleteItemId').val(deleteItemId);
    $('#deleteText').html('您确实要删除购买 ' + deleteQuantity + ' 本 <strong>' + escapeHtml(deleteBookName) + '</strong> 的购物车条目吗？');
    $('#deleteItemStatus').addClass('hidden');
    $('#btnDeleteItem').removeAttr('disabled');
});

$('#btnDeleteItem').click(function () {
    $('#btnDeleteItem').attr('disabled', 'disabled');
    var id = $('#deleteItemId').val();
    var postData = {'itemId': id};
    $.post(cartDeleteAPI, postData, function (data, status) {
        cartDeleteCallback(data, status, id);
    }).fail(function (xhr, status, error) {
        cartDeleteCallback(tryJSONParse(xhr.responseText), error, id);
    });
});

$('#payDialog').on('show.bs.modal', function () {
    $('#payTotalItems').text('');
    $('#payTotalQuantity').text('');
    $('#payTotalPrice').text('');
    $('#payStatus').removeClass('hidden');
    $('#payStatus').html(shortProcessingText('正在加载购物车信息...'));
    $('#btnPay').attr('disabled', 'disabled');
    $.get(cartSummaryAPI, function (data, status) {
        $('#payTotalItems').text(data[0]);
        $('#payTotalQuantity').text(data[1] || '0');
        $('#payTotalPrice').html('&#65509;' + (data[2] / 100.0).toFixed(2));
        $('#payStatus').addClass('hidden');
        $('#btnPay').removeAttr('disabled');
    }).fail(function (xhr, status, error) {
        $('#payStatus').html(shortFailText('加载购物车信息失败！错误：' + error));
    });
});

$('#btnPay').click(function () {
    $('#btnPay').attr('disabled', 'disabled');
    $.post(cartPayAPI, {}, payCallback).fail(function (xhr, status, error) {
        payCallback(tryJSONParse(xhr.responseText), error);
    });
});