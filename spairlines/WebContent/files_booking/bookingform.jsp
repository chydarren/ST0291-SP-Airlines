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
		<%@include file="../files_other/header2.jsp"%>
		
		<!-- Aircraft/Flight Administrative Navigation -->
		<nav class="navbar navbar-default navbar-fixed-top">
			<ul class="nav navbar-nav">
				<li><a href="<%=request.getContextPath()%>/files_aircraft/aircraftinsert.jsp">Insert Aircraft</a></li>
				<li><a href="<%=request.getContextPath()%>/files_aircraft/aircraftsearch.jsp">Update/Delete Aircrafts</a></li>
				<li><a href="<%=request.getContextPath()%>/files_flight/flightscheduleinsert.jsp">Insert Flight Schedule</a></li>
				<li><a href="<%=request.getContextPath()%>/files_flight/flightschedulesearch.jsp">Update/Delete Flight Schedules</a></li>
				<li class="active"><a href="bookingform.jsp">View Flight Bookings</a></li>
				<li><a href="promotions.jsp">Insert/Delete Promotions</a></li>
			</ul>
		</nav>
		
		<!-- Main -->
		<div class="main">
		
			<!-- Admin Navigation -->
			<nav class="navbar navbar-default">
				<div class="container-fluid">
					<ul class="nav navbar-nav navbar-left">
						<span class="navbar-text" style="height: 8px;">You are currently viewing as an <span style="color: #ca6f1e; font-weight: bold;">Administrator</span>.</span>
					</ul>
					<ul class="nav navbar-nav navbar-right">
				    	<li style="background-color: #afafaf; margin-right: 20px;"><a href="<%=request.getContextPath()%>/files_admin/admin.jsp" style="color: #000000;">Account Default Tools</a></li>
				    	<li style="background-color: #afafaf; margin-right: 20px;"><a href="<%=request.getContextPath()%>/KillSessionServlet" style="color: #000000;">Logout</a></li>
			    	</ul>
		    	</div>
			</nav>
			
			<!-- Article -->
			<article>
				<!-- Title -->
				<h1><strong>SP Airlines Management</strong></h1>
				<h3 style="margin-bottom: 30px;">You can view flight bookings.</h3>
				
				<!-- Obtain Guest Bookings Form -->
				<form class="form-horizontal"action="../ObtainGuestBookings" method="POST">
					<div class="form-group">
						<label class="col-sm-2 control-label">Flight Schedule ID</label>
						<div class="col-sm-10">
							<input type="text" style="width:70%" class="form-control" name="flightscheduleid"><br>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label">Cabin Class</label>
						<div class="col-sm-10">
							<input type = "radio" name="radio1" value="Economy" style="margin-right: 10px;">Economy Class
							<input type = "radio" name="radio1" value="Business" style="margin-right: 10px; margin-left: 10px;">Business Class
							<input type = "radio" name="radio1" value="First" style="margin-right: 10px; margin-left: 10px;">First-class<br>
						</div>
					</div>
					<div class="form-group">
						<div class="col-sm-offset-2 col-sm-10" style="margin-top: 20px;">
							<input type="submit" class="btn btn-success" name="btnSearch" value="Search Booking" style="margin-right: 20px;">
							<input type="reset" class="btn btn-default">
						</div>
					</div>
				</form>
			</article>
		</div>
		
		<!-- Footer -->
		<%@include file="../files_other/footer.jsp"%>
	</body>
</html>