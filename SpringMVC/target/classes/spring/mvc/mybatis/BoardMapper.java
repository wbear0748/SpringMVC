package spring.mvc.mybatis;

import java.util.ArrayList;
import java.util.HashMap;

import spring.mvc.board.AttachFile;
import spring.mvc.board.Comment;
import spring.mvc.board.Post;

public interface BoardMapper {
	public ArrayList<Post> getPostList(HashMap<String, String> hashmap);
	
	public int getTotalRecord(HashMap<String, String> hashmap);
	// 게시글 목록
	
	// 게시글 관련 시작
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
	
	public Post getPrevPost(HashMap<String, String> hashmap);

	public Post getNextPost(HashMap<String, String> hashmap);
	// 게시글 관련 끝
	
	// 댓글 관련 시작
	public void increaseComment(int postno);
	
	public void decreaseComment(int postno);

	public void insertComment(Comment comment);
	
	public void replyComment(Comment comment);

	public void updateComment(Comment comment);
	
	public void hideComment(Comment comment);

	public int commentReplyCheck(Comment comment);
	
	public int parentDelCheck(Comment comment);
	
	public void deleteComment(int commentno);
	
	public void deleteHide(Comment comment);

	public Comment getComment(int commentno);

	public ArrayList<Comment> getCommentList(int postno);
	// 댓글 관련 끝
	
	// 첨부파일 관련
	public Post getNewPost();

	public void insertAttachFile(AttachFile attachFile);

	public ArrayList<AttachFile> getAttachFileList(int postno);
	
	public void deleteFile(Integer attachFileNo);
}
