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

import dbaccess.Bk_promotion;
import dbaccess.RetrievePromotion;

@WebServlet("/ObtainAdminPromotionServlet")
public class ObtainAdminPromotionServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public ObtainAdminPromotionServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession(); 
		
		// bk_promotion information (with cart)
		try {
			// declare database retrieval object 
			ArrayList<Bk_promotion> bBean = null;
			RetrievePromotion bdatabase = new RetrievePromotion();
			bBean = bdatabase.getPromotions(); 
			
			// store promotion object into session 
			session.setAttribute("promotionsretrieved", bBean);
			
			// redirect
			RequestDispatcher rd = request.getRequestDispatcher("files_booking/displaypromotions.jsp");
			rd.forward(request,response);
			
		} catch (Exception e) {
		}
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}