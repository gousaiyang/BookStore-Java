var shortProcessingText = function (text, is12) {
    return '<div class="' + (is12 ? 'col-md-12 ' : '') + 'text-info"><span class="glyphicon glyphicon-time"></span> ' + escapeHtml(text) + '</div>';
}
var shortSuccessText = function (text, is12) {
    return '<div class="' + (is12 ? 'col-md-12 ' : '') + 'text-success"><span class="glyphicon glyphicon-ok"></span> ' + escapeHtml(text) + '</div>';
}
var shortFailText = function (text, is12) {
    return '<div class="' + (is12 ? 'col-md-12 ' : '') + 'text-danger"><span class="glyphicon glyphicon-ban-circle"></span> ' + escapeHtml(text) + '</div>';
}

var alertFailHTML = '<div class="alert alert-danger alert-dismissable fade in" role="alert"><span class="glyphicon glyphicon-ban-circle"></span> ';
var alertDismissHTML = '<button type="button" class="close" data-dismiss="alert">&times;</button></div>';

var errorAlertHTML = function (text) {
    return alertFailHTML + escapeHtml(text) + alertDismissHTML;
}
