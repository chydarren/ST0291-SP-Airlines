package servlets;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dbaccess.Bk_welcome;
import dbaccess.RetrieveWelcome;

@WebServlet("/ObtainWelcomeServlet")
public class ObtainWelcomeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public ObtainWelcomeServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession(); 
		
		// bk_welcome information (with cart)
		// get the welcome parameters 
		ArrayList<Bk_welcome> bBean = null;
		String flight_fromcountry = request.getParameter("flight_fromcountry");
		String flight_tocountry = request.getParameter("flight_tocountry");
		int bk_noOfSeats = Integer.parseInt(request.getParameter("bk_noOfSeats"));
		String bk_seatType = request.getParameter("flight_radio1");
		String flight_tripType = request.getParameter("flight_radio2");
		String flight_departuredate = request.getParameter("flight_searchDepart");
		String flight_returndate = request.getParameter("flight_searchReturn");
		Long promotion_cost = null;
		if(session.getAttribute("promotion_cost")!=null){
			promotion_cost = (Long) session.getAttribute("promotion_cost");
		}
		
		// store key variables into session 
		session.setAttribute("flight_fromcountry", flight_fromcountry);
		session.setAttribute("flight_tocountry", flight_tocountry);
		session.setAttribute("bk_noOfSeats", bk_noOfSeats);
		session.setAttribute("flight_tripType", flight_tripType);
		if(bk_seatType.equals("economy_cost")){
			session.setAttribute("bk_seatType", "Economy");
			session.setAttribute("bk_seatColor", "#0b664b");
		}else if(bk_seatType.equals("business_cost")){
			session.setAttribute("bk_seatType", "Business");
			session.setAttribute("bk_seatColor", "#053870");
		}else{
			session.setAttribute("bk_seatType", "First");
			session.setAttribute("bk_seatColor", "#99422e");
		}
		session.setAttribute("flight_departuredate",flight_departuredate);
		session.setAttribute("flight_returndate",flight_returndate);
		
		try {
			// declare database retrieval object 
			RetrieveWelcome bdatabase = new RetrieveWelcome();
			if (flight_tripType.equals("single")) {
				bBean = bdatabase.getBookingDetailsSingle(flight_fromcountry, flight_tocountry, bk_noOfSeats, bk_seatType, flight_departuredate, promotion_cost);
			} else {
				bBean = bdatabase.getBookingDetailsReturn(flight_fromcountry, flight_tocountry, bk_noOfSeats, bk_seatType, flight_departuredate, flight_returndate, promotion_cost);
			}
			
			// store welcome object into session 
			session.setAttribute("flightsretrieved", bBean);
			
			// booking session tracker
			session.setAttribute("track-flight", "YES");
			
			// reset all carts that may not have been re-initialized
			session.setAttribute("flightcart", null);
			session.setAttribute("guestcart", null);
			session.setAttribute("contactinfo", null);
			session.setAttribute("paymentinfo", null);
			session.setAttribute("guestcount", null);
			session.setAttribute("welcomestat", null);
			
			// redirect
			RequestDispatcher rd = request.getRequestDispatcher("files_guest/bk_flight.jsp");
			rd.forward(request,response);
			
		} catch (Exception e) {
			
			// reset 
			session.setAttribute("flight_fromcountry", null);
			session.setAttribute("flight_tocountry", null);
			session.setAttribute("bk_noOfSeats", null);
			session.setAttribute("flight_tripType", null);
			session.setAttribute("bk_seatType", null);
			session.setAttribute("flight_departuredate",null);
			session.setAttribute("flight_returndate",null);
			session.setAttribute("flightsretrieved", null);
			session.setAttribute("track-flight", null);
			
			// redirect
			session.setAttribute("welcomestat", "NO");
			RequestDispatcher rd = request.getRequestDispatcher("index.jsp");
			rd.forward(request,response);
			
		} finally {
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
