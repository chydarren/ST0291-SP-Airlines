package dbaccess;

import java.sql.*;
import java.util.ArrayList;

public class AdminBookingsDB {
	public ArrayList<AdminBookings> getBookingDetails(String flightscheduleid, String cabin) {
		AdminBookings aBean = null;
		ArrayList<AdminBookings> bookinglist = new ArrayList<AdminBookings>();
		Connection conn = null;
		PreparedStatement pst = null;
		int scheduleid = 0;
		if (!(flightscheduleid.equals(""))){
			scheduleid = Integer.parseInt(flightscheduleid);
		}
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost/spairlines?user=root&password=root&useSSL=false");
			String searchquery = null;
			if(flightscheduleid.equals("") && cabin == null){
				searchquery = "select bf.*, bg.guest_firstname, bg.guest_lastname, bc.contact_email from bk_flightbk bf inner join bk_guest bg on bf.flight_bk_id = bg.booking_ref_id inner join bk_contact bc on bg.booking_ref_id = bc.booking_ref_id";
			} else if(flightscheduleid.equals("")){
				searchquery = "select bf.*, bg.guest_firstname, bg.guest_lastname, bc.contact_email from bk_flightbk bf inner join bk_guest bg on bf.flight_bk_id = bg.booking_ref_id inner join bk_contact bc on bg.booking_ref_id = bc.booking_ref_id where bk_seatType=?";
			} else if(cabin == null){
				searchquery = "select bf.*, bg.guest_firstname, bg.guest_lastname, bc.contact_email from bk_flightbk bf inner join bk_guest bg on bf.flight_bk_id = bg.booking_ref_id inner join bk_contact bc on bg.booking_ref_id = bc.booking_ref_id where flightschedule_id=?";
			} else {
				searchquery = "select bf.*, bg.guest_firstname, bg.guest_lastname, bc.contact_email from bk_flightbk bf inner join bk_guest bg on bf.flight_bk_id = bg.booking_ref_id inner join bk_contact bc on bg.booking_ref_id = bc.booking_ref_id where flightschedule_id=? and bk_seatType=?";
			}
			pst = conn.prepareStatement(searchquery);
			if(flightscheduleid.equals("") && cabin == null){
				pst = conn.prepareStatement(searchquery);
			} else if(flightscheduleid.equals("")){
				pst = conn.prepareStatement(searchquery);
				pst.setString(1, cabin);
			} else if(cabin == null){
				pst = conn.prepareStatement(searchquery);
				pst.setInt(1, scheduleid);
			} else {
				pst = conn.prepareStatement(searchquery);
				pst.setInt(1, scheduleid);
				pst.setString(2, cabin);
			}
			ResultSet rs = pst.executeQuery(); 
			while (rs.next()) {
				aBean = new AdminBookings();
				aBean.setflight_bk_id(rs.getInt("flight_bk_id"));
				aBean.setflightschedule_id(rs.getInt("flightschedule_id"));
				aBean.setbk_seatType(rs.getString("bk_seatType"));
				aBean.setbk_noOfSeats(rs.getInt("bk_noOfSeats"));
				aBean.setFirstname(rs.getString("guest_firstname"));
				aBean.setLastname(rs.getString("guest_lastname"));
				aBean.setEmail(rs.getString("contact_email"));
				bookinglist.add(aBean);
			}
		} catch (Exception e) {
		} finally {
			try {
				conn.close();
			} catch (Exception e) {}
		}
		return bookinglist;
	}
}