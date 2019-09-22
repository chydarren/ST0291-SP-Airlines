package servlets;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dbaccess.Bk_promotion;
import dbaccess.InsertPromotion;

@WebServlet("/InsertPromotionServlet")
public class InsertPromotionServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public InsertPromotionServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession();
		try{
			// insert promotion instance  
			InsertPromotion bk_promotion_ins = new InsertPromotion(); 
			
			// get the promotion parameters 
			String promotion_startdate = request.getParameter("promotion_startdate");
			String promotion_enddate = request.getParameter("promotion_enddate");
			String promotion_departure_country = request.getParameter("promotion_departure_country");
			String promotion_arrival_country = request.getParameter("promotion_arrival_country");
			String seat_type = request.getParameter("seat_type");
			Long cabin_cost = Long.parseLong(request.getParameter("cabin_cost"));
			
			// declare promotion object 
			Bk_promotion promotion = new Bk_promotion(0, promotion_startdate, promotion_enddate, promotion_departure_country,
					promotion_arrival_country, seat_type, cabin_cost);
			
			// insert promotion
			bk_promotion_ins.setPromotion(promotion);
			
			// redirect
			session.setAttribute("promotionstat", "YES");
			RequestDispatcher rd = request.getRequestDispatcher("files_booking/promotions.jsp");
			rd.forward(request,response);
			
		}catch(Exception e){
			// redirect 
			session.setAttribute("promotionstat", "NO");
			RequestDispatcher rd = request.getRequestDispatcher("files_booking/promotions.jsp");
			rd.forward(request,response);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
