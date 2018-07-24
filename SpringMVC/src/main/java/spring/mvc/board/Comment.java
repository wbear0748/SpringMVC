package spring.mvc.board;

import java.text.SimpleDateFormat;
import java.util.Date;

public class Comment {
	private int commentno;
	private String commentwriter;
	private String commentcontents;
	private int division1;
	private Integer division2;
	private Date writeday;
	private int del;
	private int postno;

	public int getCommentno() {
		return commentno;
	}

	public void setCommentno(int commentno) {
		this.commentno = commentno;
	}

	public String getCommentwriter() {
		return commentwriter;
	}

	public void setCommentwriter(String commentwriter) {
		this.commentwriter = commentwriter;
	}

	public String getCommentcontents() {
		return commentcontents;
	}

	public void setCommentcontents(String commentcontents) {
		this.commentcontents = commentcontents;
	}

	public int getDivision1() {
		return division1;
	}

	public void setDivision1(int division1) {
		this.division1 = division1;
	}

	public Integer getDivision2() {
		return division2;
	}

	public void setDivision2(Integer division2) {
		this.division2 = division2;
	}

	public Date getWriteday() {
		return writeday;
	}

	public void setWriteday(Date writeday) {
		this.writeday = writeday;
	}

	public int getDel() {
		return del;
	}

	public void setDel(int del) {
		this.del = del;
	}

	public int getPostno() {
		return postno;
	}

	public void setPostno(int postno) {
		this.postno = postno;
	}

	public String getHtmlContent() {
		if (commentcontents != null) {
			return commentcontents.replace(Post.ENTER, "<br />");
		}
		return null;
	}

	public String getWriteDateTime() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		return sdf.format(writeday);
	}
}
