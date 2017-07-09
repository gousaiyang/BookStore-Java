<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>

<jsp:include page="./layout/page_head.jsp" />

<div class="container">
    <div class="jumbotron">
        <h1>在线书店管理系统 V2</h1>
        <p>欢迎使用在线书店管理系统！</p>
        <p>点击下方按钮，进入管理系统的各个模块。</p>
        <p>
            <a class="btn btn-primary btn-lg" href="/BookStore/books" role="button"><span class="glyphicon glyphicon-book"></span> 书籍管理</a>
            <a class="btn btn-success btn-lg" href="/BookStore/orders" role="button"><span class="glyphicon glyphicon-list-alt"></span> 订单管理</a>
            <a class="btn btn-info btn-lg" href="/BookStore/users" role="button"><span class="glyphicon glyphicon-user"></span> 用户管理</a>
        </p>
    </div>
</div>

<jsp:include page="./layout/common_js.jsp" />

<jsp:include page="./layout/page_end.jsp" />
