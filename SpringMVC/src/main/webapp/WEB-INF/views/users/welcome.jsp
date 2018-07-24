<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="Keywords" content="회원가입 환영" />
<meta name="Description" content="회원가입 환영" />
<link rel="stylesheet" href="../resources/css/screen.css" type="text/css" media="screen" />
<title>회원가입이 완료되었습니다.</title>
<script type="text/javascript">
//<![CDATA[
//]]>
</script>          
</head>
<body>
 
<div id="wrap">
 
    <div id="header">
        <%@ include file="../inc/header.jsp" %>
    </div>
 
    <div id="main-menu">
        <%@ include file="../inc/main-menu.jsp" %>
    </div>
 
    <div id="container">
        <div id="content" style="min-height: 800px;">
            <div id="url-navi">회원 > 회원가입 완료</div>
 
<!-- 본문 시작 -->
<h1>환영합니다.</h1>
이제 로그인하시면 회원 메뉴를 이용하실 수 있습니다.<br />
<input type="button" value="로그인" onclick="javascript:location.href='login'" />
<!--  본문 끝 -->
 
        </div><!-- content 끝 -->
    </div><!--  container 끝 -->
   
    <div id="sidebar">
       <c:choose>
				<c:when test="${empty check}">
					<%@ include file="notLoginUsers-menu.jsp"%>
				</c:when>
				<c:otherwise>
					<%@ include file="loginUsers-menu.jsp"%>
				</c:otherwise>
			</c:choose>
    </div>
   
    <div id="extra">
        <%@ include file="../inc/extra.jsp" %>
    </div>
 
    <div id="footer">
        <%@ include file="../inc/footer.jsp" %>
    </div>
 
</div>
 
</body>
</html>