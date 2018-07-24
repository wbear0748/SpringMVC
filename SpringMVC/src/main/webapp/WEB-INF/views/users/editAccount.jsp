<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="Keywords" content="회원정보 수정" />
<meta name="Description" content="회원정보 수정" />
<link rel="stylesheet" href="../resources/css/screen.css"
	type="text/css" media="screen" />
<title>회원정보 수정</title>
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
				<div id="url-navi">회원 > 회원정보 수정</div>

				<!-- 본문 시작 -->
				<h1>회원정보 수정</h1>
				<p>
					이름과 이메일과 전화번호만 변경할 수 있습니다.<br /> 비밀번호는 <a href="changePwd">비밀번호
						변경</a>을 이용하세요.<br />
				</p>
				<form id="editAccountForm" action="editAccount" method="post"
					onsubmit="return check()">
					<table>
						<tr>
							<td>이름(Name)</td>
							<td><input type="text" name="name" value="${check.name }"
								style="width: 80px;" /></td>
						</tr>
						<tr>
							<td>이메일(Email)</td>
							<td><input type="text" name="email" value="${check.email }"
								style="width: 180px;" required /></td>
						</tr>
						<tr>
							<td>전화번호(Phone)</td>
							<td><input type="text" name="phone" value="${check.phone }"
								style="width: 180px;" required /></td>
						</tr>
						<tr>
							<td style="width: 150px;">현재 비밀번호(Password)</td>
							<td style="width: 440px"><input type="password" name="pwd"
								style="width: 120px;" required /></td>
						</tr>
					</table>
					<br>
					<div style="text-align: center; padding-bottom: 15px;">
						<input type="submit" value="확인" />
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