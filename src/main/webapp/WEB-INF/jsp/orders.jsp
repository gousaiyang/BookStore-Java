<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="s" uri="/struts-tags" %>

<jsp:include page="./layout/page_head.jsp" />

<jsp:include page="./layout/content_navbar_other.jsp" />

<div class="container">
    <h1>我的历史订单</h1>
    <div class="alert alert-info fade in" role="alert"><span class="glyphicon glyphicon-time"></span> 正在加载订单信息...</div>
    <div class="table-responsive">
        <table class="table table-hover">
            <thead>
                <tr>
                    <th>订单编号</th>
                    <th>项目数</th>
                    <th>总数量</th>
                    <th>总价</th>
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
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="detailDialogLabel">订单详情</h4>
            </div>
            <div class="modal-body">
                <div class="table-responsive">
                    <table class="table table-hover">
                        <thead>
                            <tr>
                                <th>书籍</th>
                                <th>单价</th>
                                <th>数量</th>
                                <th>小计</th>
                            </tr>
                        </thead>
                        <tbody id="detailTable">
                        <!-- Table data will be loaded by js. -->
                        </tbody>
                    </table>
                </div>
                <p id="detailStatus"></p>
            </div>
            <div class="modal-footer">
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
                <h4 class="modal-title" id="deleteDialogLabel">删除订单记录</h4>
            </div>
            <div class="modal-body">
                <p id="deleteText">您确实要删除此条订单记录吗？</p>
                <input type="text" class="form-control hidden" id="deleteOrderId">
                <p id="deleteStatus"></p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-danger" id="btnDeleteOrder">删除</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
            </div>
        </div>
    </div>
</div>

<jsp:include page="./profile.jsp" />

<jsp:include page="./layout/content_footer.jsp" />

<jsp:include page="./layout/common_js.jsp" />

<script src="<s:url value="/js/user.js"/>"></script>
<script src="<s:url value="/js/orders.js"/>"></script>
<script src="<s:url value="/js/profile.js"/>"></script>

<jsp:include page="./layout/page_end.jsp" />
