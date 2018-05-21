package ming.friends;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class FriendsDAO {
	private Connection conn;
	private DataSource dataFactory;
	
	private static FriendsDAO instance; 
	
	private FriendsDAO(){
		try{
			Context initContext = new InitialContext();
			Context envContext = (Context)initContext.lookup("java:/comp/env");
			dataFactory = (DataSource)envContext.lookup("jdbc/OracleDB");
			conn = dataFactory.getConnection();
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	public static FriendsDAO getInstance() {
		if(instance==null){
			instance = new FriendsDAO();
		}
		return instance;
	}
	// 皋牢其捞瘤 模备格废
	public ArrayList<FriendsBean> getFriendsName(int no){
		ArrayList<FriendsBean> list = new ArrayList<>();
		String sql = "select tno, name ";
		sql += "from ((select tno ";
		sql += "from (select no1 as no, no2 as tno, req from friends where no1=? and req='FRIEND')) ";
		sql += "union ";
		sql += "(select tno ";
		sql += "from (select no2 as no, no1 as tno, req from friends where no2=? and req='FRIEND'))), member ";
		sql += "where tno=no";
		
		/*String sql = "select no1, name1, no2, name2, req ";
		sql += "from (select no1, name1, no2, req ";
		sql += "from friends f, (select no, name as name1 from member) m ";
		sql += "where f.no1=m.no) f, (select no, name as name2 from member) m ";
		sql += "where f.no2=m.no and (f.no1=? or f.no2=?) and req='FRIEND'";
		*/
		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1, no);
			ps.setInt(2, no);
			
			ResultSet rs = ps.executeQuery();
			while(rs.next()){
				list.add(new FriendsBean(rs.getInt("tno"), rs.getString("name")));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return list;
	}
	// 模备 夸没 秒家
	public int deleteFriend(String no1, String no2){
		int result = -1;
		String sql = "delete from friends where no1=? and no2=? and req='ADD'";
		
		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, no1);
			ps.setString(2, no2);
			result = ps.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return result;
	}
	
	// 模备 荐遏
	public int okFriend(String no1, String no2){
		int result = -1;
		String sql="update friends set req='FRIEND' where no1=? and no2=?";
		
		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,no1);
			ps.setString(2,no2);
			
			result = ps.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return result;
	}
	
	// 模备夸没格废
	public ArrayList<FriendsBean> getFriendByNo(int no){
		ArrayList<FriendsBean> list = new ArrayList<>();
		String sql="select * from friends where no1=? or no2=?";
		
		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1, no);
			ps.setInt(2, no);
			
			ResultSet rs = ps.executeQuery();
			while(rs.next()){
				list.add(new FriendsBean(rs.getInt(1), rs.getInt(2), rs.getString(3)));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return list;
	}
	
	// 模备 夸没
	public int insertFriend(String no1, String no2){
		int result=-1;
		String sql="insert into friends(no1,no2) values(?,?)";
		
		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, no1);
			ps.setString(2, no2);
			
			result = ps.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return result;
	}
}
