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

import dbaccess.*; 

@WebServlet("/ObtainloggingDetails")
public class ObtainloggingDetails extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public ObtainloggingDetails() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession(); 
		ArrayList<Logging> lbean = null;
		
		try {
			LoggingDB ldatabase = new LoggingDB();
			lbean = ldatabase.getLogging();
			session.setAttribute("loggingdata", lbean);
			RequestDispatcher rd = request.getRequestDispatcher("files_admin/displayloggings.jsp");
			rd.forward(request,response);
		} catch (Exception e) {
		} finally {
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}
}
