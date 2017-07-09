<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html lang="zh-CN">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="renderer" content="webkit">

        <title><%= request.getAttribute("pageTitle") %></title>
        
        <link href="<s:url value="/css/bootstrap.min.css"/>" rel="stylesheet">
        <!--[if lt IE 9]>
            <script src="//cdn.bootcss.com/html5shiv/3.7.3/html5shiv.min.js"></script>
            <script src="//cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
        <![endif]-->
        <link href="<s:url value="/css/style.css"/>" rel="stylesheet">
    </head>
    <body>
        <input type="hidden" id="contextPath" value="<%= request.getContextPath() %>">