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
				<li><a href="../files_aircraft/aircraftinsert.jsp">Insert Aircraft</a></li>
				<li><a href="../files_aircraft/aircraftsearch.jsp">Update/Delete Aircrafts</a></li>
				<li class="active"><a href="./flightscheduleinsert.jsp">Insert Flight Schedule</a></li>
				<li><a href="./flightschedulesearch.jsp">Update/Delete Flight Schedules</a></li>
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
				<h3 style="margin-bottom: 30px;">You can insert flight schedules.</h3>
				
				<!-- Insert Flight Schedule Form -->
				<form class="form-horizontal" action="flightschedulebackend.jsp?task=insert" method="POST">
					<div class="form-group">
						<label class="col-sm-2 control-label">Aircraft ID</label>
						<div class="col-sm-10">
							<select class="form-control" name="aircraft_id" style="width: 10%">
								<%
								try {
									Class.forName("com.mysql.jdbc.Driver"); 
							        String connURL ="jdbc:mysql://localhost/spairlines?user=root&password=root";
							        Connection conn = DriverManager.getConnection(connURL); 
							        Statement stmt = conn.createStatement();
									String sqlStr = "SELECT * FROM aircraft";
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
						<label class="col-sm-2 control-label" style="margin-top: 20px; margin-bottom:20px;">Flight Number</label>
						<div class="col-sm-10" style="margin-top: 20px; margin-bottom:20px;">
							<select class="form-control" name="aircraft_flightno" style="width: 10%">
								<%
								try {
									Class.forName("com.mysql.jdbc.Driver"); 
							        String connURL ="jdbc:mysql://localhost/spairlines?user=root&password=root";
							        Connection conn = DriverManager.getConnection(connURL); 
							        Statement stmt = conn.createStatement();
									String sqlStr = "SELECT * FROM aircraft";
									ResultSet rs = stmt.executeQuery(sqlStr); 
									while(rs.next()){ %>
										<option value="<%=rs.getString(3)%>"><%=rs.getString(3)%></option>
									<% } 
								} catch(Exception e) {%>
									<h3>The server was unable to perform the requested action. Please try again.</h3>
								<%} 
								%>
							</select>
						</div>
					</div>
					<div class="form-group">
				        <label class="col-sm-2 control-label">Departure</label>
				        <div class="col-md-10">
				            <div class="form-group row">
				                <div class="col-md-5">
				                    <input type="text" class="form-control" name="departure_airport">
				                    <span class="control-label">Airport</span>
				                </div>
				                <div class="col-md-1">
				                    <input type="text" class="form-control" name="departure_terminal">
				                    <span class="control-label">Terminal</span>
				                </div>
				            </div>
				        </div>
				    </div>
				    <div class="form-group">
				        <label class="col-sm-2 control-label">Arrival</label>
				        <div class="col-md-10">
				            <div class="form-group row">
				                <div class="col-md-5">
				                    <input type="text" class="form-control" name="arrival_airport">
				                    <span class="control-label">Airport</span>
				                </div>
				                <div class="col-md-1">
				                    <input type="text" class="form-control" name="arrival_terminal">
				                    <span class="control-label">Terminal</span>
				                </div>
				            </div>
				        </div>
				    </div>
					<div class="form-group">
						<label class="col-sm-2 control-label">Country</label>
						<div class="col-sm-10">
							<input type="text" style="width:30%" class="form-control" name="arrival_country"><br>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label">City</label>
						<div class="col-sm-10">
							<input type="text" style="width:30%" class="form-control" name="arrival_city"><br>
						</div>
					</div>
					<div class="form-group">
				        <label class="col-sm-2 control-label">Cost(s)</label>
				        <div class="col-md-10">
				            <div class="form-group row">
				                <div class="col-md-2">
				                    <input type="text" class="form-control" name="economy_cost">
				                    <span class="control-label">Economy Class</span>
				                </div>
				                <div class="col-md-2">
				                    <input type="text" class="form-control" name="business_cost">
				                    <span class="control-label">Business Class</span>
				                </div>
				                <div class="col-md-2">
				                    <input type="text" class="form-control" name="first_cost">
				                    <span class="control-label">First Class</span>
				                </div>
				            </div>
				        </div>
				    </div>
					<div class="form-group">
						<label class="col-sm-2 control-label">Departure Date and Time</label>
						<div class="col-sm-10">
							<input type="text" style="width:30%" class="form-control" name="departure_datetime" placeholder="YYYY-MM-DD HH:MM:SS"><br>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label">Arrival Date and Time</label>
						<div class="col-sm-10">
							<input type="text" style="width:30%" class="form-control" name="arrival_datetime" placeholder="YYYY-MM-DD HH:MM:SS"><br>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label">Flight Time</label>
						<div class="col-sm-10">
							<input type="text" style="width:30%" class="form-control" name="flight_time" placeholder="HH:MM:SS"><br>
						</div>
					</div>
					<div class="form-group">
						<div class="col-sm-offset-2 col-sm-10">
							<input type="submit" name="btnsubmit" class="btn btn-success" value="Insert Flight Schedule">
						</div>
					</div>
				</form>
			</article>
		</div>
		
		<!-- Footer -->
		<%@include file="../files_other/footer.jsp"%>
	</body>
</html>