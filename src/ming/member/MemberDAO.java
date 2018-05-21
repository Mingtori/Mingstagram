package ming.member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import com.oreilly.servlet.MultipartRequest;

public class MemberDAO {
	private Connection conn;
	private DataSource dataFactory;
	
	private static MemberDAO instance; 
	
	private MemberDAO(){
		try{
			Context initContext = new InitialContext();
			Context envContext = (Context)initContext.lookup("java:/comp/env");
			dataFactory = (DataSource)envContext.lookup("jdbc/OracleDB");
			conn = dataFactory.getConnection();
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	public static MemberDAO getInstance() {
		if(instance==null){
			instance = new MemberDAO();
		}
		return instance;
	}
	
	private MemberBean getMemberBean(ResultSet rs) throws SQLException{
		return new MemberBean(rs.getInt("no"),
				rs.getString("id"), 
				rs.getString("name"), 
				rs.getString("email"),
				rs.getString("password"),
				rs.getString("image"),
				rs.getString("intro")
				);
	}
	// 프로필 수정
	public int updateMember(MultipartRequest mr, int flag, int no){
		int result=-1;
		
		if(flag==0){
			String sql="update member set name=?,password=?,intro=?,image=? where no=?";
			try {
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setString(1, mr.getParameter("name"));
				ps.setString(2, mr.getParameter("password"));
				ps.setString(3, mr.getParameter("intro").replace("\r\n", "<br>"));
				if(mr.getFilesystemName("image")!=null)
					ps.setString(4, mr.getFilesystemName("image"));
				else
					ps.setString(4, mr.getParameter("old_image"));
				ps.setString(5, mr.getParameter("no"));
				
				result = ps.executeUpdate();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}else{
			String sql="update member set image=? where no=?";
			try {
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setString(1,"basic.jpg");
				ps.setInt(2, no);
				result = ps.executeUpdate();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		return result;
	}
	
	
	// select by name
	public ArrayList<MemberBean> getMembersByName(String search){
		ArrayList<MemberBean> list = new ArrayList<>();
		String sql = "select * from member where name like ?";
		
		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, "%" + search + "%");
			ResultSet rs = ps.executeQuery();
			
			while(rs.next()){
				list.add(getMemberBean(rs));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return list;
	}
	
	// select by no
	public MemberBean getMemberByNo(int no){
		MemberBean member=null;
		String sql = "select * from member where no=?";
		
		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1, no);
			ResultSet rs = ps.executeQuery();
			
			if(rs.next()){
				member = getMemberBean(rs);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return member;
	}
	
	// login
	public MemberBean getMemberInfo(String id, String password){
		MemberBean member = null;
		
		String sql = "select * from member where id=? and password=?";
		
		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, id);
			ps.setString(2, password);
			
			ResultSet rs = ps.executeQuery();
			
			if(rs.next()){
				member = getMemberBean(rs);
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return member;
	}
	
	// 아이디 중복확인
	public boolean searchID(String id){
		boolean check = false;
		String sql="select id from member where id=?";
		
		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, id);
			ResultSet rs = ps.executeQuery();
			if(rs.next()){
				check=true;
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return check;
	}
	
	// 회원가입
	public int insertMember(MemberBean member){
		int result = -1;
		String sql = "insert into member(no,id,name,email,password) values(memseq.nextval,?,?,?,?)";
		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, member.getId());
			ps.setString(2, member.getName());
			ps.setString(3, member.getEmail());
			ps.setString(4, member.getPassword());
			
			result = ps.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return result;
	}
}
