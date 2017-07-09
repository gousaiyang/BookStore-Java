<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="s" uri="/struts-tags" %>

<jsp:include page="./layout/page_head.jsp" />

<jsp:include page="./layout/content_navbar_other.jsp" />

<div class="container">
    <h1>我的购物车</h1>
    <div class="alert alert-info fade in" role="alert"><span class="glyphicon glyphicon-time"></span> 正在加载购物车内容...</div>
    <div class="table-responsive">
        <table class="table table-hover">
            <thead>
                <tr>
                    <th>书籍</th>
                    <th>单价</th>
                    <th>数量</th>
                    <th>小计</th>
                    <th>操作</th>
                </tr>
            </thead>
            <tbody>
            <!-- Table data will be loaded by js. -->
            </tbody>
        </table>
    </div>
    <p id="totalPriceText"></p>
    <button type="button" class="btn btn-success" data-toggle="modal" data-target="#payDialog">结算</button>
</div>

<div class="modal fade" id="updateDialog" tabindex="-1" role="dialog" aria-labelledby="updateDialogLabel">
    <div class="modal-dialog modal-sm" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="updateDialogLabel">修改数量</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <input type="text" class="form-control hidden" id="updateItemId">
                    <div class="form-group">
                        <div class="col-md-12">
                            <p class="form-control-static" id="updateItemBookName"></p>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-md-12">
                            <input type="number" class="form-control" id="updateItemQuantity" min="1">
                        </div>
                    </div>
                </form>
                <p id="updateStatus"></p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-info" id="btnUpdate">修改</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">返回</button>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="deleteDialog" tabindex="-1" role="dialog" aria-labelledby="deleteDialogLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="deleteDialogLabel">删除购物车条目</h4>
            </div>
            <div class="modal-body">
                <p id="deleteText"></p>
                <input type="text" class="form-control hidden" id="deleteItemId">
                <p id="deleteItemStatus"></p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-danger" id="btnDeleteItem">删除</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="payDialog" tabindex="-1" role="dialog" aria-labelledby="payDialogLabel">
    <div class="modal-dialog modal-sm" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="payDialogLabel">结算</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label class="col-sm-4 control-label">总项目数</label>
                        <div class="col-sm-8">
                            <p class="form-control-static" id="payTotalItems"></p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-4 control-label">总数量</label>
                        <div class="col-sm-8">
                            <p class="form-control-static" id="payTotalQuantity"></p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-4 control-label">总价</label>
                        <div class="col-sm-8">
                            <p class="form-control-static" id="payTotalPrice"></p>
                        </div>
                    </div>
                </form>
                <p id="payStatus"></p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" id="btnPay">确认支付</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">返回</button>
            </div>
        </div>
    </div>
</div>

<jsp:include page="./profile.jsp" />

<jsp:include page="./layout/content_footer.jsp" />

<jsp:include page="./layout/common_js.jsp" />

<script src="<s:url value="/js/user.js"/>"></script>
<script src="<s:url value="/js/cart.js"/>"></script>
<script src="<s:url value="/js/profile.js"/>"></script>

<jsp:include page="./layout/page_end.jsp" />

