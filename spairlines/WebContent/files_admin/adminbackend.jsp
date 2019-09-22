<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import = "java.sql.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>SpAirlines</title>
	</head>
	<body>
		<!-- Header -->
		<%@include file="../files_other/header.jsp"%>
		
		<!-- Main -->
		<div class="main">
		
			<!-- Admin Navigation -->
			<nav class="navbar navbar-default">
				<div class="container-fluid">
					<ul class="nav navbar-nav navbar-left">
						<span class="navbar-text" style="height: 8px;">You are currently viewing as an <span style="color: #ca6f1e; font-weight: bold;">Administrator</span>.</span>
					</ul>
					<ul class="nav navbar-nav navbar-right">
				    	<li style="background-color: #afafaf; margin-right: 20px;"><a href="javascript:history.back()" style="color: #000000;">Return to Previous</a></li>
			    	</ul>
		    	</div>
			</nav>
			
			<!-- Article -->
			<article>
				<%
				//declare and initialize variables 
				String task = request.getParameter("task");
				
				if(task.equals("changepassword")){
					
					//activate the prepared statement 
					try {
						String oldPassword = request.getParameter("oldPassword");
						String password1 = request.getParameter("password1");
						String password2 = request.getParameter("password2");
						String updatestr = "UPDATE login SET password=? WHERE password=?";
						if (password1 == null || password2 == null){
							response.sendRedirect("admin.jsp?add=fail");
							return;
						} else {
							if (!password1.equals(password2)) {
							response.sendRedirect("admin.jsp?add=fail");
							return;
							}
						}
						Class.forName("com.mysql.jdbc.Driver");
						Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/spairlines?user=root&password=root");
						PreparedStatement pst = conn.prepareStatement(updatestr);
					        pst.setString(1, password1);
					        pst.setString(2, oldPassword);
					        int count = pst.executeUpdate();
					        if(count > 0){%>
								<h3><%=count%> records updated.</h3>
							<%}
					        
				   //deactivate the prepared statement 
							conn.close();
				   } catch(Exception e){%>    
			       		<h3>The server was unable to perform the requested action. Please try again.</h3>
			   	   <%} 		  
					
				}else if(task.equals("deactivate")){
					
					//activate the prepared statement 
					try {
						String password = request.getParameter("password");
						String deletestr = "DELETE FROM login WHERE password=?";
						Class.forName("com.mysql.jdbc.Driver");
						Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/spairlines?user=root&password=root");
						 PreparedStatement pst = conn.prepareStatement(deletestr);
					        pst.setString(1, password);
					        int count = pst.executeUpdate();
					        if(count > 0){%>
								<h3><%=count%> records deleted.</h3>
							<%}
					        
					//deactivate the prepared statement 
							conn.close();
				   } catch(Exception e){%>    
		       			<h3>The server was unable to perform the requested action. Please try again.</h3>
		   	   	  <%} 
					
				}else if(task.equals("resetpassword")){
					
					//declare and initialize variables  
					String currentAdmin = (String)session.getAttribute("currentAdmin");
					String password = request.getParameter("password");
					String updatestr = "UPDATE login SET password=? WHERE adminid=?";
						
					//activate the prepared statement 
					try {
						Class.forName("com.mysql.jdbc.Driver");
						Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/spairlines?user=root&password=root");
						PreparedStatement pst = conn.prepareStatement(updatestr);
				        pst.setString(1, password);
				        pst.setString(2, currentAdmin);
				        int count = pst.executeUpdate();
						
				        //deactivate the prepared statement 
				        conn.close();
						response.sendRedirect("login.jsp");
						session.invalidate();
						
					} catch(Exception e){%>    
	       				<h3>The server was unable to perform the requested action. Please try again.</h3>
	   	   	  	 	<%}
				}
				%>
			</article>
		</div>
		
		<!-- Footer -->
		<%@include file="../files_other/footer.jsp"%>
	</body>
</html>