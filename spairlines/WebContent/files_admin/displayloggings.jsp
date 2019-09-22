<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import = "dbaccess.Logging" %>   
<%@page import = "java.util.ArrayList" %>     
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
						<span class="navbar-text" style="height: 8px;">You are currently viewing as an <span style="color: #7d3c98; font-weight: bold;">Super Administrator</span>.</span>
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
				<div class="alert alert-info" role="alert" style="width: 65.5%; margin: 0 auto; margin-top: 30px; text-align: center;">
					This page is visible to you because you are a super administrator. <br>
				</div>
				<%
				ArrayList<Logging> loggingretrieved = (ArrayList<Logging>)session.getAttribute("loggingdata");
				if(loggingretrieved!=null) {%>
					<h3 style="margin-bottom: 30px;">All logs are shown below.</h3>
					<table class="table table-hover">
						<tr style=background-color:#D0D0D0><td>Log No</td><td>Admin ID</td><td>Status</td><td>Date and Time</td></tr>
						<%for(Logging logs : loggingretrieved){
							int log_id = logs.getLoggingID();
							String admin_id = logs.getAdminID();
							String status_login = logs.getStatus();
							String date_and_time = logs.getDateAndTime();%>
							<tr><td><%=log_id%></td><td><%=admin_id%></td><td><%=status_login%></td><td><%=date_and_time%></td></tr>
						<%}%>
					</table>
				<%}else{%>
					<h3>No related records were found.</h3>
				<%}%>
			</article>
		</div>
		
		<!-- Footer -->
		<%@include file="../files_other/footer.jsp"%>
	</body>
</html>