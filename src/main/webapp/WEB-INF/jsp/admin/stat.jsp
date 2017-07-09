<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core' %>

<jsp:include page="../layout/page_head.jsp" />

<jsp:include page="../layout/content_navbar_admin.jsp" />

<div class="container">
    <h1>销售统计</h1>
    <div class="panel panel-info">
        <div class="panel-heading">
            <h4 class="panel-title">按分类筛选</h4>
        </div>
        <div class="panel-body">
            <form class="form-inline">
                <select class="form-control" id="filterCategory">
                    <option value="0" selected>所有分类</option>
                    <c:forEach var="category" items="${requestScope.categories}">
                        <option value="<c:out value="${category[0]}"/>"><c:out value="${category[1]}"/></option>
                    </c:forEach>
                </select>
                <input type="date" class="form-control" id="filterCategoryStartDate">
                -
                <input type="date" class="form-control" id="filterCategoryEndDate">
                <button type="button" class="btn btn-primary" id="btnFilterCategory">筛选</button>    
            </form>
            <hr class="hidden" id="filterCategoryHR">
            <p class="hidden" id="filterCategoryStatus"></p>
            <div class="hidden" id="filterCategoryResult">
                <span class="stat-item" id="filterCategoryPerson"></span>
                <span class="stat-item" id="filterCategoryQuantity"></span>
                <span class="stat-item" id="filterCategoryPrice"></span>
            </div>
        </div>
    </div>
    <div class="panel panel-info">
        <div class="panel-heading">
            <h4 class="panel-title">按书籍筛选</h4>
        </div>
        <div class="panel-body">
            <form class="form-inline">
                <input type="number" class="form-control" min="1" placeholder="书籍编号" id="filterBook">
                <input type="date" class="form-control" id="filterBookStartDate">
                -
                <input type="date" class="form-control" id="filterBookEndDate">
                <button type="button" class="btn btn-primary" id="btnFilterBook">筛选</button>    
            </form>
            <hr class="hidden" id="filterBookHR">
            <p class="hidden" id="filterBookStatus"></p>
            <div class="hidden" id="filterBookResult">
                <span class="stat-item" id="filterBookPerson"></span>
                <span class="stat-item" id="filterBookQuantity"></span>
                <span class="stat-item" id="filterBookPrice"></span>
            </div>
        </div>
    </div>
    <div class="panel panel-info">
        <div class="panel-heading">
            <h4 class="panel-title">按用户筛选</h4>
        </div>
        <div class="panel-body">
            <form class="form-inline">
                <input type="text" class="form-control" placeholder="用户名" id="filterUser">
                <input type="date" class="form-control" id="filterUserStartDate">
                -
                <input type="date" class="form-control" id="filterUserEndDate">
                <button type="button" class="btn btn-primary" id="btnFilterUser">筛选</button>    
            </form>
            <hr class="hidden" id="filterUserHR">
            <p class="hidden" id="filterUserStatus"></p>
            <div class="hidden" id="filterUserResult">
                <span class="stat-item" id="filterUserOrders"></span>
                <span class="stat-item" id="filterUserItems"></span>
                <span class="stat-item" id="filterUserQuantity"></span>
                <span class="stat-item" id="filterUserPrice"></span>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../profile.jsp" />

<jsp:include page="../layout/content_footer.jsp" />

<jsp:include page="../layout/common_js.jsp" />

<script src="<s:url value="/js/admin/stat.js"/>"></script>
<script src="<s:url value="/js/profile.js"/>"></script>

<jsp:include page="../layout/page_end.jsp" />
