<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
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
						<li style="background-color: #afafaf; margin-right: 20px;"><a href="<%=request.getContextPath()%>/files_aircraft/aircraftinsert.jsp" style="color: #000000;">Aircraft / Flight Schedules</a></li>
				    	<li style="background-color: #afafaf; margin-right: 20px;"><a href="<%=request.getContextPath()%>/KillSessionServlet" style="color: #000000;">Logout</a></li>
			    	</ul>
		    	</div>
			</nav>
			
			<!-- Article -->
			<article>
				<!-- Title -->
				<h1><strong>SP Airlines Management</strong></h1>
				<%String adminid = request.getParameter("adminid");%>
				<h3 style="margin-bottom: 30px;">You can update/reset your password or deactivate your account.</h3>
				
				<!-- Update Password Form -->
				
				<h3 style="margin-bottom: 30px; font-weight:bold;">Update Password</h3>
				<form class="form-horizontal" action="adminbackend.jsp?task=changepassword" method="post">
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
							<input type="submit" name="btnchange" class="btn btn-warning" value="Update Password" style="margin-right: 20px;">
							<input type="reset" class="btn btn-default" value="Reset">
						</div>
					</div>
				</form>
				
				<!-- Deactivate Account Form -->
				<h3 style="margin-bottom: 30px; font-weight:bold; margin-top: 30px;">Deactivate Account</h3>
				<form class="form-horizontal" action="adminbackend.jsp?task=deactivate" method="post">
					<div class="form-group">
						<label class="col-sm-2 control-label">Password</label>
						<div class="col-sm-10">
							<input type="password" style="width:50%" class="form-control" name="password"><br>
						</div>
					</div>
					<div class="form-group">
						<div class="col-sm-offset-2 col-sm-10">
							<input type="submit" name="btndeactivate" class="btn btn-danger" value="Deactivate Account" style="margin-right: 20px;">
							<input type="reset" class="btn btn-default" value="Reset">
						</div>
					</div>
				</form>
			</div>
		</article>
			
		<!-- Footer -->
		<%@include file="../files_other/footer.jsp"%>
	</body>
</html>