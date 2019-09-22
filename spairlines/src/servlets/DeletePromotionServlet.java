package servlets;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dbaccess.InsertPromotion;

@WebServlet("/DeletePromotionServlet")
public class DeletePromotionServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public DeletePromotionServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession();
		try{
			// delete promotion instance
			InsertPromotion bk_promotion_del = new InsertPromotion(); 
			
			// get the promotion parameter
			int promotion_id = Integer.parseInt(request.getParameter("promotion_id"));
			
			// delete promotion
			bk_promotion_del.deletePromotion(promotion_id);
			
			// redirect
			session.setAttribute("delpromotionstat", "YES");
			RequestDispatcher rd = request.getRequestDispatcher("files_booking/displaypromotions.jsp");
			rd.forward(request,response);
		
		}catch(Exception e){
			// redirect 
			session.setAttribute("delpromotionstat", "NO");
			RequestDispatcher rd = request.getRequestDispatcher("ObtainAdminPromotionServlet");
			rd.forward(request,response);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
