var entityMap = {
	'&': '&amp;',
	'<': '&lt;',
	'>': '&gt;',
	'"': '&quot;',
	"'": '&#39;',
	'/': '&#x2F;',
	'`': '&#x60;',
	'=': '&#x3D;'
};

function escapeHtml(string) {
	return String(string).replace(/[&<>"'`=\/]/g, function (s) {
		   return entityMap[s];
	});
}

var alertFailHTML = '<div class="alert alert-danger alert-dismissable" role="alert"><span class="glyphicon glyphicon-ban-circle"></span>&nbsp;';
var alertDismissHTML = '<button type="button" class="close" data-dismiss="alert">&times;</button></div>';
var alertSuccessHTML = function(style) {
    return '<div class="alert alert-' + style + ' alert-dismissable fade in" role="alert"><span class="glyphicon glyphicon-ok"></span>&nbsp;';
};

function parseIntEx(s) {
	if (typeof s == 'number')
		return s;
	if (typeof s == 'boolean')
		return s ? 1 : 0;
	var index = ['false', 'true'].indexOf(s.toLowerCase());
	if (index >= 0)
		return index;
	return parseInt(s);
}
