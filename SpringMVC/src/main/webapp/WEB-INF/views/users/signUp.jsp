<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="Keywords" content="회원가입" />
<meta name="Description" content="회원가입" />
<link rel="stylesheet" href="../resources/css/screen.css"
	type="text/css" media="screen" />
<title>회원가입</title>
<script src="http://code.jquery.com/jquery-1.11.2.min.js"></script>
<script src="http://code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
<script type="text/javascript">
	//<![CDATA[
	var changeId;	
	var changeNickname;
	
	function check() {
		var form = document.getElementById("signUpForm");
		//TODO 유효성 검사
		if(changeId != form.userid.value) {
			form.checkIdFlag.value = 0;
		}
		
		if(changeNickname != form.nickname.value) {
			form.checkNicknameFlag.value = 0;
		}
		
		if (form.checkIdFlag.value == 0) {
			alert("아이디 중복검사를 해야합니다.");
			$("#userid").focus();
			return false;
		}
		if (form.checkNicknameFlag.value == 0) {
			alert("닉네임 중복검사를 해야합니다.");
			$("#nickname").focus();
			return false;
		}
		if (form.pwd.value != form.confirm.value) {
			alert("비밀번호가 일치하지 않습니다.");
			$("#pwd").focus();
			return false;
		}
		return true;
	}
	
	function checkId_click() {
		var form = document.getElementById("signUpForm");
		
		changeId = form.userid.value;
	}
	
	function checkNickname_click() {
		var form = document.getElementById("signUpForm");
		
		changeNickname = form.nickname.value;
	}
	
	// 아이디 중복체크
	$(document).ready(function() {
		$("#checkid").click(function() {
			if ($("#userid").val()) {
				var query = {
					userid : $("#userid").val()
				};
				$.ajax({
					url : "/checkId",
					type : "post",
					data : query,
					success : function(data) {
						if (data == 1) {
							alert("사용할 수 없는 아이디입니다.");
							$("#userid").val("");
							$("#checkIdFlag").val("0");
							$("#userid").focus();
						} else if (data == 0) {
							alert("사용할 수 있는 아이디입니다.");
							$("#checkIdFlag").val("1");
							$("#nickname").focus();
						}
					},
					error : function(request, error) {
						alert("연결실패...");
						alert("message:" + request.responseText);
					}
				});
			} else {
				alert("아이디를 입력해주세요.");
				$("#userid").focus();
			}
		});
	});

	// 닉네임 중복체크
	$(document).ready(function() {
		$("#checknickname").click(function() {
			if ($("#nickname").val()) {
				var query = {
					nickname : $("#nickname").val()
				};
				$.ajax({
					url : "/checkNickname",
					type : "post",
					data : query,
					success : function(data) {
						if (data == 1) {
							alert("사용할 수 없는 닉네임입니다.");
							$("#nickname").val("");
							$("#checkNicknameFlag").val("0");
							$("#nickname").focus();
						} else if (data == 0) {
							alert("사용할 수 있는 닉네임입니다.");
							$("#checkNicknameFlag").val("1");
							$("#pwd").focus();
						}
					},
					error : function(request, error) {
						alert("연결실패...");
						alert("message:" + request.responseText);
					}
				});
			} else {
				alert("닉네임을 입력해주세요.");
				$("#nickname").focus();
			}
		});
	});

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
				<div id="url-navi">회원 > 회원가입</div>

				<!-- 본문 시작 -->
				<h1>회원가입</h1>
				<form id="signUpForm" action="signUp" method="post"
					onsubmit="return check()">
					<input type="hidden" id="checkIdFlag" name="checkIdFlag" value="0">
					<input type="hidden" id="checkNicknameFlag" name="checkNicknameFlag" value="0">
					<table>
						<tr>
							<td>아이디 (ID)</td>
							<td><input type="text" id="userid" name="userid"
								style="width: 120px;" autofocus required /> <input type="button"
								id="checkid" value="중복확인" onclick="checkId_click();" /></td>
						</tr>
						<tr>
							<td>닉네임 (Nickname)</td>
							<td><input type="text" id="nickname" name="nickname"
								style="width: 120px;" required /> <input type="button"
								id="checknickname" value="중복확인" onclick="checkNickname_click();" /></td>
						</tr>
						<tr>
							<td colspan="3" style="text-align: center; font-weight: bold;">
								아이디와 닉네임은 바꿀 수 없습니다. 신중하게 선택하세요.</td>
						</tr>
						<tr>
							<td>비밀번호 (Password)</td>
							<td><input type="password" id="pwd" name="pwd"
								style="width: 120px;" required /></td>
						</tr>
						<tr>
							<td>비밀번호 확인 (Confirm)</td>
							<td><input type="password" id="confirm" name="confirm"
								style="width: 120px;" required /></td>
						</tr>
						<tr>
							<td style="width: 150px;">이름(Name)</td>
							<td style="width: 440px"><input type="text" id="name"
								name="name" style="width: 80px;" required /></td>
						</tr>
						<tr>
							<td>이메일 (Email)</td>
							<td><input type="text" id="email" name="email"
								style="width: 180px;" required /></td>
						</tr>
						<tr>
							<td>전화번호 (Phone)</td>
							<td><input type="text" id="phone" name="phone"
								style="width: 180px;" required /></td>
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