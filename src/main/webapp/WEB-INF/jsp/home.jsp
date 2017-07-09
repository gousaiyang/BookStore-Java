<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="s" uri="/struts-tags" %>

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
                        <input type="number" class="form-control" id="addQuantity" min="0">
                    </div>
                    <button type="button" class="btn btn-success" id="btnAddToCart">加入购物车</button>
                </form>
                <button type="button" class="btn btn-default" data-dismiss="modal">返回</button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="loginDialog" tabindex="-1" role="dialog" aria-labelledby="loginDialogLabel">
    <div class="modal-dialog modal-sm" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="loginDialogLabel">登录</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <div class="col-md-12">
                            <input type="text" class="form-control" id="loginUsername" placeholder="用户名" autofocus="autofocus">
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-md-12">
                            <input type="password" class="form-control" id="loginPassword" placeholder="密码">
                        </div>
                    </div>
                </form>
                <p id="loginStatus"></p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" id="btnLogin">登录</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">返回</button>
            </div>
        </div>
    </div>
</div>

<jsp:include page="./layout/content_footer.jsp" />

<jsp:include page="./layout/common_js.jsp" />

<script src="<s:url value="/js/user.js"/>"></script>
<script src="<s:url value="/js/login.js"/>"></script>
<script src="<s:url value="/js/home.js"/>"></script>

<jsp:include page="./layout/page_end.jsp" />

