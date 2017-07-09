var cartCountAPI = contextPath + '/api/cart/count';

function updateCartCount() {
    if (isLoggedIn()) {
        $.get(cartCountAPI, function (data) {
            if (data.result == 'success')
                $('#cartCount').text(data.param == 0 ? '' : data.param);
        });
    }
}