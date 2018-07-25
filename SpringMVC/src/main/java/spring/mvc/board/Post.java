package spring.mvc.board;

import java.text.SimpleDateFormat;
import java.util.Date;

public class Post {
	private int postno;
	private String title;
	private String contents;
	private String writer;
	private int hits;
	private Date writeday;
	private int division1;
	private String division2;
	private int commentcount;
	private int del;
	private int child;
	private String boardcode;
	private int attachFileNum;
	private String question;
	
	public static final String ENTER = System.getProperty("line.separator");
	
	public int getAttachFileNum() {
		return attachFileNum;
	}
	public void setAttachFileNum(int attachFileNum) {
		this.attachFileNum = attachFileNum;
	}
	public int getPostno() {
		return postno;
	}
	public void setPostno(int postno) {
		this.postno = postno;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public int getHits() {
		return hits;
	}
	public void setHits(int hits) {
		this.hits = hits;
	}
	public Date getWriteday() {
		return writeday;
	}
	public void setWriteday(Date writeday) {
		this.writeday = writeday;
	}
	public int getDivision1() {
		return division1;
	}
	public void setDivision1(int division1) {
		this.division1 = division1;
	}
	public String getDivision2() {
		return division2;
	}
	public void setDivision2(String division2) {
		this.division2 = division2;
	}
	public int getCommentcount() {
		return commentcount;
	}
	public void setCommentcount(int commentcount) {
		this.commentcount = commentcount;
	}
	public int getDel() {
		return del;
	}
	public void setDel(int del) {
		this.del = del;
	}
	public String getBoardcode() {
		return boardcode;
	}
	public void setBoardcode(String boardcode) {
		this.boardcode = boardcode;
	}
	public String getQuestion() {
		return question;
	}
	public void setQuestion(String question) {
		this.question = question;
	}
	public String getWriteDate() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		return sdf.format(writeday);
	}
	public String getWriteDateTime() {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        return sdf.format(writeday);
	}
	
    public String getHtmlContent() {
        if (contents != null) {
            return contents.replace("\"", "'");
        }
        return null;
    }
	
}
