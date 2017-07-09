<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core' %>

<jsp:include page="./layout/page_head.jsp" />

<jsp:include page="./layout/content_navbar_book.jsp" />

<div class="container" id="bookMainContainer">
    <div class="alert alert-info fade in" role="alert"><span class="glyphicon glyphicon-time"></span> 正在加载书籍信息...</div>
    <div class="row" id="bookContainer"></div>
</div>

<div class="modal fade" id="detailDialog" tabindex="-1" role="dialog" aria-labelledby="detailDialogLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="detailDialogLabel">书籍详情</h4>
            </div>
            <div class="modal-body">
                <div class="media">
                    <div class="media-left">
                        <img class="media-object book-image" id="bookDetailImage">
                    </div>
                    <div class="media-body">
                        <input type="text" class="form-control hidden" id="bookDetailId">
                        <h2 id="bookDetailName"></h2>
                            <p class="book-detail-item" id="bookDetailAuthor"></p>
                            <p class="book-detail-item" id="bookDetailPress"></p>
                            <br>
                            <p id="bookDetailPrice"></p>
                            <p id="bookDetailCategories"></p>
                    </div>
                </div>
                <hr>
                <form class="form-horizontal">
                    <div class="form-group">
                        <div class="col-sm-12">
                            <textarea class="form-control" rows="5" id="bookDetailDescription" placeholder="暂无该书籍的介绍信息"  readonly></textarea>
                        </div>
                    </div>
                </form>
                <div class="row" id="detailStatus"></div>
            </div>
            <div class="modal-footer">
                <form class="form-inline pull-left">
                    <div class="form-group">
                        <label for="addQuantity">数量</label>
                        <input type="number" class="form-control" id="addQuantity" min="1">
                    </div>
                    <button type="button" class="btn btn-success" id="btnAddToCart">加入购物车</button>
                </form>
                <button type="button" class="btn btn-default" data-dismiss="modal">返回</button>
            </div>
        </div>
    </div>
</div>

<c:choose>
    <c:when test="${requestScope.role < 0}">
        <jsp:include page="./login.jsp" />
    </c:when> 
    <c:otherwise>
        <jsp:include page="./profile.jsp" />
    </c:otherwise>
</c:choose>

<jsp:include page="./layout/content_footer.jsp" />

<jsp:include page="./layout/common_js.jsp" />

<script src="<s:url value="/js/user.js"/>"></script>
<script src="<s:url value="/js/home.js"/>"></script>

<c:choose>
    <c:when test="${requestScope.role < 0}">
        <script src="<s:url value="/js/login.js"/>"></script>
    </c:when> 
    <c:otherwise>
        <script src="<s:url value="/js/profile.js"/>"></script>
    </c:otherwise>
</c:choose>

<jsp:include page="./layout/page_end.jsp" />

