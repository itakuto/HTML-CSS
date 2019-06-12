<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<fmt:requestEncoding value="utf-8" />
<c:set var="formUserName" value="${param.userName}" />
<c:set var="formPass" value="${param.Pass}" />
<c:set var="formCountry" value="${param.MyCountry}"/>

<sql:setDataSource driver="org.h2.Driver" url="jdbc:h2:sdev" />

<sql:update>
INSERT INTO CUSTOMER_INFO
VALUES(?,?,0,?);
<sql:param value="${formUserName}"/>
<sql:param value="${formPass}"/>
<sql:param value="${formCountry}"/>
</sql:update>

<html>
<head>
<title>会員登録完了</title>
</head>
<body>
会員登録が完了しました。<br>
ユーザー名：${formUserName}<br>
パスワード：${formPass}<br>
出身国：${formCountry}<br>
<a href="userinfo.html">ログイン画面へ</a>
</body>
</html>