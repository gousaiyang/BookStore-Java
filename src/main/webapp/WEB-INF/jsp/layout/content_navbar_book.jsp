<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core' %>
<nav class="navbar navbar-fixed-top bg-info">
    <div class="container">
        <div class="navbar-header">
            <a class="navbar-brand" href="javascript:void(0)">欢迎来到网上书店</a>
        </div>
        <div class="collapse navbar-collapse">
            <form class="navbar-form navbar-left" role="search">
                <select class="form-control" id="selectCategory">
                    <option value="0" selected>所有分类</option>
                    <c:forEach var="category" items="${requestScope.categories}">
                        <option value="<c:out value="${category[0]}"/>"><c:out value="${category[1]}"/></option>
                    </c:forEach>
                </select>
                <div class="form-group">
                    <input type="text" class="form-control" id="searchBookInput" placeholder="搜索书籍">
                </div>
            </form>
            <ul class="nav navbar-nav navbar-right">
                <c:choose>
                    <c:when test="${requestScope.role < 0}">
                        <li><a href="#" data-toggle="modal" data-target="#registerDialog">注册</a></li>
                        <li><a href="#" data-toggle="modal" data-target="#loginDialog">登录</a></li>
                    </c:when> 
                    <c:otherwise>
                        <li><a href="<s:url value="/cart"/>"><span class="glyphicon glyphicon-shopping-cart"></span> 购物车 <span class="badge badge-cart" id="cartCount"></span></a></li>
                        <li class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"><img class="navbar-avatar" src="${requestScope.avatar}"> ${requestScope.nickname} <span class="caret"></span>
                            </a>
                            <ul class="dropdown-menu">
                                <c:if test="${requestScope.role > 0}">
                                    <li><a href="<s:url value="/admin/books"/>"><span class="glyphicon glyphicon-wrench"></span> 进入管理系统</a></li>
                                    <li role="separator" class="divider"></li>
                                </c:if>
                                <li><a href="<s:url value="/orders"/>"><span class="glyphicon glyphicon-list-alt"></span> 我的历史订单</a></li>
                                <li><a href="#"><span class="glyphicon glyphicon-user"></span> 管理个人信息</a></li>
                                <li role="separator" class="divider"></li>
                                <li><a href="<s:url value="/logout"/>"><span class="glyphicon glyphicon-log-out"></span> 登出</a></li>
                            </ul>
                        </li>
                    </c:otherwise>
                </c:choose>
            </ul>
        </div>
    </div>
</nav>