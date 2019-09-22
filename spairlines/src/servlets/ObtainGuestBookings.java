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

import dbaccess.AdminBookings;
import dbaccess.AdminBookingsDB;

@WebServlet("/ObtainGuestBookings")
public class ObtainGuestBookings extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public ObtainGuestBookings() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession(); 
		
		// get the admin bookings parameters 
		String flightscheduleid = request.getParameter("flightscheduleid");
		String cabin = request.getParameter("radio1");
		ArrayList<AdminBookings> aBean = null;
		
		try{
			AdminBookingsDB adatabase = new AdminBookingsDB();
			aBean = adatabase.getBookingDetails(flightscheduleid, cabin);
			session.setAttribute("bookingsretrieved", aBean);
			RequestDispatcher rd = request.getRequestDispatcher("files_booking/displaybookings.jsp");
			rd.forward(request, response);
		}catch (Exception e){
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
