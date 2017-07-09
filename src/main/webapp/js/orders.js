var $mainTable = $('#mainTable');
var $detailTable = $('#detailTable');

var allOrdersAPI = contextPath + '/api/orders/all';
var orderDetailAPI = contextPath + '/api/orders/detail';
var deleteOrderAPI = contextPath + '/api/orders/delete';

function addOrderRow(id, itemCount, totalQuantity, totalPrice, createTime, updateTime) {
    $mainTable.append('<tr id="order-' + id + '"> \
             <th scope="row" class="col-md-1">' + id + '</th> \
             <td class="col-md-2">' + itemCount + '</td> \
             <td class="col-md-2">' + totalQuantity + '</td> \
             <td class="col-md-2">' + parseFloat(totalPrice).toFixed(2) + '</td> \
             <td class="col-md-2">' + createTime + '</td> \
             <td class="col-md-2">' + updateTime + '</td> \
             <td class="col-md-1">  \
                 <button type="button" class="btn btn-primary btn-sm" data-toggle="modal" data-target="#detailDialog" data-id="' + id + '">  \
                     <span class="glyphicon glyphicon-option-horizontal"></span>  \
                 </button>  \
                 <button type="button" class="btn btn-danger btn-sm" data-toggle="modal" data-target="#deleteDialog" data-id="' + id + '">  \
                     <span class="glyphicon glyphicon-trash"></span>  \
                 </button>  \
             </td>  \
         </tr>');
}

function addOrderDetailRow(bookName, price, quantity, subtotalPrice) {
    $detailTable.append('<tr> \
             <td class="col-md-6">' + escapeHtml(bookName) + '</td> \
             <td class="col-md-2">' + parseFloat(price).toFixed(2) + '</td> \
             <td class="col-md-2">' + quantity + '</td> \
             <td class="col-md-2">' + parseFloat(subtotalPrice).toFixed(2) + '</td> \
         </tr>');
}

function deleteOrderCallback(data, status, id) {
    $('#deleteStatus').removeClass('hidden');
    if (data.result == 'success') {
        $('#deleteStatus').html(shortSuccessText('删除订单记录成功！'));
        setTimeout(function () {
            $('#deleteDialog').modal('hide');
        }, 1000);
        $('#order-' + id).remove();
    }
    else {
        $('#btnDeleteOrder').removeAttr('disabled');
        if (data.msg)
            $('#deleteStatus').html(shortFailText(data.msg));
        else if (status != 'success')
            $('#deleteStatus').html(shortFailText(status));
        else
            $('#deleteStatus').html(shortFailText('发生未知错误'));
    }
}

$(document).ready(function () {
    updateCartCount();
    $.get(allOrdersAPI, function (data, status) {
        var orderCount = data.length;
        for (var i = 0; i < orderCount; ++i) {
            addOrderRow(data[i][0], data[i][1], data[i][2], data[i][3] / 100.0, data[i][4], data[i][5]);
        }
        $('.alert-info').alert('close');
    }).fail(function (xhr, status, error) {
        $('.alert').remove();
        $('h1').after(errorAlertHTML('加载订单信息失败！<br>错误：' + error));
    });
});

$('#detailDialog').on('show.bs.modal', function (event) {
    var detailId = $(event.relatedTarget).data('id');
    $('#detailDialogLabel').text('订单详情 - 编号：' + detailId);
    $('#detailStatus').removeClass('hidden');
    $('#detailStatus').html(shortProcessingText('正在加载订单详情...'));
    $detailTable.empty();
    $.get(orderDetailAPI + '?id=' + detailId, function (data, status) {
        $('#detailStatus').addClass('hidden');
        var orderItemCount = data.length;
        for (var i = 0; i < orderItemCount; ++i) {
            addOrderDetailRow(data[i][0], data[i][1] / 100.0, data[i][2], data[i][3] / 100.0);
        }
    }).fail(function (xhr, status, error) {
        $('#detailStatus').html(shortFailText('加载订单详情失败！错误：' + error));
    });
});

$('#deleteDialog').on('show.bs.modal', function (event) {
    var deleteId = $(event.relatedTarget).data('id');
    $('#deleteOrderId').val(deleteId);
    $('#deleteStatus').addClass('hidden');
    $('#btnDeleteOrder').removeAttr('disabled');
});

$('#btnDeleteOrder').click(function () {
    $('#btnDeleteOrder').attr('disabled', 'disabled');
    var id = $('#deleteOrderId').val();
    var postData = {'id': id};
    $.post(deleteOrderAPI, postData, function (data, status) {
        deleteOrderCallback(data, status, id);
    }).fail(function (xhr, status, error) {
        deleteOrderCallback(tryJSONParse(xhr.responseText), error, id);
    });
});