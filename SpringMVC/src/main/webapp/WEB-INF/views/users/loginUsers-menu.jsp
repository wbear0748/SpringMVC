<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<h1>회원</h1>
<script type="text/javascript">
	//<![CDATA[
	function goBye() {
		var chk = confirm("정말로 탈퇴 하시겠습니까?");
		if (chk == true) {
			var form = document.getElementById("byeForm");
			form.submit();
		}
	}
	//]]>
</script>
	<div id="form-group" style="display: none;">
		<form id="byeForm" action="./bye" method="get">
		</form>
	</div>
<ul>
	<li>
		<ul>
			<li><a href="logout">로그아웃</a></li>
			<li><a href="editAccount">회원정보 수정</a></li>
			<li><a href="changePwd">비밀번호 변경</a></li>
			<li><a onclick="goBye()">탈퇴</a></li>
		</ul>
	</li>
</ul>