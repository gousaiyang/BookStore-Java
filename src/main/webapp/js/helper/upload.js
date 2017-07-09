var uploadImageAPI = contextPath + '/api/upload';
var maxFileSize = 2048;
var imageExtensions = ['jpg', 'jpeg', 'png', 'bmp' ,'gif'];
var supportImgHTML = '<span class="glyphicon glyphicon-info-sign"></span> 支持 JPG、PNG、BMP、GIF 图片格式，大小不超过 2M';

function uploadCallback(msgElement, inputField, imgShow, defaultImg, response, statusText) {
    if (response.result == 'success') {
        msgElement.html(shortSuccessText('上传成功'));
        inputField.val(response.param);
        imgShow.attr('src', uploadedImage(response.param));
    } else {
        inputField.val('');
        imgShow.attr('src', defaultImg);
        msgElement.html(shortFailText(response.msg || statusText || '上传图片失败'));
    }
}
