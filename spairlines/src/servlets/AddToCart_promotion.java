package servlets;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/AddToCart_promotion")
public class AddToCart_promotion extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public AddToCart_promotion() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession(); 
		
		// store to promotion object 
		session.setAttribute("promotion_cost", Long.parseLong(request.getParameter("cabin_cost")));
		session.setAttribute("promotion_departure_country", request.getParameter("promotion_departure_country"));
		session.setAttribute("promotion_arrival_country", request.getParameter("promotion_arrival_country"));
		session.setAttribute("promotion_cabin_class", request.getParameter("cabin_class"));
		session.setAttribute("promotion_enddate", request.getParameter("promotion_enddate"));
		
		// redirect 
		RequestDispatcher rd = request.getRequestDispatcher("index.jsp");
		rd.forward(request,response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
