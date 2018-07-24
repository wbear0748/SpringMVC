<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="Keywords" content="회원정보" />
<meta name="Description" content="회원정보" />
<link rel="stylesheet" href="../resources/css/screen.css"
	type="text/css" media="screen" />
<title>회원정보</title>
<script type="text/javascript">
	//<![CDATA[
	function check() {
		var form = document.getElementById("editAccountForm");
		//TODO 유효성 검사
		return true;
	}
	//]]>
</script>
</head>
<body>

	<div id="wrap">

		<div id="header">
			<%@ include file="../inc/header.jsp"%>
		</div>

		<div id="main-menu">
			<%@ include file="../inc/main-menu.jsp"%>
		</div>

		<div id="container">
			<div id="content" style="min-height: 800px;">
				<div id="url-navi">회원 > 회원정보</div>

				<!-- 본문 시작 -->
				<h1>회원정보</h1>
				
				<form id="editAccountForm" action="editAccount" method="post"
					onsubmit="return check()">
					<table>
						<tr>
							<td>아이디 (ID)</td>
							<td>: ${check.userid }</td>
						</tr>
						<tr>
							<td>이름 (Name)</td>
							<td>: ${check.name }</td>
						</tr>
						<tr>
							<td>닉네임 (Nickname)</td>
							<td>: ${check.nickname }</td>
						</tr>
						<tr>
							<td>이메일 (Email)</td>
							<td>: ${check.email }</td>
						</tr>
						<tr>
							<td>전화번호 (Phone)</td>
							<td>: ${check.phone }</td>
						</tr>
					</table>
				</form>
				<input type="button" value="회원정보 수정" onclick="location.href='/users/editAccount'" />
				<!--  본문 끝 -->

			</div>
			<!-- content 끝 -->
		</div>
		<!--  container 끝 -->

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
			<%@ include file="../inc/extra.jsp"%>
		</div>

		<div id="footer">
			<%@ include file="../inc/footer.jsp"%>
		</div>

	</div>
</body>
</html>