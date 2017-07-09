<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="s" uri="/struts-tags" %>

<jsp:include page="../layout/page_head.jsp" />

<jsp:include page="../layout/content_navbar_admin.jsp" />

<div class="container">
    <h1>订单管理</h1>
    <div class="alert alert-info fade in" role="alert"><span class="glyphicon glyphicon-time"></span> 正在加载订单信息...</div>
    <div class="table-responsive">
        <table class="table table-hover">
            <thead>
                <tr>
                    <th>编号</th>
                    <th>发起用户</th>
                    <th>项目数</th>
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
                                <th>单价</th>
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

<jsp:include page="../layout/content_footer.jsp" />

<jsp:include page="../layout/common_js.jsp" />

<script src="<s:url value="/js/admin/order.js"/>"></script>

<jsp:include page="../layout/page_end.jsp" />
