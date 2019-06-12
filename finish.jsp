<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<fmt:requestEncoding value="utf-8" />
<c:set var="formUserName" value="${param.userName}" />
<c:set var="formPass" value="${param.Pass}" />
<c:set var="formPassword" value="${param.Password}" />
<c:set var="formWayBuy" value="${param.wayBuy}" />

<sql:setDataSource driver="org.h2.Driver" url="jdbc:h2:sdev" />
<c:choose>
<c:when test="${formPassword == formPass}">
<sql:update>
<c:choose>
<c:when test="${formWayBuy == 0}">
update CUSTOMER_INFO set CUSTOMER_POINT = CUSTOMER_POINT + 0.01*(select SUM(CART.SUM_PRICE)
from CART) where CUSTOMER_NAME = ? and CUSTOMER_PASS = ?;
<sql:param value="${formUserName}"/>
<sql:param value="${formPass}"/>
</c:when>
<c:when test="${formWayBuy == 1}">
update CUSTOMER_INFO set CUSTOMER_POINT = CUSTOMER_POINT - (select SUM(CART.SUM_PRICE)
from CART) where CUSTOMER_NAME = ? and CUSTOMER_PASS = ?;
<sql:param value="${formUserName}"/>
<sql:param value="${formPass}"/>
</c:when>
</c:choose>
UPDATE PRODUCT_STOCK SET STOCK_NUM = STOCK_NUM - (SELECT CART.PRODUCT_COUNT FROM CART
WHERE PRODUCT_STOCK.PRODUCT_CODE = CART.PRODUCT_CODE)
WHERE (SELECT CART.PRODUCT_COUNT FROM CART
WHERE PRODUCT_STOCK.PRODUCT_CODE = CART.PRODUCT_CODE) IS NOT NULL;
DELETE FROM CART;
</sql:update>
</c:when>
<c:otherwise></c:otherwise>
</c:choose>

<sql:query var="rs">
select CUSTOMER_POINT from CUSTOMER_INFO where CUSTOMER_NAME = ? and CUSTOMER_PASS = ?;
<sql:param value="${formUserName}"/>
<sql:param value="${formPass}"/>
</sql:query>
<c:set var="row" value="${rs.rows[0]}"/>
<c:set var="Point" value="${row.CUSTOMER_POINT}"/>


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
	<TITLE>購入完了</TITLE>
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
	<li><FORM action="cart.jsp" method="POST">
            <input type="hidden" value="${formUserName}" name="userName">
            <input type="hidden" value="${formPass}" name="Pass">
            <input type="hidden" value="${Point}" name="Poin">
	    <input type="submit" value="カート" name="gocart"> |</form></li>
	<li><a href="userinfo.html">ログアウト</a></li>
</ul>
</div>


<c:choose>
<c:when test="${formPassword == formPass}">
<br><h2>購入が完了しました。</h2>
購入者名：${formUserName}<br>
パスワード：${formPass}<br>
ポイント：${Point}<br><br>
<FORM action="category.jsp" method="POST">
<input type="hidden" value="${formUserName}" name="userName">
<input type="hidden" value="${formPass}" name="Pass">
<input type="submit" value="カテゴリへ" name="Member">
</form>
</c:when>
<c:otherwise>
パスワードが違います。<br>
<FORM action="purchase.jsp" method="POST">
<input type="hidden" value="${formUserName}" name="userName">
<input type="hidden" value="${formPass}" name="Pass">
<input type="hidden" value="${Point}" name="Poin">
<input type="submit" value="パスワード入力画面に戻る" name="backpass">
</form>
</c:otherwise>
</c:choose>
</body>
</html>
