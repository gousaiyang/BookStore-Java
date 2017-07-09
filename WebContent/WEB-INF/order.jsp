<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>

<jsp:include page="./layout/page_head.jsp" />

<jsp:include page="./layout/content_navbar.jsp" />

<div class="container">
    <h1>订单管理</h1>
    <div class="alert alert-info fade in" role="alert">正在加载订单信息...</div>
    <div class="table-responsive">
        <table class="table table-hover">
            <thead>
                <tr>
                    <th>编号</th>
                    <th>发起用户</th>
                    <th>总数量</th>
                    <th>总价</th>
                    <th>状态</th>
                    <th>创建时间</th>
                    <th>修改时间</th>
                    <th>详情</th>
                </tr>
            </thead>
            <tbody id="mainTable">
            <!-- Table data will be loaded by js. -->
            </tbody>
        </table>
    </div>
</div>

<div class="modal fade" id="detailDialog" tabindex="-1" role="dialog" aria-labelledby="detailDialogLabel">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="detailDialogLabel">订单详情</h4>
            </div>
            <div class="modal-body">
                <div class="row" id="orderSummaryText"></div>
                <hr>
                <div class="table-responsive">
                    <table class="table table-hover">
                        <thead>
                            <tr>
                                <th>项目编号</th>
                                <th>书籍</th>
                                <th>数量</th>
                                <th>小计</th>
                                <th>创建时间</th>
                                <th>修改时间</th>
                            </tr>
                        </thead>
                        <tbody id="detailTable">
                        <!-- Table data will be loaded by js. -->
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">返回</button>
            </div>
        </div>
    </div>
</div>

<jsp:include page="./layout/content_footer.jsp" />

<jsp:include page="./layout/common_js.jsp" />

<script>

var $mainTable = $('#mainTable');
var $detailTable = $('#detailTable');
var payStatus = ['未支付', '已支付'];

function addOrderRow(id, username, totalQuantity, totalPrice, isPaid, createTime, updateTime) {
    $mainTable.append('<tr id="order-'+ id + '"> \
             <th scope="row" class="col-md-1">' + id + '</th> \
             <td class="col-md-2">' + escapeHtml(username) + '</td> \
             <td class="col-md-1">' + totalQuantity + '</td> \
             <td class="col-md-2">' + parseFloat(totalPrice).toFixed(2) + '</td> \
             <td class="col-md-1">' + payStatus[isPaid ? 1 : 0] + '</td> \
             <td class="col-md-2">' + createTime + '</td> \
             <td class="col-md-2">' + updateTime + '</td> \
             <td class="col-md-1">  \
                 <button type="button" class="btn btn-info btn-sm" data-toggle="modal" data-target="#detailDialog" data-id="' + id + '">  \
                     <span class="glyphicon glyphicon-option-horizontal"></span>  \
                 </button>  \
             </td>  \
         </tr>');
}

function addOrderDetailRow(id, bookId, bookName, quantity, subtotalPrice, createTime, updateTime) {
    $detailTable.append('<tr> \
             <th scope="row" class="col-md-1">' + id + '</th> \
             <td class="col-md-4">' + escapeHtml(bookId + '(' + bookName + ')') + '</td> \
             <td class="col-md-1">' + quantity + '</td> \
             <td class="col-md-2">' + parseFloat(subtotalPrice).toFixed(2) + '</td> \
             <td class="col-md-2">' + createTime + '</td> \
             <td class="col-md-2">' + updateTime + '</td> \
         </tr>');
}

$('document').ready(function () {
    $.get('/BookStore/allorders', function (data, status) {
        var orderCount = data.length;
        for (var i = 0; i < orderCount; ++i) {
            addOrderRow(data[i][0], data[i][1], data[i][2], data[i][3] / 100.0, data[i][4], data[i][5], data[i][6]);
        }
        $('.alert-info').alert('close');
    }).fail(function (xhr, errorText, errorType) {
        $('.alert').remove();
        $('h1').after(alertFailHTML + '加载订单信息失败！<br>错误：' + errorType + '，请联系管理员。' + alertDismissHTML);
    });
});

$('#detailDialog').on('show.bs.modal', function (event) {
    var detailId = $(event.relatedTarget).data('id');
    var username = $('#order-' + detailId).children().first().next().text();
    var isPaid = $('#order-' + detailId).children().first().next().next().next().next().text();
    $('#detailDialogLabel').text('订单详情 - 编号：' + detailId);
    $('#orderSummaryText').html('<div class="col-md-12 text-info">正在加载订单详情...</div>');
    $detailTable.empty();
    $.get('/BookStore/orderdetail?id=' + detailId, function (data, status) {
        $('#orderSummaryText').html('<div class="col-md-6">发起用户：' + username + '</div>  \
            <div class="col-md-6 text-right">状态：' + isPaid + '</div>');
        var orderItemCount = data.length;
        for (var i = 0; i < orderItemCount; ++i) {
            addOrderDetailRow(data[i][0], data[i][1], data[i][2], data[i][3], data[i][4] / 100.0, data[i][5], data[i][6]);
        }
    }).fail(function (xhr, errorText, errorType) {
        $('.alert').remove();
        $('h1').after(alertFailHTML + '加载订单详情失败！<br>错误：' + errorType + '，请联系管理员。' + alertDismissHTML);
        $('#orderSummaryText').html('<div class="col-md-12 text-danger">加载订单详情失败！</div>');
    });
});

</script>

<jsp:include page="./layout/page_end.jsp" />
