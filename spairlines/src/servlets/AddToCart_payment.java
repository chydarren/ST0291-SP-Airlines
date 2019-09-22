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

import dbaccess.Bk_payment;
import dbaccess.Bk_welcome;

@WebServlet("/AddToCart_payment")
public class AddToCart_payment extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public AddToCart_payment() {
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
			// bk_payment information 
			// declare array list 
			ArrayList<Bk_welcome> flightsretrieved = (ArrayList<Bk_welcome>)session.getAttribute("flightsretrieved");
		
			// get the payment parameters 
			String payment_card_holder = request.getParameter("payment_card_holder");
			String payment_card_no = request.getParameter("payment_card_no");
			String payment_card_expdate = request.getParameter("payment_card_expdate"); 
			int payment_card_cvv = Integer.parseInt(request.getParameter("payment_card_cvv"));
			String payment_addr_address = request.getParameter("payment_addr_address");
			String payment_addr_postcode = request.getParameter("payment_addr_postcode");
			String payment_addr_residence = request.getParameter("payment_addr_residence");
			String payment_addr_city = request.getParameter("payment_addr_city");
			String payment_addr_state = request.getParameter("payment_addr_state");
			Long payment_total_cost = flightsretrieved.get(0).getCabin_cost();
			
			// declare payment object 
			Bk_payment payment = new Bk_payment(0, payment_card_holder, payment_card_no, payment_card_expdate, payment_card_cvv,
					payment_addr_address, payment_addr_postcode, payment_addr_residence, payment_addr_city, payment_addr_state, payment_total_cost);
			
			// store payment object into session 
			session.setAttribute("paymentinfo",payment);
			
			// booking session tracker
			session.setAttribute("track-payment", null);
			session.setAttribute("paymentstat", null);
					
			// redirect 
			RequestDispatcher rd = request.getRequestDispatcher("/InsertServlet");
			rd.forward(request,response);
			
		}catch(Exception e){
			
			// reset
			session.setAttribute("paymentinfo", null);
			session.setAttribute("track-payment", "YES");
			session.setAttribute("paymentstat", "NO");
			
			// redirect 
			RequestDispatcher rd = request.getRequestDispatcher("files_guest/bk_payment.jsp");
			rd.forward(request,response);
		}
	}
}
