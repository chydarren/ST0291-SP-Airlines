package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dbaccess.Bk_flight;
import dbaccess.Bk_guest;

@WebServlet("/AddToCart_flight")
public class AddToCart_flight extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public AddToCart_flight() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession(); 
		
		// bk_flight information (with cart) 
		// declare array list 
		ArrayList<Bk_flight> flightdetails = new ArrayList<Bk_flight>(); 
		
		try{
			// get the flight parameters 
			int flight_departure = Integer.parseInt(request.getParameter("flight_departure"));
			int flight_arrival = 0; 
			String strflight_arrival = request.getParameter("flight_arrival");
			if(strflight_arrival != null){
				flight_arrival = Integer.parseInt(strflight_arrival);
			}
			String bk_seatType = (String) session.getAttribute("bk_seatType");
			int bk_noOfSeats = (int) session.getAttribute("bk_noOfSeats");
	
			// declare flight object
			Bk_flight flight_depart = new Bk_flight(0, flight_departure, bk_seatType, bk_noOfSeats); 
			Bk_flight flight_arrive = null; 
			if(strflight_arrival != ""){
				flight_arrive = new Bk_flight(0, flight_arrival, bk_seatType, bk_noOfSeats); 
			}
		
			// add flight object to bk_flight cart 
			flightdetails.add(flight_depart);
			flightdetails.add(flight_arrive);
			
			// store bk_flight cart into session 
			session.setAttribute("flightcart",flightdetails);
		
			// booking session tracker
			session.setAttribute("welcomestat", null);
			session.setAttribute("track-flight", null);
			session.setAttribute("track-guest", "YES");
						
			// redirect
			RequestDispatcher rd = request.getRequestDispatcher("files_guest/bk_guest.jsp");
			rd.forward(request,response);
			
		}catch(Exception e){
			
			// reset 
			session.setAttribute("flightcart", null);
			session.setAttribute("track-flight", "YES");
			session.setAttribute("track-guest", null);
			
			// redirect
			session.setAttribute("flightstat", "NO");
			RequestDispatcher rd = request.getRequestDispatcher("files_guest/bk_flight.jsp");
			rd.forward(request,response);
		}
		
	}
}
