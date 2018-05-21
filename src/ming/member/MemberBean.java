package ming.member;

public class MemberBean {
	private int no;
	private String id;
	private String name;
	private String email;
	private String password;
	private String image;
	private String intro;
	
	public MemberBean() {
	}
	
	
	public MemberBean(int no, String id, String name, String email, String password, String image, String intro) {
		this.no = no;
		this.id = id;
		this.name = name;
		this.email = email;
		this.password = password;
		this.image = image;
		this.intro = intro;
	}


	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getImage() {
		return image;
	}
	public void setImage(String image) {
		this.image = image;
	}
	public String getIntro() {
		return intro;
	}
	public void setIntro(String intro) {
		this.intro = intro;
	}
	
	
}
