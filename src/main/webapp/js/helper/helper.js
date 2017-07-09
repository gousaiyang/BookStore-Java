var contextPath = $('#contextPath').val();

var defaultBookImage = contextPath + '/img/default/book.png';
var defaultUserAvatar = contextPath + '/img/default/user.png';
var uploadedImage = function (filename) {
    return contextPath + '/img/upload/' + filename;
}

function isNotEmptyString(s) {
    return typeof(s) == 'string' && s != '';
}

var showBookImage = function (img) {
    return isNotEmptyString(img) ? uploadedImage(img) : defaultBookImage;
}

var showUserAvatar = function (img) {
    return isNotEmptyString(img) ? uploadedImage(img) : defaultUserAvatar;
}

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

function parseIntEx(s) {
    if (typeof(s) == 'number')
        return s;
    if (typeof(s) == 'boolean')
        return s ? 1 : 0;
    var index = ['false', 'true'].indexOf(s.toLowerCase());
    if (index >= 0)
        return index;
    return parseInt(s);
}

function tryJSONParse(s) {
    try {
        return JSON.parse(s);
    }
    catch (e) {
        return s;
    }
}
