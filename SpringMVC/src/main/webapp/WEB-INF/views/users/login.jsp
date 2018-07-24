<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="Keywords" content="로그인" />
<meta name="Description" content="로그인" />
<link rel="stylesheet" href="../resources/css/screen.css"
	type="text/css" media="screen" />
<title>로그인</title>
<script type="text/javascript">
	//<![CDATA[
	function login() {
		var form = document.getElementById("loginForm");
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
				<div id="url-navi">회원 > 로그인</div>

				<!-- 본문 시작 -->
				<h1>로그인</h1>
				<form id="loginForm" action="login" method="post"
					onsubmit="return login()">
					<table>
						<tr>
							<td style="width: 295px; text-align: right">아이디(ID) &nbsp; &nbsp; &nbsp; &nbsp;</td>
							<td style="width: 295px"><input type="text" name="userid"
								style="width: 120px" autofocus required /></td>
						</tr>
						<tr>
							<td style="text-align: right">비밀번호(Password) &nbsp;&nbsp;</td>
							<td><input type="password" name="pwd" style="width: 120px" required /></td>
						</tr>
					</table>
					<br>
					<div style="text-align: center; padding-bottom: 15px;">
						<input type="submit" value="확인" /> <input type="button"
							value="회원가입" onclick="location.href='signUp'" />
					</div>
				</form>
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