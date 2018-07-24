<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="Keywords" content="비밀번호 변경" />
<meta name="Description" content="비빌번호 변경" />
<link rel="stylesheet" href="../resources/css/screen.css"
	type="text/css" media="screen" />
<title>비밀번호 변경</title>
<script type="text/javascript">
	//<![CDATA[
	function check() {
		var form = document.getElementById("changePasswordForm");
		if (form.pwd.value == form.confirm.value) {
			return true;
		} else {
			alert("[변경 비밀번호]와 [변경 비밀번호 확인]값이 같지 않습니다.");
			return false;
		}
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
				<div id="url-navi">회원 > 비밀번호 변경</div>

				<!-- 본문 시작 -->
				<h1>비밀번호 변경</h1>
				${check.nickname}님은 로그인 상태입니다.<br /> 아이디 ${check.userid}<br /> 이름
				${check.name}<br /> 이메일 ${check.email}<br /> 전화번호 ${check.phone}<br />
				<form id="changePasswordForm" action="changePwd" method="post"
					onsubmit="return check()">
					<table>
						<tr>
							<td>변경 비밀번호</td>
							<td><input type="password" name="pwd" required /></td>
						</tr>
						<tr>
							<td>변경 비밀번호 확인</td>
							<td><input type="password" name="confirm" required /></td>
						</tr>
						<tr>
							<td colspan="2"><input type="submit" value="확인" /></td>
						</tr>
					</table>
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