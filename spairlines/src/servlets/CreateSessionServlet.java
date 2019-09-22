package servlets;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.sql.*;

@WebServlet("/CreateSessionServlet")
public class CreateSessionServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public CreateSessionServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		//declare and initialize variables 
		String task = request.getParameter("task");
		
		String loginid = request.getParameter("loginid");
		String password = request.getParameter("password");
		
		//activate the prepared statement
		String selectstr = "SELECT AdminID,Password FROM login WHERE AdminID=? and Password=?";
		String insertstr = "INSERT INTO logging (AdminID,Status,DateAndTime) VAlUES (?,?,?)";
		String success = "Logged in successfully";
		String failed = "Failed to log in";
		
		//HttpSession session = request.getSession();
		
		try {	
				Class.forName("com.mysql.jdbc.Driver");
				Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/spairlines?user=root&password=root");
				PreparedStatement pst = conn.prepareStatement(selectstr);
		        pst.setString(1, loginid);
		        pst.setString(2, password);
		        ResultSet rs = pst.executeQuery();                        
		        if(rs.next()) {           
		           if (loginid.equalsIgnoreCase("S001")){
		           		response.sendRedirect("files_admin/superuser.jsp");
		           		HttpSession session=request.getSession();  
		    	        session.setAttribute("Login-status","Yes");
		           } else {
		           		response.sendRedirect("files_admin/admin.jsp?adminid=" + loginid); 
		           		HttpSession session=request.getSession();  
		    	        session.setAttribute("Login-status","Yes");
		           }
		           PreparedStatement pstmt = conn.prepareStatement(insertstr);
		           pstmt.setString(1,loginid);
		           pstmt.setString(2,success);
		           pstmt.setTimestamp(3,new Timestamp(System.currentTimeMillis()));
		           pstmt.executeUpdate();
		        } else {
		           response.sendRedirect("files_admin/login.jsp?login=fail");
		           PreparedStatement pstmt = conn.prepareStatement(insertstr);
		           pstmt.setString(1,loginid);
		           pstmt.setString(2,failed);
		           pstmt.setTimestamp(3,new Timestamp(System.currentTimeMillis()));
		           pstmt.executeUpdate();
		        }
		        
		   //deactivate the prepared statement
		        conn.close();
		   } catch(Exception e){   
			   PrintWriter out = response.getWriter();
			   out.print("<h3>The server was unable to perform the requested action. Please try again.</h3>");
		       out.close();
		   } 		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
