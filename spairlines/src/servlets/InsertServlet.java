package servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dbaccess.Bk_contact;
import dbaccess.Bk_flight;
import dbaccess.Bk_guest;
import dbaccess.Bk_payment;
import dbaccess.InsertBooking;

@WebServlet("/InsertServlet")
public class InsertServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public InsertServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
		try {
			// insert booking instance
			HttpSession session = request.getSession(); 
			InsertBooking bk_payment_ins = new InsertBooking();
			
			// declare array list
			boolean[] confirmation = new boolean[4];
			
			// insert bk_flight information 
			ArrayList<Bk_flight> flightdetails = (ArrayList<Bk_flight>) session.getAttribute("flightcart");
			String bk_seatType = (String) session.getAttribute("bk_seatType");
			confirmation[0] = bk_payment_ins.setFlight(flightdetails, bk_seatType);
			
			// insert bk_payment information
			Bk_payment payment = (Bk_payment) session.getAttribute("paymentinfo");
			confirmation[1] = bk_payment_ins.setPayment(payment);
			
			// insert bk_contact information
			Bk_contact contact = (Bk_contact) session.getAttribute("contactinfo");
			String flight_tripType = (String) session.getAttribute("flight_tripType");
			confirmation[2] = bk_payment_ins.setContact(contact, flight_tripType);
			
			// insert bk_guest information 
			ArrayList<Bk_guest> guestdetails = (ArrayList<Bk_guest>)session.getAttribute("guestcart"); 
			confirmation[3] = bk_payment_ins.setGuest(guestdetails);
			
			// booking success and retrieve booking_ref_id
			if(confirmation[0] == true && confirmation[1] == true && confirmation[2] == true && confirmation[3] == true){
				session.setAttribute("success", "yes");
				Class.forName("com.mysql.jdbc.Driver");
				Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/spairlines?user=root&password=root");
				PreparedStatement pstcontact = conn.prepareStatement("SELECT booking_ref_id FROM bk_contact ORDER BY booking_ref_id DESC LIMIT 1");
				ResultSet rs = pstcontact.executeQuery();
				if(rs.next()){
					session.setAttribute("booking_ref_id",rs.getInt(1)); 
				}
				conn.close();
			}else{
				session.setAttribute("success", "no");
			}
			
			// redirect 
			RequestDispatcher rd = request.getRequestDispatcher("files_guest/bk_confirmation.jsp");
			rd.forward(request,response);
			
		}catch(Exception e){
			System.err.println("Error:" + e);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
