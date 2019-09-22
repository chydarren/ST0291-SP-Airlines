package dbaccess;

import java.sql.*;
import java.util.ArrayList;

public class LoggingDB {
	public ArrayList<Logging> getLogging() {
		Logging lBean = null;
		ArrayList<Logging> loggingcheck = new ArrayList<Logging>();
		Connection conn = null;
		PreparedStatement pst = null;
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost/spairlines?user=root&password=root&useSSL=false");
			String searchquery = "select * from (select * from logging order by LoggingID desc limit 10) logging order by LoggingID asc";
			pst = conn.prepareStatement(searchquery);
			ResultSet rs = pst.executeQuery(); 
			while (rs.next()) {
				lBean = new Logging();
				lBean.setLoggingID(rs.getInt("LoggingID"));
				lBean.setAdminID(rs.getString("AdminID"));
				lBean.setStatus(rs.getString("Status"));
				lBean.setDateAndTime(rs.getString("DateAndTime"));
				loggingcheck.add(lBean);
			}
	} catch (Exception e) {
	} finally {
		try {
			conn.close();
		} catch (Exception e) {}
	}
	return loggingcheck;
	}
}
