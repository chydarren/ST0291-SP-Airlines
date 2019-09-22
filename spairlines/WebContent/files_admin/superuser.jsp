<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
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
						<li style="background-color: #afafaf; margin-right: 20px;"><a href="<%=request.getContextPath()%>/files_aircraft/aircraftinsert.jsp" style="color: #000000;">Aircraft / Flight Schedules</a></li>
				    	<li style="background-color: #afafaf; margin-right: 20px;"><a href="<%=request.getContextPath()%>/files_admin/admin.jsp" style="color: #000000;">Account Default Tools</a></li>
				    	<li style="background-color: #afafaf; margin-right: 20px;"><a href="<%=request.getContextPath()%>/KillSessionServlet" style="color: #000000;">Logout</a></li>
			    	</ul>
		    	</div>
			</nav>
			
			<!-- Article -->
			<article>
				<!-- Title -->
				<h1><strong>SP Airlines Management</strong></h1>
				<h3 style="margin-bottom: 30px;">You can perform the administration of your admins account.</h3>
				<div class="alert alert-info" role="alert" style="width: 65.5%; margin: 0 auto; margin-top: 30px; text-align: center;">
					This page is visible to you because you are a super administrator. <br>
					You may also <a href="<%=request.getContextPath()%>/ObtainloggingDetails" class="alert-link">click here</a> to view  the admistrator log-in logs.
				</div>
				<!-- Insert Account Form -->
				<h3 style="margin-bottom: 30px; font-weight:bold;">Insert Account</h3>
				<form class="form-horizontal" action="superuserbackend.jsp?task=useradd" method="post">
					<div class="form-group">
						<label class="col-sm-2 control-label">Admin ID</label>
						<div class="col-sm-10">
							<input type="text" style="width:10%" class="form-control" name="adminid"><br>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label">Name</label>
						<div class="col-sm-10">
							<input type="text" style="width:30%" class="form-control" name="name"><br>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label">Email</label>
						<div class="col-sm-10">
							<input type="email" style="width:50%" class="form-control" name="email" placeholder="example@email.com"><br>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label">Password</label>
						<div class="col-sm-10">
							<input type="password" style="width:50%" class="form-control" name="password1"><br>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label">Re-type Password</label>
						<div class="col-sm-10">
							<input type="password" style="width:50%" class="form-control" name="password2"><br>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label">Security Answer</label>
						<div class="col-sm-10">
							<input type="password" style="width:50%" class="form-control" name="answer" placeholder="What is the name of your first pet?"><br>
						</div>
					</div>
					<div class="form-group">
						<div class="col-sm-offset-2 col-sm-10">
							<input type="submit" name="btninsert" class="btn btn-success" value="Insert Account" style="margin-right: 20px;">
							<input type="reset" class="btn btn-default" value="Reset">
						</div>
					</div>
				</form>
				
				<!-- Delete Account Form -->
				<h3 style="margin-bottom: 30px; font-weight:bold; margin-top: 30px;">Delete Account</h3>
				<form class="form-horizontal" action="superuserbackend.jsp?task=userdelete" method="post">
					<div class="form-group">
						<label class="col-sm-2 control-label" style="margin-bottom: 15px;">Admin ID</label>
						<div class="col-sm-10">
							<select class="form-control" name="adminid" style="width: 10%">
								<%
								try {
									Class.forName("com.mysql.jdbc.Driver"); 
							        String connURL ="jdbc:mysql://localhost/spairlines?user=root&password=root";
							        Connection conn = DriverManager.getConnection(connURL); 
							        Statement stmt = conn.createStatement();
									String sqlStr = "SELECT * FROM login";
									ResultSet rs = stmt.executeQuery(sqlStr); 
									while(rs.next()){ %>
										<option value="<%=rs.getString(1)%>"><%=rs.getString(1)%></option>
									<% }
								} catch(Exception e) {%>
									<h3>The server was unable to perform the requested action. Please try again.</h3>
								<%} 
								%>
							</select>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label">Password</label>
						<div class="col-sm-10">
							<input type="password" style="width:50%" class="form-control" name="password"><br>
						</div>
					</div>
					<div class="form-group">
						<div class="col-sm-offset-2 col-sm-10">
							<input type="submit" name="btndelete" class="btn btn-danger" value="Delete Account" style="margin-right: 20px;">
							<input type="reset" class="btn btn-default" value="Reset">
						</div>
					</div>
				</form>
				
				<!--  Update Account Form -->
				<h3 style="margin-bottom: 30px; font-weight:bold; margin-top: 30px;">Update Account</h3>
				<form class="form-horizontal" action="superuserbackend.jsp?task=changepassword" method="post">
					<div class="form-group">
						<label class="col-sm-2 control-label">Old Password</label>
						<div class="col-sm-10">
							<input type="password" style="width:50%" class="form-control" name="oldPassword"><br>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label">New Password</label>
						<div class="col-sm-10">
							<input type="password" style="width:50%" class="form-control" name="password1"><br>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label">Re-type New Password</label>
						<div class="col-sm-10">
							<input type="password" style="width:50%" class="form-control" name="password2"><br>
						</div>
					</div>
					<div class="form-group">
						<div class="col-sm-offset-2 col-sm-10">
							<input type="submit" name="btnchange" class="btn btn-warning" value="Update Account" style="margin-right: 20px;">
							<input type="reset" class="btn btn-default" value="Reset">
						</div>
					</div>
				</form>
				
				<!-- Search Account Form -->
				<h3 style="margin-bottom: 30px; font-weight:bold; margin-top: 30px;">Search Account</h3>
				<form class="form-horizontal" action="superusersearchprocess.jsp" method="post">
					<div class="form-group">
						<label class="col-sm-2 control-label">Search</label>
						<div class="col-sm-10">
							<input type="text" style="width:30%" class="form-control" name="searchTxt"><br>
						</div>
					</div>
					<div class="form-group">
						<div class="col-sm-offset-2 col-sm-10">
							<input type="submit" name="btnSubmit" class="btn btn-success" value="Search Account" style="margin-right: 20px;">
							<input type="reset" class="btn btn-default" value="Reset">
						</div>
					</div>
				</form>
			</article>
		</div>
		
		<!-- Footer -->
		<%@include file="../files_other/footer.jsp"%>
	</body>
</html>