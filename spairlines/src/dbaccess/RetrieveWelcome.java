package dbaccess;

import java.sql.*;
import java.util.ArrayList;

public class RetrieveWelcome {
	// book single trip 
	public ArrayList<Bk_welcome> getBookingDetailsSingle(String flight_fromcountry, String flight_tocountry, int bk_noOfSeats, String bk_seatType, String flight_departuredate, Long promotion_cost){
		Bk_welcome bBean = null;
		ArrayList<Bk_welcome> bookingList = new ArrayList<Bk_welcome>();
		Connection conn = null;
		try {
			PreparedStatement pst = null;
			String selectstr = null;
			if(flight_departuredate.equals("")){
				selectstr = "SELECT * FROM flightschedule WHERE departure_country = ? AND arrival_country = ?";
			} else {
				selectstr = "SELECT * FROM flightschedule WHERE departure_country = ? AND arrival_country = ? AND SUBSTRING(departure_datetime, 1, 10) = ?";
			}
			if(bk_seatType.equals("economy_cost")){
				selectstr += " AND economy_count >= ?";
			} else if (bk_seatType.equals("business_cost")){
				selectstr += " AND business_count >= ?";
			} else {
				selectstr += " AND first_count >= ?";
			}
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost/spairlines?user=root&password=root");
			pst = conn.prepareStatement(selectstr);
			if (flight_departuredate.equals("")){
				pst.setString(1, flight_fromcountry);
				pst.setString(2, flight_tocountry);
				pst.setInt(3, bk_noOfSeats);
			} else {
				pst.setString(1, flight_fromcountry);
				pst.setString(2, flight_tocountry);
				pst.setString(3, flight_departuredate);
				pst.setInt(4, bk_noOfSeats);
			}	
			ResultSet rs = pst.executeQuery();
			while (rs.next()) {
				bBean = new Bk_welcome();
				bBean.setFlightschedule_id(rs.getInt("flightschedule_id"));
				bBean.setAircraft_id(rs.getInt("aircraft_id"));
				bBean.setAircraft_flightno(rs.getString("aircraft_flightno"));
				bBean.setDeparture_iata(rs.getString("departure_IATA"));
				bBean.setDeparture_airport(rs.getString("departure_airport"));
				bBean.setDeparture_terminal(rs.getString("departure_terminal").charAt(0));
				bBean.setDeparture_country(rs.getString("departure_country"));
				bBean.setDeparture_city(rs.getString("departure_city"));
				bBean.setArrival_iata(rs.getString("arrival_IATA"));
				bBean.setArrival_airport(rs.getString("arrival_airport"));
				bBean.setArrival_terminal(rs.getString("arrival_terminal").charAt(0));
				bBean.setArrival_country(rs.getString("arrival_country"));
				bBean.setArrival_city(rs.getString("arrival_city"));
				if(promotion_cost!=null){
					bBean.setCabin_cost(promotion_cost*bk_noOfSeats);
				}else{
					bBean.setCabin_cost(rs.getLong(bk_seatType)*bk_noOfSeats);
				}
				bBean.setDeparture_datetime(rs.getString("departure_datetime"));
				bBean.setArrival_datetime(rs.getString("arrival_datetime"));
				bBean.setFlight_time(rs.getString("flight_time"));
				bookingList.add(bBean);
			}		
		} catch (Exception e) {
		} finally {
			try {
				conn.close();
			} catch (Exception e) {}
		}
		return bookingList;
	}
	
	// book multi-way trip 
	public ArrayList<Bk_welcome> getBookingDetailsReturn(String flight_fromcountry, String flight_tocountry, int bk_noOfSeats, String bk_seatType, String flight_departuredate, String flight_returndate, Long promotion_cost){
		Bk_welcome bBean = null;
		ArrayList<Bk_welcome> bookingList = new ArrayList<Bk_welcome>();
		Connection conn = null;
		try {
			PreparedStatement pst = null;
			String selectstr = "SELECT * FROM flightschedule WHERE ";
			if (flight_departuredate.equals("") && flight_returndate.equals("")) {
				selectstr += "(departure_country = ? AND arrival_country = ?) OR (departure_country = ? AND arrival_country = ?)";
			} else if (flight_departuredate.equals("")) {
				selectstr += "(departure_country = ? AND arrival_country = ?) OR (departure_country = ? AND arrival_country = ? AND SUBSTRING(departure_datetime, 1, 10) = ?)";
			} else if (flight_returndate.equals("")) {
				selectstr += "(departure_country = ? AND arrival_country = ? AND SUBSTRING(departure_datetime, 1, 10) = ?) OR (departure_country = ? AND arrival_country = ?)";
			} else {
				selectstr += "(departure_country = ? AND arrival_country = ? AND SUBSTRING(departure_datetime, 1, 10) = ?) OR (departure_country = ? AND arrival_country = ? AND SUBSTRING(departure_datetime, 1, 10) = ?)";
			}
			if(bk_seatType.equals("economy_cost")){
				selectstr += " AND economy_count >= ?";
			} else if (bk_seatType.equals("business_cost")){
				selectstr += " AND business_count >= ?";
			} else {
				selectstr += " AND first_count >= ?";
			}
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost/spairlines?user=root&password=root");
			pst = conn.prepareStatement(selectstr);
			if (flight_departuredate.equals("") && flight_returndate.equals("")) {
				pst.setString(1, flight_fromcountry);
				pst.setString(2, flight_tocountry);
				pst.setString(3, flight_tocountry);
				pst.setString(4, flight_fromcountry);
				pst.setInt(5, bk_noOfSeats);
			} else if (flight_departuredate.equals("")) {
				pst.setString(1, flight_fromcountry);
				pst.setString(2, flight_tocountry);
				pst.setString(3, flight_tocountry);
				pst.setString(4, flight_fromcountry);
				pst.setString(5, flight_returndate);
				pst.setInt(6, bk_noOfSeats);
			} else if (flight_returndate.equals("")) {
				pst.setString(1, flight_fromcountry);
				pst.setString(2, flight_tocountry);
				pst.setString(3, flight_departuredate);
				pst.setString(4, flight_tocountry);
				pst.setString(5, flight_fromcountry);
				pst.setInt(6, bk_noOfSeats);
			} else if (flight_departuredate.equals("") && flight_returndate.equals("")) {
				pst.setString(1, flight_fromcountry);
				pst.setString(2, flight_tocountry);
				pst.setString(3, flight_tocountry);
				pst.setString(4, flight_fromcountry);
				pst.setInt(5, bk_noOfSeats);
			} else {
				pst.setString(1, flight_fromcountry);
				pst.setString(2, flight_tocountry);
				pst.setString(3, flight_departuredate);
				pst.setString(4, flight_tocountry);
				pst.setString(5, flight_fromcountry);
				pst.setString(6, flight_returndate);
				pst.setInt(7, bk_noOfSeats);
			}
			ResultSet rs = pst.executeQuery();
			while (rs.next()) {
				bBean = new Bk_welcome();
				bBean.setFlightschedule_id(rs.getInt("flightschedule_id"));
				bBean.setAircraft_id(rs.getInt("aircraft_id"));
				bBean.setAircraft_flightno(rs.getString("aircraft_flightno"));
				bBean.setDeparture_iata(rs.getString("departure_IATA"));
				bBean.setDeparture_airport(rs.getString("departure_airport"));
				bBean.setDeparture_terminal(rs.getString("departure_terminal").charAt(0));
				bBean.setDeparture_country(rs.getString("departure_country"));
				bBean.setDeparture_city(rs.getString("departure_city"));
				bBean.setArrival_iata(rs.getString("arrival_IATA"));
				bBean.setArrival_airport(rs.getString("arrival_airport"));
				bBean.setArrival_terminal(rs.getString("arrival_terminal").charAt(0));
				bBean.setArrival_country(rs.getString("arrival_country"));
				bBean.setArrival_city(rs.getString("arrival_city"));
				if(promotion_cost!=null){
					bBean.setCabin_cost(promotion_cost*bk_noOfSeats);
				}else{
					bBean.setCabin_cost(rs.getLong(bk_seatType)*bk_noOfSeats);
				}
				bBean.setDeparture_datetime(rs.getString("departure_datetime"));
				bBean.setArrival_datetime(rs.getString("arrival_datetime"));
				bBean.setFlight_time(rs.getString("flight_time"));
				bookingList.add(bBean);
			}		
		} catch (Exception e) {
		} finally {
			try {
				conn.close();
			} catch (Exception e) {}
		}
		return bookingList;
	}
	
}
