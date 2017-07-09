var $mainTable = $('#mainTable');
var $detailTable = $('#detailTable');
var payStatus = ['未支付', '已支付'];

var allOrdersAdminAPI = contextPath + '/admin/api/orders/all';
var orderDetailAdminAPI = contextPath + '/admin/api/orders/detail';

function addOrderRow(id, username, itemCount, totalQuantity, totalPrice, isPaid, createTime, updateTime) {
    $mainTable.append('<tr id="order-' + id + '"> \
             <th scope="row" class="col-md-1">' + id + '</th> \
             <td class="col-md-2">' + escapeHtml(username) + '</td> \
             <td class="col-md-1">' + itemCount + '</td> \
             <td class="col-md-1">' + totalQuantity + '</td> \
             <td class="col-md-1">' + parseFloat(totalPrice).toFixed(2) + '</td> \
             <td class="col-md-1">' + payStatus[isPaid ? 1 : 0] + '</td> \
             <td class="col-md-2">' + createTime + '</td> \
             <td class="col-md-2">' + updateTime + '</td> \
             <td class="col-md-1">  \
                 <button type="button" class="btn btn-primary btn-sm" data-toggle="modal" data-target="#detailDialog" data-id="' + id + '">  \
                     <span class="glyphicon glyphicon-option-horizontal"></span>  \
                 </button>  \
             </td>  \
         </tr>');
}

function addOrderDetailRow(id, bookId, bookName, price, quantity, subtotalPrice, createTime, updateTime) {
    $detailTable.append('<tr> \
             <th scope="row" class="col-md-1">' + id + '</th> \
             <td class="col-md-4">' + escapeHtml(bookId + '(' + bookName + ')') + '</td> \
             <td class="col-md-1">' + parseFloat(price).toFixed(2) + '</td> \
             <td class="col-md-1">' + quantity + '</td> \
             <td class="col-md-1">' + parseFloat(subtotalPrice).toFixed(2) + '</td> \
             <td class="col-md-2">' + createTime + '</td> \
             <td class="col-md-2">' + updateTime + '</td> \
         </tr>');
}

$(document).ready(function () {
    $.get(allOrdersAdminAPI, function (data, status) {
        data.sort(function (a, b) {
            return a[0] - b[0];
        });
        var orderCount = data.length;
        for (var i = 0; i < orderCount; ++i) {
            addOrderRow(data[i][0], data[i][1], data[i][2], data[i][3], data[i][4] / 100.0, data[i][5], data[i][6], data[i][7]);
        }
        $('.alert-info').alert('close');
    }).fail(function (xhr, status, error) {
        $('.alert').remove();
        $('h1').after(errorAlertHTML('加载订单信息失败！<br>错误：' + error));
    });
});

$('#detailDialog').on('show.bs.modal', function (event) {
    var detailId = $(event.relatedTarget).data('id');
    var username = $('#order-' + detailId).children().first().next().text();
    var isPaid = $('#order-' + detailId).children().first().next().next().next().next().next().text();
    $('#detailDialogLabel').text('订单详情 - 编号：' + detailId);
    $('#orderSummaryText').html(shortProcessingText('正在加载订单详情...', true));
    $detailTable.empty();
    $.get(orderDetailAdminAPI + '?id=' + detailId, function (data, status) {
        $('#orderSummaryText').html('<div class="col-md-6"><span class="glyphicon glyphicon-user"></span> 发起用户：' + username + '</div>  \
            <div class="col-md-6 text-right"><span class="glyphicon glyphicon-list-alt"></span> 状态：' + isPaid + '</div>');
        var orderItemCount = data.length;
        for (var i = 0; i < orderItemCount; ++i) {
            addOrderDetailRow(data[i][0], data[i][1], data[i][2], data[i][3] / 100.0, data[i][4], data[i][5] / 100.0, data[i][6], data[i][7]);
        }
    }).fail(function (xhr, status, error) {
        $('#orderSummaryText').html(shortFailText('加载订单详情失败！错误：' + error, true));
    });
});
