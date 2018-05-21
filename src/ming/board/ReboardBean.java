package ming.board;

public class ReboardBean {
	private int rno;
	private int bno;
	private int no;
	private String name;
	private String contents;
	public ReboardBean(int rno, int bno, int no, String name, String contents) {
		this.rno = rno;
		this.bno = bno;
		this.no = no;
		this.name = name;
		this.contents = contents;
	}
	public int getRno() {
		return rno;
	}
	public void setRno(int rno) {
		this.rno = rno;
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
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
	
}
