<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<<script type="text/javascript" src="/resources/ckeditor/ckeditor.js"></script>

<h1 style="float: left;width: 150px;"><a href="/"><img src="/resources/images/ci.gif" alt="java-school logo" /></a></h1>
 
<div id="memberMenu" style="float: right;position: relative;top: 7px;">
<c:choose>
    <c:when test="${empty check}">
        <input type="button" value="로그인" onclick="location.href='/users/login'" />
        <input type="button" value="회원가입" onclick="location.href='/users/signUp'" />
    </c:when>
    <c:otherwise>
    	<td>${check.nickname }(${check.userid })님 반갑습니다!</td>
        <input type="button" value="로그아웃" onclick="location.href='/users/logout'" />
        <input type="button" value="회원정보" onclick="location.href='/users/memberInfo'" />
    </c:otherwise>
</c:choose>
</div>