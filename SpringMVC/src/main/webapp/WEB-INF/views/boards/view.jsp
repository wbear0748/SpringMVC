<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="Keywords" content="게시판 상세보기" />
<meta name="Description" content="게시판 상세보기" />
<link rel="stylesheet" href="../resources/css/screen.css"
	type="text/css" media="screen" />
<title>${boardname }</title>
<script type="text/javascript">
	//<![CDATA[

	function download(filename) {

		var form = document.getElementById("downForm")

		form.filename.value = filename;

		form.submit();

	}

	function deleteAttachFile(attachFileNo) {
		var chk = confirm("정말로 삭제하시겠습니까?");
		if (chk == true) {
			var form = document.getElementById("deleteAttachFileForm");
			form.attachFileNo.value = attachFileNo;
			form.submit();
		}
	}

	function goList(page) {
		var form = document.getElementById("listForm");
		form.curPage.value = page;
		form.submit();
	}

	function check() {
		alert("로그인 후에 이용해주시기 바랍니다.");
		return false;
	}

	function deleteComment(commentno) {
		var chk = confirm("정말로 삭제하시겠습니까?");
		if (chk == true) {
			var form = document.getElementById("deleteCommentForm");
			form.commentno.value = commentno;
			form.submit();
		}
	}

	function updateComment(no) {
		var modifyno = "modifycontents" + no;
		var modifyele = document.getElementById(modifyno);

		var commentno = "comment" + no;
		var formno = "modifyCommentForm" + no;
		var pele = document.getElementById(commentno);
		var formele = document.getElementById(formno);

		if (formele.style.display == 'none') {
			pele.style.display = 'none';
			formele.style.display = 'block';
			modifyele.focus();
			modifyele.value = modifyele.value;
		} else {
			pele.style.display = 'block';
			formele.reset();
			formele.style.display = 'none';
		}
	}

	function replyComment(no) {
		var contentsno = "commentcontents" + no;
		var contentsele = document.getElementById(contentsno);
		var formno = "replyCommentForm" + no;
		var formele = document.getElementById(formno);
		if (formele.style.display == 'none') {
			formele.style.display = 'block';
			contentsele.focus();
		} else {
			formele.style.display = 'none';
			contentsele.value = '';
		}
	}

	function goWrite() {
		var form = document.getElementById("writeForm");
		form.submit();
	}

	function goReply() {
		var form = document.getElementById("replyForm");
		form.submit();
	}

	function goView(postno) {
		var form = document.getElementById("viewForm");
		form.postno.value = postno;
		form.submit();
	}

	function goModify() {
		var form = document.getElementById("modifyForm");
		form.submit();
	}

	function goDelete() {
		var chk = confirm("정말로 삭제하시겠습니까?");
		if (chk == true) {
			var form = document.getElementById("deleteForm");
			form.submit();
		}
	}

	//]]>
</script>
</head>
<body>
	<%@ page import="spring.mvc.user.User"%>
	<%
		User user = (User) session.getAttribute("check");
		if (user != null) {
			pageContext.setAttribute("nick", user.getNickname());
		}
	%>
	<div id="wrap">

		<div id="header">
			<%@ include file="../inc/header.jsp"%>
		</div>

		<div id="main-menu">
			<%@ include file="../inc/main-menu.jsp"%>
		</div>

		<div id="container">
			<div id="content" style="min-height: 800px;">
				<div id="url-navi">게시판 > ${boardname } > 상세보기</div>

				<!-- 본문 시작 -->
				<h1>${boardname }</h1>
				<div id="bbs">
					<table>
						<tr>
							<th style="width: 50px;">TITLE</th>
							<th style="text-align: left; color: #555; width:360px; word-break:break-all">${thisPost.title }</th>
							<th style="width: 50px;">DATE</th>
							<th style="width: 130px; color: #555;">${thisPost.writeDateTime }</th>
						</tr>
					</table>

					<div id="gul-content">
						<h6>작성자 ${thisPost.writer }, 조회수 ${thisPost.hits }</h6>
						<p style="width: 590px; margin-top: 20px; margin-bottom: 40px; word-break:break-all">${thisPost.contents }</p>
						<c:if test="${thisPost.question != null }">
							<hr />
							<p style="overflow:auto; max-height:250px; word-break:break-all">${thisPost.question }</p>
							<hr />
						</c:if>
						<p id="file-list" style="text-align: right;">
							<c:forEach var="file" items="${attachFileList }" varStatus="status">
								<a href="javascript:download('${file.filename }')">${file.filename }</a>
								<c:if test="${thisPost.writer eq nick}">
									<input type="button" value="x" onclick="deleteAttachFile('${file.attachFileNo }')" />
								</c:if>
								<br />
							</c:forEach>
						</p>
						<table style="margin-bottom:20px; margin-top:30px">
						<tr>
							<td>
								<c:if test="${thisPost.writer eq nick}">
									<input type="button" value="수정" onclick="goModify()" />
									<input type="button" value="삭제" onclick="goDelete()" />
								</c:if>
							</td>
							<td style="text-align:right">
								<input type="button" value="목록"
									onclick="location='list?boardcode=${boardcode}'" />
								<c:choose>
									<c:when test="${empty check}">
										<input type="button" value="새글쓰기" onclick="check()" />
										<input type="button" value="답글쓰기" onclick="check()" />
									</c:when>
									<c:otherwise>
										<input type="button" value="새글쓰기" onclick="goWrite()" />
										<input type="button" value="답글쓰기" onclick="goReply()" />
									</c:otherwise>
								</c:choose>
							</td>
						</tr>
						</table>
					</div>
					
					<!--  덧글 반복 시작 -->
					<c:forEach var="comment" items="${commentList }" varStatus="status">
						<c:choose>
							<c:when test="${comment.division2 == null }">
								<div class="comments" style="margin-bottom:5px; border:1px solid #86B404;">
							</c:when>
							<c:otherwise>
								<div class="comments" style="margin-left:50px; margin-bottom:5px; background:#E6E6E6; border:1px solid #BDBDBD;">
							</c:otherwise>
						</c:choose>
						
						<c:choose>
							<c:when test="${comment.del eq 0 }">
							<h4>${comment.commentwriter }</h4>
							<h5>${comment.writeDateTime }</h5>
							</c:when>
							<c:otherwise>
							<h4>삭제된 코멘트</h4>
							<h5> </h5>
							</c:otherwise>
						</c:choose>
							<h6>
							<c:if test="${comment.del eq 0 }">
								<c:if test="${comment.commentwriter eq nick}">
									<a href="javascript:updateComment('${comment.commentno }')">수정</a>
									| <a href="javascript:deleteComment('${comment.commentno }')">삭제</a>
								</c:if>
							</c:if>
							</h6>
						<c:choose>
							<c:when test="${comment.del eq 0 }">
								<p id="comment${comment.commentno }">${comment.htmlContent }</p>
							</c:when>
							<c:otherwise>
								<p id="comment${comment.commentno }">삭제된 코멘트입니다.</p>
							</c:otherwise>
						</c:choose>
						

							<div class="modify-comment">
								<form id="modifyCommentForm${comment.commentno }"
									action="commentUpdate" method="post" style="display: none;">
									<p>
										<input type="hidden" name="commentno" value="${comment.commentno }" />
										<input type="hidden" name="boardcode" value="${param.boardcode }" />
										<input type="hidden" name="postno" value="${param.postno }" />
										<input type="hidden" name="curPage" value="${param.curPage }" />
										<input type="hidden" name="searchWord" value="${param.searchWord }" />
									</p>
									<div class="fr">
									<c:choose>
										<c:when test="${comment.division2 == null }">
											<input type="submit" value="수정하기" style="font-family:'돋움'; cursor:pointer; padding:0; border:0; outline:none; font-size:11px; background-color:white;" onmouseover="this.style.textDecoration='underline'" onmouseout="this.style.textDecoration='none'" />
										</c:when>
										<c:otherwise>
											<input type="submit" value="수정하기" style="font-family:'돋움'; cursor:pointer; padding:0; border:0; outline:none; font-size:11px; background-color:#E6E6E6;" onmouseover="this.style.textDecoration='underline'" onmouseout="this.style.textDecoration='none'" />
										</c:otherwise>
									</c:choose>
										| <a href="javascript:updateComment('${comment.commentno }')">취소</a>
									</div>
									<div>
										<textarea class="modify-comment-ta" name="commentcontents" id="modifycontents${comment.commentno }"
											rows="7" cols="50" style="resize:none;" required>${comment.commentcontents }</textarea>
									</div>
								</form>
							</div>
							<c:if test="${comment.division2 == null }">
							<c:choose>
								<c:when test="${empty check }">
									<c:if test="${comment.del eq 0 }">
										<p style="text-align:right;"><a href="javascript:check()" style="color:#555555;">[답변]</a></p>
									</c:if>
								</c:when>
								<c:otherwise>
									<c:if test="${comment.del eq 0 }">
										<p style="text-align:right;"><a href="javascript:replyComment('${comment.division1 }')" style="color:#555555;">[답변]</a></p>
									</c:if>
								</c:otherwise>
							</c:choose>
							</c:if>
							<div class="modify-comment">
								<form id="replyCommentForm${comment.division1 }"
									action="commentReply" method="post" style="display: none;">
									<p>
										<input type="hidden" name="division1" value="${comment.division1 }" />
										<input type="hidden" name="commentno" value="${comment.commentno }" />
										<input type="hidden" name="boardcode" value="${param.boardcode }" />
										<input type="hidden" name="postno" value="${param.postno }" />
										<input type="hidden" name="curPage" value="${param.curPage }" />
										<input type="hidden" name="searchWord" value="${param.searchWord }" />
									</p>
									<div class="fr">
										<input type="submit" value="등록" style="font-family:'돋움'; cursor:pointer; padding:0; border:0; outline:none; font-size:11px; background-color:white;" onmouseover="this.style.textDecoration='underline'" onmouseout="this.style.textDecoration='none'" />
										| <a href="javascript:replyComment('${comment.division1 }')">취소</a>
									</div>
									<div>
										<textarea class="modify-comment-ta" name="commentcontents" id="commentcontents${comment.division1 }"
											rows="7" cols="50" style="resize:none;" required></textarea>
									</div>
								</form>
							</div>
						</div>
					</c:forEach>
					<!-- 덧글 반복 끝 -->

					<form id="addCommentForm" action="commentAdd" method="post">
						<p style="margin: 0; padding: 0;">
							<input type="hidden" name="postno" value="${param.postno }" />
							<input type="hidden" name="boardcode" value="${param.boardcode }" />
							<input type="hidden" name="curPage" value="${param.curPage }" />
							<input type="hidden" name="searchWord" value="${param.searchWord }" />
						</p>
						<c:choose>
							<c:when test="${empty check}">
								<div id="addComment" style="border: solid; color: #BDBDBD">
									<textarea name="commentcontents" rows="4" cols="50"
										style="resize: none" placeholder="로그인 후에 이용해주시기 바랍니다."></textarea>
								</div>
								<div style="text-align: right;">
									<input type="button" value="댓글남기기" onclick="check()" />
								</div>
							</c:when>
							<c:otherwise>
								<div id="addComment" style="border: solid; color: #BDBDBD">
									<textarea name="commentcontents" rows="4" cols="50"
										style="resize: none; outline-style:none;" required></textarea>
								</div>
								<div style="text-align: right;">
									<input type="submit" value="댓글남기기" />
								</div>
							</c:otherwise>
						</c:choose>
					</form>
					<c:choose>
						<c:when test="${thisPost.division2 == null }">
							<div id="next-prev">
							
								<c:if test="${nextPost != null }">
									<p>
										다음글 : <a href="javascript:goView('${nextPost.postno }')">${nextPost.title }</a>
									</p>
								</c:if>
								<c:if test="${prevPost != null }">
									<p>
										이전글 : <a href="javascript:goView('${prevPost.postno }')">${prevPost.title }</a>
									</p>
								</c:if>
							</div>
						</c:when>
						<c:otherwise>
							<br>
						</c:otherwise>
					</c:choose>
				<div id="view-menu">
						<div class="fl">
							<c:if test="${thisPost.writer eq nick}">
								<input type="button" value="수정" onclick="goModify()" />
								<input type="button" value="삭제" onclick="goDelete()" />
							</c:if>
						</div>
						<div class="fr">
							<input type="button" value="목록" onclick="goList('${param.curPage }')" />
							<c:choose>
								<c:when test="${empty check}">
									<input type="button" value="새글쓰기" onclick="check()" />
									<input type="button" value="답글쓰기" onclick="check()" />
								</c:when>
								<c:otherwise>
									<input type="button" value="새글쓰기" onclick="goWrite()" />
									<input type="button" value="답글쓰기" onclick="goReply()" />
								</c:otherwise>
							</c:choose>
						</div>
					</div>

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
									<td style="text-align: center;">
										<c:if test="${param.postno == post.postno }">
											<img src="../resources/images/arrow.gif" alt="현재글" />
										</c:if>
									</td>
									<td>
										<span style="display:block; width:300px; overflow:hidden; text-overflow:ellipsis; white-space:nowrap;">
											<c:forEach begin="1" end="${fn:length(post.division2) }" step="1">
									      	  &nbsp;&nbsp;
									    	</c:forEach>
										<c:choose>
											<c:when test="${post.del eq 0 }">
												<a href="javascript:goView('${post.postno }')">
												<img src="../resources/images/reply-arrow.png" width="10px" height="10px" />
												${post.title }
													<c:if test="${post.attachFileNum > 0 }">
														<img src="../resources/images/attach.png" alt="첨부파일" />
													</c:if>
													<c:if test="${post.commentcount!=0}">
														<span class="bbs-strong">[${post.commentcount }]</span>
													</c:if>
												</a>
											</c:when>
											<c:otherwise>
												<img src="../resources/images/reply-arrow.png" width="10px" height="10px" /><i> 삭제된 게시글입니다.</i>
											</c:otherwise>
										</c:choose>
									</span>
								</td>
								<td style="text-align: center;"><c:if test="${post.del eq 0}">${post.writer }</c:if></td>
								<td style="text-align: center;"><c:if test="${post.del eq 0}">${post.writeDate }</c:if></td>
								<td style="text-align: center;"><c:if test="${post.del eq 0}">${post.hits }</c:if></td>
							</tr>
							</c:when>
							<c:otherwise>
								<tr>
								<td style="text-align: center;"><c:choose>
											<c:when test="${param.postno == post.postno }">
												<img src="../resources/images/arrow.gif" alt="현재글" />
											</c:when>
											<c:otherwise>
										    	${post.division1 }
										    </c:otherwise>
										</c:choose>
									</td>
								<td>
									<c:choose>
										<c:when test="${post.del eq 0 }">
											<a href="javascript:goView('${post.postno }')" style="display:block; width:300px; overflow:hidden; text-overflow:ellipsis; white-space:nowrap;">${post.title }
												<c:if test="${post.attachFileNum > 0 }">
													<img src="../resources/images/attach.png" alt="첨부파일" />
												</c:if>
												<c:if test="${post.commentcount!=0}">
													<span class="bbs-strong">[${post.commentcount }]</span>
												</c:if>
											</a>
										</c:when>
										<c:otherwise>
											<i>삭제된 게시글입니다.</i>
										</c:otherwise>
									</c:choose>
								</td>
								<td style="text-align: center;"><c:if test="${post.del eq 0}">${post.writer }</c:if></td>
								<td style="text-align: center;"><c:if test="${post.del eq 0}">${post.writeDate }</c:if></td>
								<td style="text-align: center;"><c:if test="${post.del eq 0}">${post.hits }</c:if></td>
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
							<c:when test="${param.curPage == i}">
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
						<input type="button" value="새글쓰기" onclick="goWrite()" />
					</div>
				<div id="search" style="text-align: center;">
					<form id="searchForm" action="./list" method="get" style="margin: 0; padding: 0;">
						<p style="margin: 0; padding: 0;">
							<input type="hidden" name="boardcode" value="${param.boardcode }" />
							<input type="text" name="searchWord" size="15" maxlength="30" />
							<input type="submit" value="검색" />
						</p>
					</form>
				</div>

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
		<form id="downForm" action="./download" method="post">
			<p>
				<input type="hidden" name="filename">
			<p>
		</form>

		<form id="listForm" action="./list" method="get">
			<p>
				<input type="hidden" name="boardcode" value="${param.boardcode }" />
				<input type="hidden" name="curPage" />
				<input type="hidden" name="searchWord" value="${param.searchWord }" />
			</p>
		</form>

		<form id="writeForm" action="./writeForm" method="post">
			<p>
				<input type="hidden" name="boardcode" value="${param.boardcode }" />
			</p>
		</form>
		<form id="replyForm" action="./replyForm" method="post">
			<p>
				<input type="hidden" name="boardcode" value="${param.boardcode }" />
				<input type="hidden" name="curPage" value="${param.curPage }" />
				<input type="hidden" name="division1" value="${thisPost.division1 }" />
				<c:if test="${thisPost.division2 != null }">
					<input type="hidden" name="division2" value="${thisPost.division2 }" />
				</c:if>
				<input type="hidden" name="writer" value="${thisPost.writer }" />
				<input type="hidden" name="title" value="${thisPost.title }" />
				<input type="hidden" name="contents" value="${thisPost.htmlContent }" />
				<input type="hidden" name="curPage" value="${param.curPage }" />
				<input type="hidden" name="searchWord" value="${param.searchWord }" />
			</p>
		</form>
		<form id="viewForm" action="./view" method="get">
			<p>
				<input type="hidden" name="postno" />
				<input type="hidden" name="boardcode" value="${param.boardcode }" />
				<input type="hidden" name="curPage" value="${param.curPage }" />
				<input type="hidden" name="searchWord" value="${param.searchWord }" />
			</p>
		</form>
		<form id="modifyForm" action="./modifyForm" method="post">
			<p>
				<input type="hidden" name="postno" value="${param.postno }" />
				<input type="hidden" name="boardcode" value="${param.boardcode }" />
				<input type="hidden" name="curPage" value="${param.curPage }" />
				<input type="hidden" name="searchWord" value="${param.searchWord }" />
			</p>
		</form>
		<form id="deleteForm" action="./delete" method="get">
			<p>
				<input type="hidden" name="postno" value="${param.postno }" />
				<input type="hidden" name="boardcode" value="${param.boardcode }" />
				<input type="hidden" name="curPage" value="${param.curPage }" />
				<input type="hidden" name="searchWord" value="${param.searchWord }" />
			</p>
		</form>

		<form id="deleteCommentForm" action="commentDel" method="post">
			<p>
				<input type="hidden" name="commentno" />
				<input type="hidden" name="postno" value="${param.postno }" />
				<input type="hidden" name="boardcode" value="${param.boardcode }" />
				<input type="hidden" name="curPage" value="${param.curPage }" />
				<input type="hidden" name="searchWord" value="${param.searchWord }" />
			</p>
		</form>

		<form id="deleteAttachFileForm" action="attachFileDel" method="post">
			<p>
				<input type="hidden" name="attachFileNo" />
				<input type="hidden" name="postno" value="${param.postno }" />
				<input type="hidden" name="boardcode" value="${param.boardcode }" />
				<input type="hidden" name="curPage" value="${param.curPage }" />
				<input type="hidden" name="searchWord" value="${param.searchWord }" />
			</p>
		</form>

	</div>

</body>
</html>