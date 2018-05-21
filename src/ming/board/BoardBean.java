package ming.board;

import java.sql.Timestamp;

public class BoardBean {
	private int bno;
	private int no;
	private String bimage;
	private String contents;
	private Timestamp time;
	
	public BoardBean() {
	}
	
	public BoardBean(int no, String bimage, String contents, Timestamp time) {
		this.no = no;
		this.bimage = bimage;
		this.contents = contents;
		this.time = time;
	}

	public BoardBean(int bno, int no, String bimage, String contents, Timestamp time) {
		this.bno = bno;
		this.no = no;
		this.bimage = bimage;
		this.contents = contents;
		this.time = time;
	}
	public int getBno() {
		return bno;
	}
	public void setBno(int bno) {
		this.bno = bno;
	}
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public String getBimage() {
		return bimage;
	}
	public void setBimage(String bimage) {
		this.bimage = bimage;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	public Timestamp getTime() {
		return time;
	}
	public void setTime(Timestamp time) {
		this.time = time;
	}
	
	
}
