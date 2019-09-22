<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import = "java.sql.*" %>
<%@include file="../sessioncheck.jsp"%>

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
				
				if(task.equals("useradd")){
					
					//initialize and declare variables 
					String adminid = request.getParameter("adminid");
					String name = request.getParameter("name");
					String email = request.getParameter("email");
					String password1 = request.getParameter("password1");
					String password2 = request.getParameter("password2");
					String answer = request.getParameter("answer");
						
					//activate the prepared statement 
					try {
						String insertstr = "INSERT INTO login VALUES(?,?,?,?,?)";
						
						if (password1 == null || password2 == null){
							response.sendRedirect("superuser.html?add=fail");
							return;
						} else {
							if (!password1.equals(password2)) {
							response.sendRedirect("superuser.html?add=fail");
							return;
							}
						}
						Class.forName("com.mysql.jdbc.Driver");
						Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/spairlines?user=root&password=root");
						 PreparedStatement pst = conn.prepareStatement(insertstr);
					        pst.setString(1, adminid);
					        pst.setString(2, name);
					        pst.setString(3, email);
					        pst.setString(4, password1);
					        pst.setString(5, answer);
					        int count = pst.executeUpdate();
					        if(count > 0){%>
								<h3><%=count%> records inserted.</h3>
							<%}
					        
					   //deactivate the prepared statement 
							conn.close();
					   } catch(Exception e){%>    
		       				<h3>The server was unable to perform the requested action. Please try again.</h3>
		   	  		 <%		   
					   }
					
				}else if(task.equals("userdelete")){
					
					//initialize and declare variables 
					String userid = request.getParameter("adminid");
					String password = request.getParameter("password");
					
					//activate the callable statement  
					try {
						Class.forName("com.mysql.jdbc.Driver");
						Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/spairlines?user=root&password=root");
						String simpleProc = "{ call userdelete(?,?) }";
						CallableStatement cs = conn.prepareCall(simpleProc);
						cs.setString(1,userid);
						cs.setString(2,password);
						int count = cs.executeUpdate();
						if(count > 0){%>
							<h3><%=count%> records deleted.</h3>
						<%}
					        
					//deactivate the callable statement
						conn.close();
				   } catch(Exception e){%>    
		       		<h3>The server was unable to perform the requested action. Please try again.</h3>
		   	  	  <%} 	
					
				}else if(task.equals("changepassword")){
					
					//initialize and declare variables 
					String oldPassword = request.getParameter("oldPassword");
					String password1 = request.getParameter("password1");
					String password2 = request.getParameter("password2");
	
					//activate the prepared statement 
					try {
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
				        
				   //deactivate the callable statement
					conn.close();
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