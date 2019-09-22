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
		<%@ include file = "../files_other/header.jsp" %>
		
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
				<!-- Title -->
				<h1><strong>SP Airlines Management</strong></h1>
				
				<%
				String mySearchTxt = request.getParameter("searchTxt");
				
				//activate the prepared statement 
				try {
			          Class.forName("com.mysql.jdbc.Driver");
			          String connURL ="jdbc:mysql://localhost/spairlines?user=root&password=root"; 
			          String sqlStr = "SELECT * FROM login WHERE adminid LIKE ? OR name LIKE ? OR email LIKE ?"; 
			          Connection conn =   DriverManager.getConnection(connURL); 
			          PreparedStatement pst = conn.prepareStatement(sqlStr); 
			          pst.setString(1, "%"+mySearchTxt+"%"); 
			          pst.setString(2, "%"+mySearchTxt+"%");
			          pst.setString(3, "%"+mySearchTxt+"%");
			          ResultSet rs = pst.executeQuery();%>
			          
			          <!-- display the records -->	
			          <% if(rs.next()) { %>
						<h3 style="margin-bottom: 30px;">The accounts are shown below.</h3>
						<table class="table table-hover">
							<tr style=background-color:#D0D0D0><td>Admin ID</td><td>Name</td><td>Email</td><td>Password</td><td>Security Answer</td></tr>
							<%do{ 
								String adminid = rs.getString("adminid");
					            String name = rs.getString("name");
					            String email = rs.getString("email");
					            String password = rs.getString("password");
					            String ans = rs.getString("securityAns");
							%>
							<tr><td><%=adminid%></td><td><%=name%></td><td><%=email%></td><td><%=password%></td><td><%=ans%></td></tr>
							<%}while(rs.next());%>
						</table>
					<%}else{%>
						<h3>No related records were found.</h3>
					<%}
			          
		          	//deactivate the prepared statement 
		          	conn.close();
		     	} catch (Exception e) {%>
					<h3>The server was unable to perform the requested action. Please try again.</h3>
				<%}%>
			</article>
		 </div>
		 
		 <!-- Footer -->
		 <%@ include file = "../files_other/footer.jsp" %>
	</body>
</html>