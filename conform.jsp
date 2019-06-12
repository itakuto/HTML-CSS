<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<fmt:requestEncoding value="utf-8" />
<c:set var="formUserName" value="${param.userName}" />
<c:set var="formPass" value="${param.Pass}" />
<c:set var="formProductName" value="${param.selectedCode}" />
<c:set var="formSize" value="${param.sizeRange}" />
<c:set var="formProductCount" value="${param.productCount}" />
<c:set var="Point" value="${param.Poin}" />

<sql:setDataSource driver="org.h2.Driver" url="jdbc:h2:sdev" />

<sql:query var="rs2">
SELECT PRODUCT_CODE,IMAGE FROM PRODUCT_INFO
WHERE PRODUCT_NAME = ? AND SIZE = ?;
<sql:param value="${formProductName}"/>
<sql:param value="${formSize}"/>
</sql:query>
<c:set var="row2" value="${rs2.rows[0]}" />
<c:set var="formProductCode" value="${row2.PRODUCT_CODE}" />
<c:set var="formImage" value="${row2.IMAGE}" />

<sql:query var="rs">
SELECT STOCK_NUM FROM PRODUCT_STOCK
WHERE PRODUCT_CODE = ?;
<sql:param value="${formProductCode}"/>
</sql:query>

<c:set var="row" value="${rs.rows[0]}" />
<c:set var="stockNum" value="${row.STOCK_NUM}" />




<html>
<HEAD>
<STYLE type="text/css">
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
</STYLE>
	<META http-equiv="Content-Language" content="ja">
	<META http-equiv="Content-Type" content="text/html; charset=utf-8">
	<TITLE>在庫確認</TITLE>
</HEAD>
<BODY>
<div class="header">
<ul>
	<li>${formUserName} さん |</li>
	<li>${Point} ポイント |</li>
	<li><FORM action="category.jsp" method="POST">
	<input type="hidden" value="${formUserName}" name="userName">
	<input type="hidden" value="${formPass}" name="Pass">
	<input type="submit" value="カテゴリ" name="Member">|</form></li>
	<li>カート |</li>
	<li><a href="userinfo.html">ログアウト</a>|</li>
	<li><FORM action="category.jsp" method="POST">
	<input type="hidden" value="${formUserName}" name="userName">
	<input type="hidden" value="${formPass}" name="Pass">
	<input type="hidden" value="${Point}" name="Poin">
	<input type="submit" value="戻る" name="back"></form></li>
</ul>
</div>


<c:choose>
<c:when test="${formProductCount == null || formProductName == null}">
<form action="category.jsp" method="POST">
<input type="hidden" value="${formUserName}" name="userName">
<input type="hidden" value="${formPass}" name="Pass">
<input type="hidden" value="${Point}" name="Poin">
<br><br>カートに入れる商品・個数が指定されていません。<br>
<input type="submit" value="カテゴリへ" name="category1">
</form>
</c:when>
<c:when test="${formProductCount <= stockNum}">
<form action="cart.jsp" method="POST">
<input type="hidden" value="${formUserName}" name="userName">
<input type="hidden" value="${formPass}" name="Pass">
<input type="hidden" value="${formProductCode}" name="selectedCode">
<input type="hidden" value="${formProductCount}" name="productCount">
<input type="hidden" value="${Point}" name="Poin">
<table>
<div class="area1">
<br><br>カートへ入れました。<br><br>
<img src="image/${formImage}" height="200"/><br><br>
<input type="submit" value="カートへ" name="cart">
</div>
<div class="area2">
<br><br><br><br><br><br><br>
商品名：${formProductName}<br>
商品コード：${formProductCode}<br>
サイズ：${formSize}<br>
購入個数：${formProductCount}<br>
在庫：${stockNum}
</div>
</form>
</c:when>
<c:when test="${formProductCount > stockNum}">
<br><br>申し訳ございません。在庫が足りないのでカートへ入れられませんでした。<br>
<form action="category.jsp" method="POST">
<input type="hidden" value="${formUserName}" name="userName">
<input type="hidden" value="${formPass}" name="Pass">
<input type="hidden" value="${Point}" name="Poin"><input type="submit" value="カテゴリへ" name="Member">
</form>
</c:when>
</c:choose>

</body>
</html>
