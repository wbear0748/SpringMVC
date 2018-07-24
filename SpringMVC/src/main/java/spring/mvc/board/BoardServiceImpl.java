package spring.mvc.board;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import spring.mvc.commons.PagingHelper;
import spring.mvc.mybatis.BoardMapper;

@Service
public class BoardServiceImpl implements BoardService {

	@Autowired
	private BoardMapper boardMapper;

	private PagingHelper pagingHelper;

	public ArrayList<Post> getPostList(String boardcode, String searchWord, int start, int end) {
		Integer startRownum = start;
		Integer endRownum = end;

		HashMap<String, String> hashmap = new HashMap<String, String>();
		hashmap.put("boardcode", boardcode);
		hashmap.put("searchWord", searchWord);
		hashmap.put("start", startRownum.toString());
		hashmap.put("end", endRownum.toString());

		return boardMapper.getPostList(hashmap);
	}

	public int getTotalRecord(String boardcode, String searchWord) {
		HashMap<String, String> hashmap = new HashMap<String, String>();
		hashmap.put("boardcode", boardcode);
		hashmap.put("searchWord", searchWord);

		return boardMapper.getTotalRecord(hashmap);
	}

	public int insert(Post post) {
		return boardMapper.insert(post);
	}

	public int reply(Post post) {
		return boardMapper.reply(post);
	}

	public void update(Post post) {
		boardMapper.update(post);

	}

	public void delete(int postno) {
		boardMapper.delete(postno);
	}
	
	public int replyCheck(Post post) {
		return boardMapper.replyCheck(post);
	}
	
	public void hidePost(Post post) {
		boardMapper.hidePost(post);
	}
	
	public int deleteHidePost(Post post) {
		return boardMapper.deleteHidePost(post);
	}

	public String getBoardName(String boardcode) {
		return boardMapper.getBoardName(boardcode);
	}

	public void increaseHits(int postno) {
		boardMapper.increaseHits(postno);
	}

	public Post getPost(int postno) {
		return boardMapper.getPost(postno);
	}

	public Post getPrevPost(int postno, String boardcode, String searchWord) {
		HashMap<String, String> hashmap = new HashMap<String, String>();
		Integer no = postno;
		hashmap.put("postno", no.toString());
		hashmap.put("boardcode", boardcode);
		hashmap.put("searchWord", searchWord);

		return boardMapper.getPrevPost(hashmap);
	}

	public Post getNextPost(int postno, String boardcode, String searchWord) {
		HashMap<String, String> hashmap = new HashMap<String, String>();
		Integer no = postno;
		hashmap.put("postno", no.toString());
		hashmap.put("boardcode", boardcode);
		hashmap.put("searchWord", searchWord);

		return boardMapper.getNextPost(hashmap);
	}

	public void increaseComment(int postno) {
		boardMapper.increaseComment(postno);
	}

	public void decreaseComment(int postno) {
		boardMapper.decreaseComment(postno);
	}

	public void insertComment(Comment comment) {
		boardMapper.insertComment(comment);
	}

	public void replyComment(Comment comment) {
		boardMapper.replyComment(comment);
	}

	public void updateComment(Comment comment) {
		boardMapper.updateComment(comment);
	}

	public void hideComment(Comment comment) {
		boardMapper.hideComment(comment);
	}

	public int commentReplyCheck(Comment comment) {
		return boardMapper.commentReplyCheck(comment);
	}

	public int parentDelCheck(Comment comment) {
		return boardMapper.parentDelCheck(comment);
	}

	public void deleteComment(int commentno) {
		boardMapper.deleteComment(commentno);
	}

	public void deleteHide(Comment comment) {
		boardMapper.deleteHide(comment);
	}

	public Comment getComment(int commentno) {
		return boardMapper.getComment(commentno);
	}

	public ArrayList<Comment> getCommentList(int postno) {
		return boardMapper.getCommentList(postno);
	}

	public int getListNo() {
		return pagingHelper.getListNo();
	}

	public int getPrevLink() {
		return pagingHelper.getPrevLink();
	}

	public int getFirstPage() {
		return pagingHelper.getFirstPage();
	}

	public int getLastPage() {
		return pagingHelper.getLastPage();
	}

	public int getNextLink() {
		return pagingHelper.getNextLink();
	}

	public int[] getPageLinks() {
		return pagingHelper.getPageLinks();
	}

	public PagingHelper getPagingHelper() {
		return pagingHelper;
	}

	public void setPagingHelper(PagingHelper pagingHelper) {
		this.pagingHelper = pagingHelper;
	}

	public Post getNewPost() {
		return boardMapper.getNewPost();
	}

	public void insertAttachFile(AttachFile attachFile) {
		boardMapper.insertAttachFile(attachFile);
	}
	
	public ArrayList<AttachFile> getAttachFileList(int postno) {
		return boardMapper.getAttachFileList(postno);
	}
	
	public void deleteFile(Integer attachFileNo) {
		boardMapper.deleteFile(attachFileNo);
	}
}
