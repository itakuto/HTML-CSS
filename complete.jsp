<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" import="java.sql.*"%>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%--

  �f�[�^�x�[�X�ւ̃R�l�N�V�������擾

--%>
<sql:setDataSource driver="org.h2.Driver" url="jdbc:h2:sdev" />


<%--

  �̔���ʂőI�������ߗ��i�̏����擾����

  ���i�R�[�h���擾���A�ϐ�[formProductCode]�Ɋi�[����

--%>
<fmt:requestEncoding value="utf-8" />
<c:set var="formProductCode" value="${param.selectedProductCode}" />
<%--

  ���i�̍݌ɂ���������
  [PRODUCT_STOCK]�e�[�u������[PRODUCT_CODE], [MAKER_ID], [PC_NAME],
   [PC_TYPE], [SAL_VALUE], [SPEC], [STOCK_NUM]����������SQL��

--%>
<sql:query var="rs">
SELECT STOCK_NUM
  FROM PRODUCT_STOCK WHERE PRODUCT_CODE = ?;
<sql:param value="${formProductCode}" />
</sql:query>

<%-- �݌ɐ���ϐ�[stockNum]�Ɋi�[���� --%>
<c:choose>
  <c:when test="${rs.rowCount == 0}">
    <c:set var="stockNum" value="0" />
  </c:when>
  <c:otherwise>
    <c:set var="row" value="${rs.rows[0]}" />
    <c:set var="stockNum" value="${row.STOCK_NUM}" />
  </c:otherwise>
</c:choose>

<%--

  ���i�̏�����������
  [PRODUCT_INFO]�e�[�u������ [PRODUCT_CODE], [PRODUCT_NAME],
  [CATEGORY_NAME], [MAKER_NAME], [DETAIL], [MATERIAL], [SIZE], [IMAGE],
  [PRICE] �� [PRODUCT_CODE]�̏����Ō�������SQL���B

--%>
<sql:query var="rs">
SELECT PRODUCT_CODE, PRODUCT_NAME, CATEGORY_NAME, MAKER_NAME, DETAIL, MATERIAL, SIZE, IMAGE, PRICE
  FROM PRODUCT_INFO WHERE PRODUCT_CODE=? ORDER BY PRODUCT_CODE;
<sql:param value="${formProductCode}" />
</sql:query>

<%-- ��s�ڂ�ϐ�row�ɑ�� --%>
<c:set var="row" value="${rs.rows[0]}" />

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<TITLE>�ڍ׏��</TITLE>
<%--

  �\�����@�̐ݒ�

--%>
<STYLE type="text/css">
body {background-color:white;}
table {border-collapse:separate; border-spacing:2px; width:100%;}
th {background-color:#333333; align:center; font-size:large; font-weight:bold; color:white;}
td {background-color:#EFEFEF; font-size:normal; color:black;}
</STYLE>
</head>
<BODY>

		<H2>�ڍ׉��</H2>

<%--

  �ڍ׏����o�͂���

--%>
<%-- �摜���o�� --%>
<img src="image/${row.IMAGE}" /><BR>
<%-- ���[�J�[���o�� --%>
���[�J�[�F${row.MAKER_NAME}<BR>
<%-- ���i�����o�� --%>
���i���F${row.PRODUCT_NAME}<BR>
<%-- �f�ނ��o�� --%>
�f�ށF${row.MATERIAL}<BR>
<%-- �J�e�S�����o�� --%>
�J�e�S���F${row.CATEGORY_NAME}<BR>
<%-- �������o�� --%>
�����F${row.DETAIL}<BR><BR>

<%-- �̔����i���o�� --%>
�̔����i�F${row.PRICE}<BR>

<%--

  �݌ɐ����m�F���Č��ʂ�\������
  �݌ɐ���1��菭�Ȃ����ǂ����ō݌ɂ̊m�F���s���Ă���

--%>
<c:choose>
  <c:when test="${stockNum < 1}">
<%-- ���i�̍݌ɂ����݂��Ȃ��ꍇ�́A�i�؂�̏����o�͂��� --%>
�\���󂲂����܂���B${row.PRODUCT_NAME} �͕i�؂�ł��B<BR>
  </c:when>
  <c:otherwise>

	<FORM action="buy.jsp" method="POST">

<%--

  ���̍w���̃y�[�W�ɐ��i�R�[�h��n�����߂̏����@
  ��ʏ�ɂ͏o�͂���Ȃ�

--%>
<%-- ���i�R�[�h�̃f�[�^ --%>
<input type="hidden" name="hiddenCode" value="${row.PRODUCT_CODE}" />
<%-- ���i�̃f�[�^ --%>
<input type="hidden" name="hiddenPrice" value="${row.PRICE}" />

�w���Ҏ����F<input type="text" name="customerName" value="">
<BR>
<INPUT type="submit" name="buttonBuy" value="�w������">

	</FORM>

</c:otherwise>
</c:choose>

</BODY>
</HTML>