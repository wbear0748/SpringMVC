<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="Keywords" content="게시판 새글쓰기" />
<meta name="Description" content="게시판 새글쓰기" />
<link rel="stylesheet" href="../resources/css/screen.css"
	type="text/css" media="screen" />
<title>${boardname }</title>
<script type="text/javascript">
	//<![CDATA[
	function check() {
		var form = document.getElementById("writeForm");
		//유효성 검사로직 추가
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
				<div id="url-navi">게시판 > 글쓰기</div>

				<!-- 본문 시작 -->
				<h1>${boardname }</h1>
				<div id="bbs">
					<h2>글쓰기</h2>
					<c:choose>
						<c:when test="${param.division1 == null }">
							<form id="writeForm" action="write" method="post" enctype="multipart/form-data" onsubmit="return check()">
						</c:when>
						<c:otherwise>
							<form id="writeForm" action="reply" method="post" enctype="multipart/form-data" onsubmit="return check()">
						</c:otherwise>
					</c:choose>
						<p style="margin: 0; padding: 0;">
							<input type="hidden" name="boardcode" value="${param.boardcode }" />
							<c:if test="${param.division1 != null}">
								<input type="hidden" name="division1" value="${param.division1 }" />
							</c:if>
							<c:if test="${param.division2 != null}">
								<input type="hidden" name="division2" value="${param.division2 }" />
							</c:if>
							<c:if test="${param.curPage != null}">
								<input type="hidden" name="curPage" value="${param.curPage }" />
							</c:if>
							<c:if test="${param.searchWord != null}">
								<input type="hidden" name="searchWord" value="${param.searchWord }" />
							</c:if>
						</p>

						<table id="write-form">
							<tr>
								<td>제목${param.division1 }</td>
								<td>
								<c:choose>
									<c:when test="${param.division1 == null }">
										<input type="text" name="title" size="50" autofocus required />
									</c:when>
									<c:otherwise>
										<input type="text" name="title" size="50" value="re: ${param.title }" required />
									</c:otherwise>
								</c:choose>
								</td>
							</tr>
							<tr>
								<td colspan="2">
								<c:choose>
								<c:when test="${param.division1 != null }">
<pre style="border:1px solid">*${param.writer }님의 글입니다 .
${param.contents }</pre>
									<textarea name="contents" rows="25" style="resize: none" required autofocus></textarea>
								</c:when>
								<c:otherwise>
								<textarea name="contents" rows="17" style="resize: none" required></textarea>
								</c:otherwise>
								</c:choose>
								<script type="text/javascript">
									CKEDITOR.replace('contents');
								</script>
								</td>
							</tr>
							<tr>
								<td>파일첨부</td>
								<td><input type="file" name="upload" multiple/></td>
							</tr>
						</table>
						<div style="text-align: center; padding-bottom: 15px;">
							<input type="submit" value="전송" />
							<input type="button" value="목록" onclick="location='list?boardcode=${param.boardcode}'" />
						</div>
					</form>
				</div>
				<!-- bbs 끝 -->
				<!--  본문 끝 -->

			</div>
			<!-- content 끝 -->
		</div>
		<!--  container 끝 -->

		<div id="sidebar">
			<%@ include file="boards-menu.jsp"%>
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