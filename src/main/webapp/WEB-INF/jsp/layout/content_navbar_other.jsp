<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core' %>
<nav class="navbar navbar-fixed-top bg-info">
    <div class="container">
        <div class="navbar-header">
            <a class="navbar-brand" href="<s:url value="/home"/>">欢迎来到网上书店</a>
        </div>
        <div class="collapse navbar-collapse">
            <ul class="nav navbar-nav navbar-right">
                <li><a href="<s:url value="/cart"/>"><span class="glyphicon glyphicon-shopping-cart"></span> 购物车 <span class="badge badge-cart" id="cartCount"></span></a></li>
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"><img class="navbar-avatar" src="${requestScope.avatar}"> ${requestScope.nickname} <span class="caret"></span>
                    </a>
                    <ul class="dropdown-menu">
                        <c:if test="${requestScope.role > 0}">
                            <li><a href="<s:url value="/admin/books"/>"><span class="glyphicon glyphicon-wrench"></span> 进入管理系统</a></li>
                            <li role="separator" class="divider"></li>
                        </c:if>
                        <li><a href="<s:url value="/home"/>"><span class="glyphicon glyphicon-home"></span> 返回首页</a></li>
                        <li role="separator" class="divider"></li>
                        <li><a href="<s:url value="/orders"/>"><span class="glyphicon glyphicon-list-alt"></span> 我的历史订单</a></li>
                        <li><a href="#"><span class="glyphicon glyphicon-user"></span> 管理个人信息</a></li>
                        <li role="separator" class="divider"></li>
                        <li><a href="<s:url value="/logout"/>"><span class="glyphicon glyphicon-log-out"></span> 登出</a></li>
                    </ul>
                </li>
            </ul>
        </div>
    </div>
</nav>