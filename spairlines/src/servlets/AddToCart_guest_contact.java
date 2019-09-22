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

import dbaccess.Bk_guest;
import dbaccess.Bk_contact;

@WebServlet("/AddToCart_guest_contact")
public class AddToCart_guest_contact extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public AddToCart_guest_contact() {
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
		
		try{
			// bk_guest information (with cart) 
			// declare array list 
			ArrayList<Bk_guest> guestdetails = (ArrayList<Bk_guest>)session.getAttribute("guestcart"); 
					
			// check if bk_guest cart exist 
			if(guestdetails==null){
				guestdetails = new ArrayList<Bk_guest>(); 
			}
			
			// get the guest parameters 
			String guest_salutation = request.getParameter("guest_salutation");
			String guest_firstname = request.getParameter("guest_firstname");
			String guest_lastname = request.getParameter("guest_lastname");
			String guest_passportno = request.getParameter("guest_passportno");
			
			// declare guest object 
			Bk_guest guest = new Bk_guest(guest_salutation, guest_firstname, guest_lastname, guest_passportno, 0); 
			
			// add guest object to bk_guest cart
			guestdetails.add(guest);
			
			// store bk_guest cart into session 
			session.setAttribute("guestcart",guestdetails);
			
			// get guest count 
			Integer count = ((Integer) session.getAttribute("guestcount")) + 1;
			Integer bk_noOfSeats = (Integer) session.getAttribute("bk_noOfSeats");
			
			// redirect
			if(count == bk_noOfSeats){
				
				// bk_contact information
				// get the contact parameters 
				String contact_email = request.getParameter("contact_email");
				int contact_tel_ctry = Integer.parseInt(request.getParameter("contact_tel_ctry"));
				int contact_tel_area = 0; 
				String strcontact_tel_area = request.getParameter("contact_tel_area"); 
				if(strcontact_tel_area != ""){
					contact_tel_area = Integer.parseInt(strcontact_tel_area);
				}
				String contact_tel_hp = request.getParameter("contact_tel_hp");
	
				// declare contact object 
				Bk_contact contact = new Bk_contact(0, contact_email, contact_tel_ctry, contact_tel_area, contact_tel_hp, 
						0, 0, 0);
				
				// store contact object into session 
				session.setAttribute("contactinfo",contact); 
				
				// booking session tracker
				session.setAttribute("gueststat", null);
				session.setAttribute("track-guest", null);
				session.setAttribute("track-payment", "YES");
				
				// proceed to payment page  
				RequestDispatcher rd = request.getRequestDispatcher("files_guest/bk_payment.jsp");
				rd.forward(request,response);
				
			}else{
				
				// return to guest page 
				session.setAttribute("guestcount", count++);
				RequestDispatcher rd = request.getRequestDispatcher("files_guest/bk_guest.jsp");
				rd.forward(request,response);
			} 
			
		}catch(Exception e){
			
			// reset 
			session.setAttribute("track-guest", "YES");
			session.setAttribute("track-payment", null);
			session.setAttribute("gueststat", "NO");
			
			// redirect
			RequestDispatcher rd = request.getRequestDispatcher("files_guest/bk_guest.jsp");
			rd.forward(request,response);
		}
	}
}
