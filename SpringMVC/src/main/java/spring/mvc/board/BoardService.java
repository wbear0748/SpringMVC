package spring.mvc.board;

import java.util.ArrayList;

import spring.mvc.commons.PagingHelper;

public interface BoardService {
	public ArrayList<Post> getPostList(String boardcode, String searchWord, int start, int end);
	
	public int getTotalRecord(String boardcode, String searchWord);
	
	//게시글 목록 불러오기
	
	//게시글 관련 시작
	public int insert(Post post);
	
	public int reply(Post post);
	
	public void update(Post post);

	public void delete(int postno);
	
	public int replyCheck(Post post);
	
	public void hidePost(Post post);
	
	public int deleteHidePost(Post post);

	public String getBoardName(String boardcode);

	public void increaseHits(int postno);

	public Post getPost(int postno);
	
	public Post getPrevPost(int postno, String boardcode, String searchWord);

	public Post getNextPost(int postno, String boardcode, String searchWord);
	
	// 게시글 관련 끝
	
	// 댓글 관련 시작
	
	public void increaseComment(int postno);
	
	public void decreaseComment(int postno);

	public void insertComment(Comment comment);

	public void replyComment(Comment comment);
	
	public void updateComment(Comment comment);

	public int commentReplyCheck(Comment comment);
	
	public int parentDelCheck(Comment comment);
	
	public void deleteComment(int commentno);
	
	public void deleteHide(Comment comment);
	
	public void hideComment(Comment comment);

	public Comment getComment(int commentno);

	public ArrayList<Comment> getCommentList(int postno);
	
	// 댓글 관련 끝
	
	// 페이징 관련 시작
	public int getListNo();

	public int getPrevLink();

	public int getFirstPage();

	public int getLastPage();

	public int getNextLink();

	public int[] getPageLinks();

	public void setPagingHelper(PagingHelper pagingHelper);
	
	// 페이징 관련 끝
	
	// 첨부파일 관련 시작
	public Post getNewPost();

	public void insertAttachFile(AttachFile attachFile);

	public ArrayList<AttachFile> getAttachFileList(int postno);
	
	public void deleteFile(Integer attachFileNo);
	 



}
