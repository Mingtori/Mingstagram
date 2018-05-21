package ming.board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class ReboardDAO {
	private Connection conn;
	private DataSource dataFactory;
	
	private static ReboardDAO instance; 
	
	private ReboardDAO(){
		try{
			Context initContext = new InitialContext();
			Context envContext = (Context)initContext.lookup("java:/comp/env");
			dataFactory = (DataSource)envContext.lookup("jdbc/OracleDB");
			conn = dataFactory.getConnection();
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	public static ReboardDAO getInstance() {
		if(instance==null){
			instance = new ReboardDAO();
		}
		return instance;
	}
	
	// 덧글쓰기
	public int insertReboard(String bno, int no, String contents){
		int result = -1;
		String sql="insert into reboard values(reb_seq.nextval,?,?,?)";
		
		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, bno);
			ps.setInt(2, no);
			ps.setString(3, contents);
			result=ps.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result;
	}
	
	// 해당 게시글 덧글 가져오기
	public ArrayList<ReboardBean> getReboardByBno(int bno){
		ArrayList<ReboardBean> list = new ArrayList<ReboardBean>();
		String sql = "select rno, bno, reboard.no, member.name, contents from reboard, member where reboard.no=member.no and bno=?";
		
		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1, bno);
			ResultSet rs = ps.executeQuery();
			
			while(rs.next()){
				list.add(new ReboardBean(rs.getInt(1), rs.getInt(2), rs.getInt(3), rs.getString(4), rs.getString(5)));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}
	
	// 덧글 지우기
	public int reboardDelete(String rno){
		int result = -1;
		String sql="delete from reboard where rno=?";
		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, rno);
			result = ps.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result;
	}
}
