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
		<%@include file="../files_other/header2.jsp"%>
		
		<!-- Aircraft/Flight Administrative Navigation --> 
		<nav class="navbar navbar-default navbar-fixed-top">
			<ul class="nav navbar-nav">
				<li><a href="./aircraftinsert.jsp">Insert Aircraft</a></li>
				<li class="active"><a href="./aircraftsearch.jsp">Update/Delete Aircrafts</a></li>
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
				    	<li style="background-color: #afafaf; margin-right: 20px;"><a href="javascript:history.back()" style="color: #000000;">Return to Previous</a></li>
			    	</ul>
		    	</div>
			</nav>
			
			<!-- Article -->
			<article>
				<!-- Title -->
				<h1><strong>SP Airlines Management</strong></h1>
				
				<%
				//declare and initialize variables 
				String[] aircraft_ids = request.getParameterValues("aircraft_ids");
				String selectstr = "SELECT * FROM aircraft WHERE aircraft_id = ?";
				int a=0;
						
				//activate the prepared statement 
				try{
					Class.forName("com.mysql.jdbc.Driver"); 
					String connURL ="jdbc:mysql://localhost/spairlines?user=root&password=root";
					Connection conn = DriverManager.getConnection(connURL); 
					for(int i=1; i<aircraft_ids.length; i++){
						selectstr += " OR aircraft_id = ?";
					}
					PreparedStatement pstmt = conn.prepareStatement(selectstr);
					for(int i=0; i<aircraft_ids.length; i++){
						pstmt.setString(i+1,aircraft_ids[i]);
					}
					ResultSet rs = pstmt.executeQuery();
				%>
				
				<!-- display the records -->	
				<h3 style="margin-bottom: 30px">You selected these aircrafts to update.</h3>
				<table class="table table-hover">
					<tr style=background-color:#D0D0D0><td>Aircraft ID</td><td>Aircraft Model</td><td>Flight Number</td><td>Passenger Capacity</td><td>Image Path</td></tr>
					<%while(rs.next()){
						String aircraft_id = rs.getString("aircraft_id");
						String aircraft_model = rs.getString("aircraft_model");
						String aircraft_flightno = rs.getString("aircraft_flightno");
						String passenger_capacity = rs.getString("passenger_capacity");
						String image_path = rs.getString("image_path");
						a++;%>
						<tr><td><%=aircraft_id%></td><td><%=aircraft_model%></td><td><%=aircraft_flightno%></td><td><%=passenger_capacity%></td><td><%=image_path%></td></tr>
					<%}%>
				</table>
				<%
				//deactivate the prepared statement
						conn.close();
				} catch (Exception e) {%>
				<h3>The server was unable to perform the requested action. Please try again.</h3>
				<%}%>
				
				<!-- the update form -->
				<form class="form-horizontal" action="aircraftbackend.jsp?task=update" method="POST">
					<h3 style="margin-bottom: 30px">Please specify the fields to update.</h3>
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
						<label class="col-sm-2 control-label">Seat Map Image Path</label>
						<div class="col-sm-10">
							<input type="text" style="width:70%" class="form-control" name="image_path"><br>
						</div>
					</div>
					<div class="form-group">
						<div class="col-sm-offset-2 col-sm-10">
							<input type="submit" class="btn btn-warning" value="Update Aircrafts">
							<%for (int b=0; b<a; b++){%>
								<input type="hidden" name="aircraft_ids" value=<%=aircraft_ids[b]%>>
							<%}%>
						</div>
					</div>
				</form>
			</article>
		</div>
		
		<!-- Footer -->
		<%@include file="../files_other/footer.jsp"%>
	</body>
</html>