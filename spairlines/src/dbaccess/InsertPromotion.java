package dbaccess;
import java.sql.*;

// public class 
public class InsertPromotion {
	
	// promotion information
	public boolean setPromotion(Bk_promotion promotion){
		
		// initialize variables 
		int count=0; 
		String insertstr = "INSERT INTO bk_promotion (promotion_startdate, promotion_enddate, promotion_departure_country, promotion_arrival_country,"
				+ "cabin_cost, seat_type) VALUES (?,?,?,?,?,?)";
		
		// insert data into bk_promotion database 
		try{
			Class.forName("com.mysql.jdbc.Driver");
			Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/spairlines?user=root&password=root");
			PreparedStatement pst = conn.prepareStatement(insertstr);
			pst.setString(1, promotion.getPromotion_startdate());
			pst.setString(2, promotion.getPromotion_enddate());
			pst.setString(3, promotion.getPromotion_departure_country());
			pst.setString(4, promotion.getPromotion_arrival_country());
			pst.setLong(5, promotion.getCabin_cost());
			pst.setString(6, promotion.getSeat_type());
			count = pst.executeUpdate(); 
			return count > 0;
		}catch(Exception e){
			return false; 
		}
	}
	
	// promotion information
	public boolean deletePromotion(int promotion_id){
		
		// initialize variables 
		int count = 0;
		String delstr = "DELETE FROM bk_promotion WHERE promotion_id = ?";
		
		// delete data from bk_promotion database 
		try{
			Class.forName("com.mysql.jdbc.Driver");
			Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/spairlines?user=root&password=root");
			PreparedStatement pst = conn.prepareStatement(delstr);
			pst.setInt(1, promotion_id);
			count = pst.executeUpdate(); 
			return count > 0;
		}catch(Exception e){
			return false; 
		}
	}
}
