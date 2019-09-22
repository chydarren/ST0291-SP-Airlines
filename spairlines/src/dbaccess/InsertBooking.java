package dbaccess;
import java.sql.*;
import java.util.ArrayList;

// public class 
public class InsertBooking {
	
	// flight information
	public boolean setFlight(ArrayList<Bk_flight> flights, String bk_seatType){
		
		// initialize variables 
		int count=0; 
		String insertstr = "INSERT INTO bk_flightbk (flightschedule_id, bk_seatType, bk_noOfSeats) VALUES (?,?,?)";
		String updatestr = "UPDATE flightschedule SET economy_count = economy_count - ? WHERE flightschedule_id = ?";
		if(bk_seatType.equals("Business")){
			updatestr = "UPDATE flightschedule SET business_count = business_count - ? WHERE flightschedule_id = ?";
		}else if(bk_seatType.equals("First")){
			updatestr = "UPDATE flightschedule SET first_count = first_count - ? WHERE flightschedule_id = ?";
		}
	
		try{
			// insert data into bk_flight database
			Class.forName("com.mysql.jdbc.Driver");
			Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/spairlines?user=root&password=root");
			PreparedStatement pst = conn.prepareStatement(insertstr); 
			for(Bk_flight flight : flights){
				if(flight.getFlightschedule_id()!=0){
					pst.setInt(1, flight.getFlightschedule_id());
					pst.setString(2, flight.getBk_seatType());
					pst.setInt(3, flight.getBk_noOfSeats());
					count = pst.executeUpdate();
				}
			}
			conn.close();
			
			// deduct seat count from flight schedule database 
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost/spairlines?user=root&password=root");
			PreparedStatement pstflightsched = conn.prepareStatement(updatestr);
			for(Bk_flight flight : flights){
				if(flight.getFlightschedule_id()!=0){
					pstflightsched.setInt(1, flight.getBk_noOfSeats());
					pstflightsched.setInt(2, flight.getFlightschedule_id());
					count = pstflightsched.executeUpdate();
				}
			}
			conn.close();
			return count>0;
		}catch(Exception e){
			System.err.println("Error:" + e);
			return false; 
		}
	}
	
	// payment information
	public boolean setPayment(Bk_payment payment){
		
		// initialize variables 
		int count=0;
		String insertstr = "INSERT INTO bk_payment (payment_card_holder, payment_card_no, payment_card_expdate, payment_card_cvv, payment_addr_address, "
				+ "payment_addr_postcode, payment_addr_residence, payment_addr_city, payment_addr_state, payment_total_cost) VALUES (?,?,?,?,?,?,?,?,?,?)";
		
		// insert data into bk_payment database 
		try{
			Class.forName("com.mysql.jdbc.Driver");
			Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/spairlines?user=root&password=root");
			PreparedStatement pst = conn.prepareStatement(insertstr);
			pst.setString(1, payment.getPayment_card_holder());
			pst.setString(2, payment.getPayment_card_no());
			pst.setString(3, payment.getPayment_card_expdate());
			pst.setInt(4, payment.getPayment_card_cvv());
			pst.setString(5, payment.getPayment_addr_address());
			if(payment.getPayment_addr_postcode()!=""){
				pst.setString(6, payment.getPayment_addr_postcode());
			}else{
				pst.setNull(6, Types.NVARCHAR);
			}
			pst.setString(7, payment.getPayment_addr_residence());
			pst.setString(8, payment.getPayment_addr_city());
			if(payment.getPayment_addr_state()!=""){
				pst.setString(9, payment.getPayment_addr_state());
			}else{
				pst.setNull(9, Types.NVARCHAR);
			} 
			pst.setLong(10, payment.getPayment_total_cost());
			count=pst.executeUpdate();
			conn.close();
			return count>0;
		}catch(Exception e){
			System.err.println("Error:" + e);
			return false; 
		}
	}
	
	// contact information
	public boolean setContact(Bk_contact contact, String flight_tripType){
		try{
			// initialize variables 
			int count=0;
			String insertstr = "INSERT INTO bk_contact (contact_email, contact_tel_ctry, contact_tel_area, contact_tel_hp,"
					+ "departure_flightbk_id, arrival_flightbk_id, payment_id) VALUES (?,?,?,?,?,?,?)";
			String selectstr = "SELECT payment_id FROM bk_payment ORDER BY payment_id DESC LIMIT 1";
			String selectstr2 = "SELECT flight_bk_id FROM bk_flightbk ORDER BY flight_bk_id DESC LIMIT 1";
			if(flight_tripType.equals("return")){
				selectstr2 = "SELECT flight_bk_id FROM bk_flightbk ORDER BY flight_bk_id DESC LIMIT 2";
			}
			int payment_id = 0;
			int[] flight_bk_ids = {0,0};
			
			// retrieve latest payment_id from bk_payment database   
			Class.forName("com.mysql.jdbc.Driver");
			Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/spairlines?user=root&password=root");
			PreparedStatement pstpayment = conn.prepareStatement(selectstr);
			ResultSet rs = pstpayment.executeQuery();
			if(rs.next()){
				payment_id = rs.getInt("payment_id"); 
			}
			conn.close(); 
			
			// retrieve latest flight_bk_id(s) from bk_flight database 
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost/spairlines?user=root&password=root");
			PreparedStatement pstflight = conn.prepareStatement(selectstr2);
			rs = pstflight.executeQuery();
			if(rs.next()){
				int i = 0; 
				do{
					flight_bk_ids[i] = rs.getInt("flight_bk_id");
					i++; 
				}while(rs.next());
			}
			
			// insert data into bk_contact database 
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost/spairlines?user=root&password=root");
			PreparedStatement pst = conn.prepareStatement(insertstr);
			pst.setString(1, contact.getContact_email());
			pst.setInt(2, contact.getContact_tel_ctry());
			if(contact.getContact_tel_area() != 0){
				pst.setInt(3, contact.getContact_tel_area());
			}else{
				pst.setNull(3, Types.INTEGER);
			}
			pst.setString(4, contact.getContact_tel_hp());
			if(flight_bk_ids[1]!=0){
				pst.setInt(5, flight_bk_ids[1]);
				pst.setInt(6, flight_bk_ids[0]);
			}else{
				pst.setInt(5, flight_bk_ids[0]);
				pst.setNull(6, Types.INTEGER);
			}
			pst.setInt(7, payment_id);
			count=pst.executeUpdate(); 
			conn.close(); 
			return count>0;  
		}catch(Exception e){
			System.err.println("Error:" + e);
			return false; 
		}
	}
	
	// guest information 
	public boolean setGuest(ArrayList<Bk_guest> guests){
		try{
			// initialize variables 
			String insertstr = "INSERT INTO bk_guest VALUES (?,?,?,?,?)";
			String selectstr = "SELECT booking_ref_id FROM bk_contact ORDER BY booking_ref_id DESC LIMIT 1";
			int booking_ref_id = 0, count=0; 
			
			// retrieve latest booking_ref_id from bk_contact database   
			Class.forName("com.mysql.jdbc.Driver");
			Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/spairlines?user=root&password=root");
			PreparedStatement pstcontact = conn.prepareStatement(selectstr);
			ResultSet rs = pstcontact.executeQuery();
			if(rs.next()){
				booking_ref_id = rs.getInt("booking_ref_id"); 
			}
			conn.close(); 
			
			// insert data into bk_guest database 
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost/spairlines?user=root&password=root");
			PreparedStatement pst = conn.prepareStatement(insertstr);
			for(Bk_guest guest : guests){
				pst.setString(1, guest.getGuest_passportno());
				pst.setInt(2, booking_ref_id);
				pst.setString(3, guest.getGuest_salutation());
				pst.setString(4, guest.getGuest_firstname());
				pst.setString(5, guest.getGuest_lastname());
				count=pst.executeUpdate();
			}
			conn.close();
			return count>0;
		}catch(Exception e){
			System.err.println("Error:" + e);
			return false;
		}
	}
}
