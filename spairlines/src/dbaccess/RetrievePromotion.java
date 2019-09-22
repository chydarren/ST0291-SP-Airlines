package dbaccess;
import java.sql.*;
import java.util.ArrayList;

// public class 
public class RetrievePromotion {

	// promotions
	public ArrayList<Bk_promotion> getPromotions(){
		Bk_promotion bBean = null;
		ArrayList<Bk_promotion> promotionsList = new ArrayList<Bk_promotion>();
		Connection conn = null;
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost/spairlines?user=root&password=root");
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery("SELECT * FROM bk_promotion");
			while (rs.next()) {
				bBean = new Bk_promotion();
				bBean.setPromotion_id(rs.getInt("promotion_id"));
				bBean.setPromotion_startdate(rs.getString("promotion_startdate"));
				bBean.setPromotion_enddate(rs.getString("promotion_enddate"));
				bBean.setPromotion_departure_country(rs.getString("promotion_departure_country"));
				bBean.setPromotion_arrival_country(rs.getString("promotion_arrival_country"));
				bBean.setSeat_type(rs.getString("seat_type"));
				bBean.setCabin_cost(rs.getLong("cabin_cost"));
				promotionsList.add(bBean);
			}	
			conn.close();
			return promotionsList;
		} catch (Exception e) {
			return null;
		}
	}
}
