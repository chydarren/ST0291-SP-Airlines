<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import = "dbaccess.AdminBookings" %>   
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
		<%@include file="../files_other/header2.jsp"%>
		
		<!-- Aircraft/Flight Administrative Navigation -->
		<nav class="navbar navbar-default navbar-fixed-top">
			<ul class="nav navbar-nav">
				<li><a href="<%=request.getContextPath()%>/files_aircraft/aircraftinsert.jsp">Insert Aircraft</a></li>
				<li><a href="<%=request.getContextPath()%>/files_aircraft/aircraftsearch.jsp">Update/Delete Aircrafts</a></li>
				<li><a href="<%=request.getContextPath()%>/files_flight/flightscheduleinsert.jsp">Insert Flight Schedule</a></li>
				<li><a href="<%=request.getContextPath()%>/files_flight/flightschedulesearch.jsp">Update/Delete Flight Schedules</a></li>
				<li class="active"><a href="files_booking/bookingform.jsp">View Flight Bookings</a></li>
				<li><a href="files_booking/promotions.jsp">Insert/Delete Promotions</a></li>
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
				    	<li style="background-color: #afafaf; margin-right: 20px;"><a href="javascript:history.back()" style="color: #000000;">Return to Previous</a></li>
			    	</ul>
		    	</div>
			</nav>
			
			<!-- Article -->
			<article>
				<!-- Title -->
				<h1><strong>SP Airlines Management</strong></h1>
				<%
				ArrayList<AdminBookings> bookingsretrieved = (ArrayList<AdminBookings>)session.getAttribute("bookingsretrieved");
				if(bookingsretrieved!=null) {%>
					<h3 style="margin-bottom: 30px;">All bookings are shown below.</h3>
					<table class="table table-hover">
						<tr style=background-color:#D0D0D0><td>Flight Booking ID</td><td>Flight Schedule ID</td><td>Seat Type</td><td>No of Seats</td><td>Contact Email</td><td>Guest First Name</td><td>Guest Last Name</td></tr>
						<%
						int stored_bkid = 0;
						for(AdminBookings bookings : bookingsretrieved){
							int booking_id = bookings.getflight_bk_id();
							int flight_schedule_id = bookings.getflightschedule_id();
							String cabin = bookings.getbk_seatType();
							int noOfSeats = bookings.getbk_noOfSeats();
							String firstname = bookings.getFirstname();
							String lastname = bookings.getLastname();
							String email = bookings.getEmail();
							if(booking_id != stored_bkid){%>
								<tr><td rowspan=<%=noOfSeats%>><%=booking_id%></td><td rowspan=<%=noOfSeats%>><%=flight_schedule_id%></td>
								<td rowspan=<%=noOfSeats%>><%=cabin%></td><td rowspan=<%=noOfSeats%>><%=noOfSeats%></td>
								<td rowspan=<%=noOfSeats%>><%=email%></td><td><%=firstname%></td><td><%=lastname%></td></tr>
							<%}else{%>
								<tr><td><%=firstname%></td><td><%=lastname%></td></tr>
							<%}
							stored_bkid = booking_id; 
						}%>
					</table>
				<%}else{%>
					<h3>No related records were found.</h3>
				<%}%>
			</article>
		</div>
	</body>
	
	<!-- Footer -->
	<%@include file="../files_other/footer.jsp"%>
</html>