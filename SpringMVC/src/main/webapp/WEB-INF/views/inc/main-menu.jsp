<ol
	style="line-height: 19.2000007629395px; white-space: normal; margin-top: 0px;">
	<%@ page language="java" contentType="text/html; charset=UTF-8"
		pageEncoding="UTF-8"%>
	<ul id="nav">
		<li><a href="/">메인</a></li>
		<c:choose>
			<c:when test="${empty check}">
			<li><a href="/users/login">회원</a></li>
			</c:when>
			<c:otherwise>
			<li><a href="/users/memberInfo">회원</a></li>
			</c:otherwise>
		</c:choose>
		<li><a href="/boards/list">게시판</a></li>
	</ul>
</ol>