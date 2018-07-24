<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="Keywords" content="게시판 목록" />
<meta name="Description" content="게시판 목록" />
<link rel="stylesheet" href="../resources/css/screen.css" type="text/css" media="screen" />
<title>${boardname }</title>
<script type="text/javascript">
//<![CDATA[
	function check() {
		alert("로그인 후에 이용해주시기 바랍니다.");
		return false;
	}
	
	function goList(page) {
		var form = document.getElementById("listForm");
		form.curPage.value = page;
		form.submit();
	}
	
    function goWrite() {
        var form = document.getElementById("writeForm");
        form.submit();
    }
    
    function goView(postno) {
        var form = document.getElementById("viewForm");
        form.postno.value = postno;
        form.submit();
       
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
				<div id="url-navi">게시판 > ${boardname }</div>

				<!-- 본문 시작 -->
				<h1>${boardname }</h1>
				<div id="bbs">
					<table>
						<tr>
							<th style="width: 60px;">NO</th>
							<th>TITLE</th>
							<th style="width: 80px;">WRITE</th>
							<th style="width: 80px;">DATE</th>
							<th style="width: 60px;">HIT</th>
						</tr>
						<!--  반복 구간 시작 -->
						<c:forEach var="post" items="${list }" varStatus="status">

							<c:choose>
								<c:when test="${post.division2 != null }">
									<tr>
										<td style="text-align: center;"></td>
										<td>
											<span style="display: block; width: 300px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">
												<c:forEach begin="1" end="${fn:length(post.division2) }" step="1">
									      			&nbsp;&nbsp;
									    		</c:forEach>
									    		<a href="javascript:goView('${post.postno }')">
										    		<img src="../resources/images/reply-arrow.png" width="10px" height="10px" /> ${post.title }
										    		<c:if test="${post.attachFileNum > 0 }">
														<img src="../resources/images/attach.png" alt="첨부파일" />
													</c:if>
										    		<c:if test="${post.commentcount!=0}">
														<span class="bbs-strong">[${post.commentcount }]</span>
													</c:if>
												</a>
											</span>
										</td>
										<td style="text-align: center;">${post.writer }</td>
										<td style="text-align: center;">${post.writeDate }</td>
										<td style="text-align: center;">${post.hits }</td>
									</tr>
								</c:when>
								<c:otherwise>
									<tr>
										<td style="text-align: center;">${post.division1 }</td>
										<td><a href="javascript:goView('${post.postno }')" style="display: block; width: 300px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">${post.title }
												<c:if test="${post.attachFileNum > 0 }">
													<img src="../resources/images/attach.png" alt="첨부파일" />
												</c:if>
												<c:if test="${post.commentcount!=0}">
													<span class="bbs-strong">[${post.commentcount }]</span>
												</c:if>
												</a>
										</td>
										<td style="text-align: center;">${post.writer }</td>
										<td style="text-align: center;">${post.writeDate }</td>
										<td style="text-align: center;">${post.hits }</td>
									</tr>
								</c:otherwise>
							</c:choose>
						</c:forEach>
						<!--  반복 구간 끝 -->
					</table>

					<!--paging-->
					<div id="paging" style="text-align: center;">

						<c:if test="${prevLink > 0 }">
							<a href="javascript:goList('${prevPage }')">[이전]</a>
						</c:if>

						<c:forEach var="i" items="${pageLinks }" varStatus="stat">
							<c:choose>
								<c:when test="${curPage == i}">
									<span class="bbs-strong">${i }</span>
								</c:when>
								<c:otherwise>
									<a href="javascript:goList('${i }')">${i }</a>
								</c:otherwise>
							</c:choose>
						</c:forEach>

						<c:if test="${nextLink > 0 }">
							<a href="javascript:goList('${nextPage }')">[다음]</a>
						</c:if>

					</div>

					<div id="list-menu" style="text-align: right;">
						<c:choose>
							<c:when test="${empty check}">
								<input type="button" value="새글쓰기" onclick="check()" />
							</c:when>
							<c:otherwise>
								<input type="button" value="새글쓰기" onclick="goWrite()" />
							</c:otherwise>
						</c:choose>
					</div>
				</div>
				<div id="search" style="text-align: center;">
					<form id="searchForm" action="./list" method="get" style="margin: 0; padding: 0;">
						<p style="margin: 0; padding: 0;">
							<input type="hidden" name="boardcode" value="${boardcode }" />
							<input type="text" name="searchWord" size="15" maxlength="30" />
							<input type="submit" value="검색" />
						</p>
					</form>
				</div>
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

	<div id="form-group" style="display: none;">
		<form id="listForm" action="./list" method="get">
			<p>
				<input type="hidden" name="boardcode" value="${boardcode }" />
				<input type="hidden" name="curPage" />
				<input type="hidden" name="searchWord" value="${param.searchWord }" />
			</p>
		</form>
		<form id="writeForm" action="./writeForm" method="post">
			<p>
				<input type="hidden" name="boardcode" value="${boardcode }" />
				<input type="hidden" name="curPage" value="${curPage }" />
				<input type="hidden" name="searchWord" value="${param.searchWord }" />
			</p>
		</form>
		<form id="viewForm" action="./view" method="get">
			<p>
				<input type="hidden" name="postno" />
				<input type="hidden" name="boardcode" value="${boardcode }" />
				<input type="hidden" name="curPage" value="${curPage }" />
				<input type="hidden" name="searchWord" value="${param.searchWord }" />
			</p>
		</form>
	</div>
</body>
</html>