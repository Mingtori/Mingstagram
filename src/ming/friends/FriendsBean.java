package ming.friends;

public class FriendsBean {
	private int no1;
	private int no2;
	private String req;
	private String no1_name;
	private String no2_name;
	public FriendsBean() {
	}
	public FriendsBean(int no1, int no2, String req) {
		this.no1 = no1;
		this.no2 = no2;
		this.req = req;
	}
	
	public FriendsBean(int no1, String no1_name) {
		this.no1 = no1;
		this.no1_name = no1_name;
	}
	
	public FriendsBean(int no1, int no2, String req, String no1_name, String no2_name) {
		this.no1 = no1;
		this.no2 = no2;
		this.req = req;
		this.no1_name = no1_name;
		this.no2_name = no2_name;
	}
	public int getNo1() {
		return no1;
	}
	public void setNo1(int no1) {
		this.no1 = no1;
	}
	public int getNo2() {
		return no2;
	}
	public void setNo2(int no2) {
		this.no2 = no2;
	}
	public String getReq() {
		return req;
	}
	public void setReq(String req) {
		this.req = req;
	}
	public String getNo1_name() {
		return no1_name;
	}
	public void setNo1_name(String no1_name) {
		this.no1_name = no1_name;
	}
	public String getNo2_name() {
		return no2_name;
	}
	public void setNo2_name(String no2_name) {
		this.no2_name = no2_name;
	}
	
	
}
