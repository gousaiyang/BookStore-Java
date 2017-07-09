var cartCountAPI = contextPath + '/api/cart/count';

function updateCartCount() {
    $.get(cartCountAPI, function (data) {
        if (data.result == 'success')
            $('#cartCount').text(data.param == 0 ? '' : data.param);
    });
}