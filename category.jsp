<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<fmt:requestEncoding value="utf-8" />
<c:set var="formUserName" value="${param.userName}" />
<c:set var="formPass" value="${param.Pass}" />
<c:set var="formMember" value="${param.Member}" />

<sql:setDataSource driver="org.h2.Driver" url="jdbc:h2:sdev" />

<c:choose>
	<c:when test="${empty formUserName}"></c:when>
		<c:otherwise>
<sql:query var="rs">
SELECT CUSTOMER_POINT,COUNTRY_NAME FROM CUSTOMER_INFO
WHERE CUSTOMER_NAME = ? AND CUSTOMER_PASS = ?;
<sql:param value="${formUserName}"/>
<sql:param value="${formPass}"/>
</sql:query>

<c:set var="row" value="${rs.rows[0]}"/>
<c:set var="Point" value="${row.CUSTOMER_POINT}"/>
<c:set var="formCountry" value="${row.COUNTRY_NAME}"/>

<sql:query var="rs4">
SELECT * FROM PRODUCT_INFO WHERE COUNTRY_NAME = ? AND SIZE = 'M';
<sql:param value="${formCountry}"/>
</sql:query>
</c:otherwise>
</c:choose>

<sql:query var="rs2">
SELECT COUNTRY_NAME FROM COUNTRY_INFO;
</sql:query>

<sql:query var="rs3">
SELECT SPORTS_NAME,SPORTS_IMG FROM SPORTS_INFO;
</sql:query>




<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>カテゴリ選択</title>
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
</head>

<body>
	<c:choose>
		<c:when test="${formMember == 'ログイン'||formMember == 'カテゴリ'||formMember == 'カテゴリへ'||formMember=='戻る'}">
<c:choose>
<c:when test="${empty Point}">
ユーザー名またはパスワードが違います。<br>
<a href="userinfo.html">ログイン画面へ</a>
</c:when>
<c:otherwise>
<div class="header">
<ul><li> ${formUserName} さん |</li>
    <li>${Point} ポイント |</li>
    <li>カテゴリ |</li>
    <li><FORM action="cart.jsp" method="POST">
            <input type="hidden" value="${formUserName}" name="userName">
            <input type="hidden" value="${formPass}" name="Pass">
            <input type="hidden" value="${Point}" name="Poin">
	    <input type="submit" value="カート" name="gocart"> |</li>
    <li><a href="userinfo.html">ログアウト </a>|</li>
    <li><a href="userinfo.html">戻る</a></li>
</ul>
</div>
</form>
<FORM action="product.jsp" method="POST">
<input type="hidden" value="${formUserName}" name="userName">
<input type="hidden" value="${formPass}" name="Pass">
<input type="hidden" value="${Point}" name="Poin">
<div class="around">
<div class="area1">
<h2>絞り込み指定</h2>
<h4>スポーツ指定</h4>
<table id="main" border="1">
<c:forEach var="row3" items="${rs3.rows}">
<tr><td><input type="checkbox" name="sportsName" value="${row3.SPORTS_NAME}">
      <img src="image/${row3.SPORTS_IMG}" height="60" />
    </td>
    <td>${row3.SPORTS_NAME}</td>
</tr>
</c:forEach>

</TABLE>
<br><input type="submit" value="検索" name="search">
</div>
<div class="area3">
<br>
<h4>国指定 </h4>
<select name="countryName" size="1">
        <option>指定なし
<c:forEach var="row2" items="${rs2.rows}">
        <option>${row2.COUNTRY_NAME}
</c:forEach>
</select>
</div>
</FORM>
<div class="area4">
<form action="conform.jsp" method="POST">
<input type="hidden" value="${formUserName}" name="userName">
<input type="hidden" value="${formPass}" name="Pass">
<input type="hidden" value="${Point}" name="Poin">
<h2>おすすめ商品</h2>
<TABLE id="main">
	<TR>
		<TH>イメージ</TH>
		<TH>製品名</TH>
		<TH>国</TH>
		<th>スポーツ</th>
		<th>性別</th>
		<TH>価格</TH>
		<th>口コミ</th>
	</TR>
<c:forEach var="row4" items="${rs4.rows}">

<TR>
<TD>
      <input type="radio" name="selectedCode" value="${row4.PRODUCT_NAME}">
      <img src="image/${row4.IMAGE}" height="60" />
    </TD>
    <TD>${row4.PRODUCT_NAME}</TD>
    <TD>${row4.COUNTRY_NAME}</TD>
    <td>${row4.SPORTS_NAME}</td>
    <td>${row4.GENDER}</td>
  　<TD>${row4.PRICE}</TD>
    <td><a href="review.jsp?productCode=${row4.PRODUCT_CODE}">口コミ</a></td>
</TR>

</c:forEach>

</TABLE>
</div>
<div class="area2">
<br><br>
<h3>サイズ</h3>
<select name="sizeRange" size="1">
        <option>S
        <option>M
        <option>L
</select><br>
<h3>個数</h3>
<SELECT NAME="productCount" SIZE="1">
        <OPTION>1
        <OPTION>2
        <OPTION>3
        <OPTION>4
        <OPTION>5
</SELECT> <br>
<input type="submit" value="カートに入れる" name="gotocart">
</div>
</div>
</form>
</c:otherwise>
</c:choose>
</c:when>
<c:otherwise>
	<div class="header">
	<ul><li> ゲスト さん |</li>
	    <li>- ポイント |</li>
	    <li>カテゴリ |</li>
	    <li>カート |</li>
	    <li><a href="userinfo.html">ログイン </a>|</li>
	    <li><a href="userinfo.html">戻る</a></li>
	</ul>
	</div>
	<FORM action="product.jsp" method="POST">
	<input type="hidden" value="ゲスト" name="userName">
	<div class="around">
	<div class="area1">
	<h2>絞り込み指定</h2>
	<h4>スポーツ指定</h4>
	<table id="main" border="1">
	<c:forEach var="row3" items="${rs3.rows}">
	<tr><td><input type="checkbox" name="sportsName" value="${row3.SPORTS_NAME}">
	      <img src="image/${row3.SPORTS_IMG}" height="60" />
	    </td>
	    <td>${row3.SPORTS_NAME}</td>
	</tr>
	</c:forEach>

	</TABLE>
	<br><input type="submit" value="検索" name="search">
	</div>
	<div class="area3">
	<br>
	<h4>国指定 </h4>
	<select name="countryName" size="1">
	        <option>指定なし
	<c:forEach var="row2" items="${rs2.rows}">
	        <option>${row2.COUNTRY_NAME}
	</c:forEach>
	</select>
	</div>
	</FORM>
</c:otherwise>
</c:choose>
<!-- httpで開いているかチェック -->
<script>
  if (location.href.match(/^file:/)) {
    alert("Webサーバを起動して、http://localhost:8080 から開いてください");
  }
</script>

</body>
</html>
