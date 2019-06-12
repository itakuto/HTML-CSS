<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<fmt:requestEncoding value="utf-8" />
<c:set var="formUserName" value="${param.userName}" />
<c:set var="formPass" value="${param.Pass}" />
<c:set var="Point" value="${param.Poin}" />

<sql:setDataSource driver="org.h2.Driver" url="jdbc:h2:sdev" />

<sql:update>
DELETE FROM CART
</sql:update>

<head>
<style>
table{border-collapse:collapse;}
body {background-color:white;}
#main{border-collapse:separate; border-spacing:2px;}
th {background-color:#333333; align:center; font-size:large; font-weight:bold; color:white;border:solid 1px black;}
td {background-color:#FFFFFF; font-size:normal; color:black;border:solid 1px black;}
img {vertical-align: middle;}
.around{display:table;margin:0px;padding:0px;width:100%;}
.area1{display:table-cell;}
.area2{display:table-cell;}
.area3{display:table-cell;}
.area4{display:table-cell;}
input[type="submit"] {
	font-family:sans-serif;
	color: #FFF;
	width: 150px;
	padding: 12px 10px;
	text-align: center;
	border: 0;
	cursor: pointer;
	font-size: 1.1em;
	background: #228b22;
	line-height: 1.2;
	border-bottom: 2px solid #d9d9d9;
	line-height: 1.25;
}
input[type="submit"]:hover {
	background: #7fffd4;
}
.header{
	width: 100%;
	background: #272727;
	font-size: 93%;
	font-family: "ヒラギノ角ゴ Pro W3", "Hiragino Kaku Gothic Pro", "メイリオ", Meiryo, Osaka, "ＭＳ Ｐゴシック", "MS PGothic", sans-serif;
	z-index: 9999;
	top: 0;
	left: 0;
	text-align:left;
	position: fixed;
        font-color:white;
        height: 28px;
	margin: 0 auto;
	zoom: 1;
	display: inline-block;
	padding: 0 6px 0 6px;
}
ul,li{
	display: inline-block;
	color: #fff;
	font-size: 93%;
	border-left: none;
	padding: 0;
	margin: 0;
}
.header input[type="submit"]{
	font-family:sans-serif;
	color: #FFF;
	width: 75px;
        height: 28px;
	text-align: center;
	border: 0;
	cursor: pointer;
	font-size: 1.1em;
	background: #272727;
	padding: 0;
	margin: 0;
}
.header input[type="submit"]:hover {
	background: #ffffff;
	color: #000;
}
.header a{
	font-family:sans-serif;
	color: #FFF;
	width: 75px;
        height: 36px;
	text-align: center;
	border: 0;
	cursor: pointer;
	font-size: 1.1em;
	background: #272727;
	text-decoration:none;
}
.header a:hover{
	background: #ffffff;
	color: #000;
}
</style>
<title>全削除</title>
</head>

<body>
<div class="header">
<ul>
	<li>${formUserName} さん |</li>
	<li>${Point} ポイント |</li>
	<li><FORM action="category.jsp" method="POST">
	<input type="hidden" value="${formUserName}" name="userName">
	<input type="hidden" value="${formPass}" name="Pass">
	<input type="submit" value="カテゴリ" name="Member">|</form></li>
	<li><FORM action="cart.jsp" method="POST">
            <input type="hidden" value="${formUserName}" name="userName">
            <input type="hidden" value="${formPass}" name="Pass">
            <input type="hidden" value="${Point}" name="Poin">
	    <input type="submit" value="カート" name="gocart">|</li>
	<li><a href="userinfo.html">ログアウト</a></li>
</ul>
</div>
</form>
<br><br>全商品をカートから削除しました。<br>
<form action="category.jsp" method="POST">
<input type="hidden" value="${formUserName}" name="userName">
<input type="hidden" value="${formPass}" name="Pass">
<input type="hidden" value="${Point}" name="Poin">
<input type="submit" value="カテゴリへ" name="Member">
</form>
</html>
