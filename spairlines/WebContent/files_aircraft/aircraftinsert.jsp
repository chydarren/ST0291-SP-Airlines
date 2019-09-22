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
				<li class="active"><a href="./aircraftinsert.jsp">Insert Aircraft</a></li>
				<li><a href="./aircraftsearch.jsp">Update/Delete Aircrafts</a></li>
				<li><a href="../files_flight/flightscheduleinsert.jsp">Insert Flight Schedule</a></li>
				<li><a href="../files_flight/flightschedulesearch.jsp">Update/Delete Flight Schedules</a></li>
				<li><a href="../files_booking/bookingform.jsp">View Flight Bookings</a></li>
				<li><a href="../files_booking/promotions.jsp">Insert/Delete Promotions</a></li>
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
				    	<li style="background-color: #afafaf; margin-right: 20px;"><a href="../files_admin/admin.jsp" style="color: #000000;">Account Default Tools</a></li>
				    	<li style="background-color: #afafaf; margin-right: 20px;"><a href="<%=request.getContextPath()%>/KillSessionServlet" style="color: #000000;">Logout</a></li>
			    	</ul>
		    	</div>
			</nav>
				
			<!-- Article -->
			<article>
				<!-- Title -->
				<h1><strong>SP Airlines Management</strong></h1>
				<h3 style="margin-bottom: 30px;">You can insert aircrafts.</h3>
				
				<!-- Insert Aircraft Form -->
				<form class="form-horizontal" action="../files_aircraft/aircraftbackend.jsp?task=insert" method="POST" enctype="multipart/form-data">
					<div class="form-group">
						<label class="col-sm-2 control-label">Aircraft Model</label>
						<div class="col-sm-10">
							<input type="text" style="width:70%" class="form-control" name="aircraft_model"><br>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label">Flight Number</label>
						<div class="col-sm-10">
							<input type="text" style="width:10%" class="form-control" name="aircraft_flightno"><br>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label">Passenger Capacity</label>
						<div class="col-sm-10">
							<input type="text" style="width:10%" class="form-control" name="passenger_capacity"><br>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label">Seat Map</label>
						<div class="col-sm-10">
							<input type="file" name="file" size="50">
							<p class="help-block">Choose an image file and it will be auto-uploaded to the images web folder.</p>
						</div>
					</div>
					<div class="form-group">
						<div class="col-sm-offset-2 col-sm-10">
							<input type="submit" name="btnsubmit" class="btn btn-success" value="Insert Aircraft">
						</div>
					</div>
				</form>
			</article>
		</div>
		
		<!-- Footer -->
		<%@include file="../files_other/footer.jsp"%>
	</body>
</html>