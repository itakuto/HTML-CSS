<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<fmt:requestEncoding value="utf-8" />
<c:set var="formUserName" value="${param.userName}" />
<c:set var="formPass" value="${param.Pass}" />
<c:set var="formProductCode" value="${param.selectedCode}" />
<c:set var="formProductCount" value="${param.productCount}" />
<c:set var="Point" value="${param.Poin}" />

<sql:setDataSource driver="org.h2.Driver" url="jdbc:h2:sdev" />

<c:choose>
<c:when test="${formProductCount==null}"></c:when>
<c:otherwise>
<sql:update>
insert into CART
values(?,?,?*(select PRODUCT_INFO.PRICE from PRODUCT_INFO
where PRODUCT_INFO.PRODUCT_CODE = ?));
<sql:param value="${formProductCode}"/>
<sql:param value="${formProductCount}"/>
<sql:param value="${formProductCount}"/>
<sql:param value="${formProductCode}"/>
</sql:update>
</c:otherwise>
</c:choose>

<sql:query var="rs">
SELECT PRODUCT_INFO.PRODUCT_CODE,PRODUCT_INFO.PRODUCT_NAME,PRODUCT_INFO.SPORTS_NAME,PRODUCT_INFO.COUNTRY_NAME,
PRODUCT_INFO.IMAGE,PRODUCT_INFO.SIZE,PRODUCT_INFO.PRICE,CART.PRODUCT_COUNT,PRODUCT_STOCK.STOCK_NUM,PRODUCT_INFO.GENDER
FROM PRODUCT_INFO,CART,PRODUCT_STOCK
WHERE PRODUCT_INFO.PRODUCT_CODE=CART.PRODUCT_CODE AND PRODUCT_STOCK.PRODUCT_CODE=CART.PRODUCT_CODE;
</sql:query>

<sql:query var="rs2">
	select SUM_PRICE from CART;
</sql:query>
<c:set var="SumPrice" value="0"/>
<c:forEach var="row2" items="${rs2.rows}">
<c:set var="SumPrice" value="${SumPrice + row2.SUM_PRICE}"/>
</c:forEach>

<html>
<HEAD>
<STYLE type="text/css">
table{border-collapse:collapse;width:100%;}
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
	width: 350px;
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
	<TITLE>カート</TITLE>
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
	<input type="submit" value="戻る" name="back"></li>
</form>
</ul>
</div>

<center>
<br><h2>カート</h2>
</center>
<c:choose>
	<c:when test="${SumPrice==0}">
		<h4>現在カートに商品が入っていません。</h4><br>
		<FORM action="category.jsp" method="POST">
		<input type="hidden" value="${formUserName}" name="userName">
		<input type="hidden" value="${formPass}" name="Pass">
		<input type="submit" value="カテゴリへ" name="Member">
		</form>
	</c:when>
<c:otherwise>
<form action="delete.jsp" method="POST">
<input type="hidden" value="${formUserName}" name="userName">
<input type="hidden" value="${formPass}" name="Pass">
<input type="hidden" value="${Point}" name="Poin">
<input type="submit" value="全商品をカートから削除" name="alldelite">
</form>
<form action="selectdelete.jsp" method="POST">
<input type="hidden" value="${formUserName}" name="userName">
<input type="hidden" value="${formPass}" name="Pass">
<input type="hidden" value="${Point}" name="Poin">
<input type="submit" value="選択した商品をカートから削除" name="delite">
<table id="main">
	<tr>
		<th>イメージ</th>
		<th>製品名</th>
		<th>国</th>
		<th>スポーツ</th>
		<th>サイズ</th>
		<th>性別</th>
		<th>価格</th>
		<th>購入個数</th>
		<th>在庫</th>
	</tr>
<c:forEach var="row" items="${rs.rows}">

<TR>
<TD>
      <input type="checkbox" name="selectCode" value="${row.PRODUCT_CODE}">
      <img src="image/${row.IMAGE}" height="60" />
    </TD>
    <TD>${row.PRODUCT_NAME}</TD>
    <TD>${row.COUNTRY_NAME}</TD>
    <TD>${row.SPORTS_NAME}</TD>
    <td>${row.SIZE}</td>
    <TD>${row.GENDER}</TD>
  　<TD>${row.PRICE}円</TD>
　  <td>${row.PRODUCT_COUNT}</td>
    <td>${row.STOCK_NUM}</td>
</TR>

</c:forEach>

</TABLE>

</form>
<form action="purchase.jsp" method="POST">
<input type="hidden" value="${formUserName}" name="userName">
<input type="hidden" value="${formPass}" name="Pass">
<input type="hidden" value="${Point}" name="Poin">
<input type="submit" value="カートにある商品を購入する" name="allbuy">
<br>
</form>
</center>
<br>
</c:otherwise>
</c:choose>
</BODY>
</HTML>
