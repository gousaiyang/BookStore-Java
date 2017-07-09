<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>

<div class="modal fade" id="myProfileDialog" tabindex="-1" role="dialog" aria-labelledby="myProfileDialogLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myProfileDialogLabel">我的个人信息</h4>
            </div>
            <div class="modal-body">
                <div class="media">
                    <div class="media-body">
                        <form class="form-horizontal">
                            <div class="form-group">
                                <label for="myUsername" class="col-sm-2 control-label">用户名</label>
                                <div class="col-sm-10">
                                    <input type="text" class="form-control" id="myUsername" placeholder="用户名">
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="myPassword" class="col-sm-2 control-label">密码</label>
                                <div class="col-sm-10">
                                    <input type="password" class="form-control" id="myPassword" placeholder="填写此栏以修改密码">
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="myPasswordConfirm" class="col-sm-2 control-label">确认</label>
                                <div class="col-sm-10">
                                    <input type="password" class="form-control" id="myPasswordConfirm" placeholder="填写此栏以确认修改密码">
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="myNickname" class="col-sm-2 control-label">昵称</label>
                                <div class="col-sm-10">
                                    <input type="text" class="form-control" id="myNickname" placeholder="昵称">
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="myBalance" class="col-sm-2 control-label">余额</label>
                                <div class="col-sm-10">
                                    <p class="form-control-static" id="myBalance"></p>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="myRole" class="col-sm-2 control-label">身份</label>
                                <div class="col-sm-10">
                                    <p class="form-control-static" id="myRole"></p>
                                </div>
                            </div>
                        </form>
                    </div>
                    <div class="media-right">
                        <img class="media-object user-image" id="myImageShow">
                        <p class="tip-under-image" id="myProfileUploadTips"></p>
                        <button type="button" class="btn btn-primary btn-block" id="btnUpdateMyAvatar">更换我的头像</button>
                        <button type="button" class="btn btn-danger btn-block" id="btnDeleteMyAvatar">删除我的头像</button>
                        <input type="text" class="form-control hidden" id="myAvatar">
                    </div>
                </div>
                <div class="row" id="myProfileStatus"></div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-info" id="btnUpdateMyProfile">保存</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="myAddressDialog" tabindex="-1" role="dialog" aria-labelledby="myAddressDialogLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myAddressDialogLabel">我的收货地址 
                    <button type="button" class="btn btn-success btn-sm" id="btnAddMyAddress">
                        <span class="glyphicon glyphicon-plus"></span>
                    </button>
                </h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" id="myAddressForm"></form>
                <p id="myAddressStatus"></p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-info" id="btnUpdateMyAddress">保存</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
            </div>
        </div>
    </div>
</div>