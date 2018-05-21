package ming.board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import com.oreilly.servlet.MultipartRequest;

public class BoardDAO {
	private Connection conn;
	private DataSource dataFactory;
	
	private static BoardDAO instance; 
	
	private BoardDAO(){
		try{
			Context initContext = new InitialContext();
			Context envContext = (Context)initContext.lookup("java:/comp/env");
			dataFactory = (DataSource)envContext.lookup("jdbc/OracleDB");
			conn = dataFactory.getConnection();
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	public static BoardDAO getInstance() {
		if(instance==null){
			instance = new BoardDAO();
		}
		return instance;
	}
	// 자기와 친구 글 불러오기
	public ArrayList<BoardBean> getBoardMeAndFriends(int no){
		ArrayList<BoardBean> list = new ArrayList<>();
		String sql = "select tno from ((select tno ";
		sql += "from (select no1 as no, no2 as tno, req from friends where no1=? and req='FRIEND')) ";
		sql += "union ";
		sql += "(select tno ";
		sql += "from (select no2 as no, no1 as tno, req from friends where no2=? and req='FRIEND')))";
		
		String sql2 = "select * from (";
		
		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1, no);
			ps.setInt(2, no);
			ResultSet rs = ps.executeQuery();
			while(rs.next()){
				sql2 += "(select * from board where no=" + rs.getInt("tno") + ") ";
				sql2 += "union ";
			}
			sql2+= "(select * from board where no=" + no + ")) order by time desc";
			System.out.println(sql2);
			ps = conn.prepareStatement(sql2);
			rs = ps.executeQuery();
			while(rs.next()){
				list.add(getBoardBean(rs));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
		
		return list;
	}
	
	// 로그인한 사용자의 글 불러오기
	public ArrayList<BoardBean> getBoardByNo(int no){
		ArrayList<BoardBean> list = null;
		String sql = "select * from board where no=? order by bno desc";
		
		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1, no);
			ResultSet rs = ps.executeQuery();
			
			list = new ArrayList<>();
			while(rs.next()){
				list.add(getBoardBean(rs));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}
	// 글 수정
	public int updateBoard(MultipartRequest mr, int flag, int bno){
		int result = -1;
		System.out.println(flag);
		if(flag==0){
			String sql = "update board set bimage=?, contents=? where bno=?";
			try {
				PreparedStatement ps = conn.prepareStatement(sql);
				if(mr.getFilesystemName("bimage")!=null){
					ps.setString(1, mr.getFilesystemName("bimage"));
					System.out.println(1 + "," +mr.getFilesystemName("bimage") + "," +mr.getParameter("old_bimage"));
				}
				else if(mr.getFilesystemName("bimage")==null && mr.getParameter("old_bimage").equals("null")){
					ps.setString(1, "");
					System.out.println(2 + "," +mr.getFilesystemName("bimage") + "," +mr.getParameter("old_bimage"));
				}
				else{
					ps.setString(1, mr.getParameter("old_bimage"));
					System.out.println(3 + "," +mr.getFilesystemName("bimage") + "," +mr.getParameter("old_bimage"));
				}
				ps.setString(2, mr.getParameter("contents").replace("\r\n", "<br>"));
				ps.setString(3, mr.getParameter("bno"));
				result = ps.executeUpdate();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}else{
			String sql = "update board set bimage=? where bno=?";
			try {
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setString(1, "");
				ps.setInt(2, bno);
				result = ps.executeUpdate();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		return result;
	}
	
	// 글 삭제
	public int deleteBoard(String bno){
		int result = -1;
		String sql = "delete from board where bno=?";
		
		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, bno);
			result = ps.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return result;
	}
	
	// 글쓰기
	public int insertBoard(int no, MultipartRequest mr){
		int result = -1;
		String sql = "insert into board values(boardseq.nextval,?,?,?,?)";
		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1, no);
			ps.setString(2, mr.getFilesystemName("bimage"));
			ps.setString(3, mr.getParameter("contents").replace("\r\n", "<br>"));
			ps.setTimestamp(4, new Timestamp(System.currentTimeMillis()));
			
			System.out.println(mr.getFilesystemName("bimage") + "," + mr.getParameter("contents"));
			
			result = ps.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result;
	}
	
	private BoardBean getBoardBean(ResultSet rs) throws SQLException{
		return new BoardBean(rs.getInt("bno"), rs.getInt("no"), rs.getString("bimage"), rs.getString("contents"), rs.getTimestamp("time"));
	}
}
