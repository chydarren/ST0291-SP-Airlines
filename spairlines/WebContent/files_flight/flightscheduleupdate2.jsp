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
				<li><a href="./flightscheduleinsert.jsp">Insert Flight Schedule</a></li>
				<li class="active"><a href="./flightschedulesearch.jsp">Update/Delete Flight Schedules</a></li>
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
				String[] flightschedule_ids = request.getParameterValues("flightschedule_ids");
				String selectstr = "SELECT * FROM flightschedule WHERE flightschedule_id = ?";
				int a=0;
						
				//activate the prepared statement 
				try{
					Class.forName("com.mysql.jdbc.Driver"); 
					String connURL ="jdbc:mysql://localhost/spairlines?user=root&password=root";
					Connection conn = DriverManager.getConnection(connURL); 
					for(int i=1; i<flightschedule_ids.length; i++){
						selectstr += " OR flightschedule_id = ?";
					}
					PreparedStatement pstmt = conn.prepareStatement(selectstr);
					for(int i=0; i<flightschedule_ids.length; i++){
						pstmt.setString(i+1,flightschedule_ids[i]);
					}
					ResultSet rs = pstmt.executeQuery();
				%>
				
				<!-- display the records -->	
				<h3 style="margin-bottom: 30px">You selected these flight schedules to update.</h3>
				<table class="table table-hover">
					<tr style=background-color:#D0D0D0><td>Flight Info</td><td>Departure</td><td>Arrival</td><td>Flight Time</td><td class="classcost" style="background-color: #0b664b">Economy</td><td class="classcost" style="background-color: #053870">Business</td><td class="classcost" style="background-color: #99422e">First</td></tr>
					<%while(rs.next()){ 
						String flightschedule_id = rs.getString("flightschedule_id");
						String aircraft_id = rs.getString("aircraft_id");
						String aircraft_flightno = rs.getString("aircraft_flightno");
						String departure_airport = rs.getString("departure_airport");
						String departure_terminal = rs.getString("departure_terminal");
						String arrival_airport = rs.getString("arrival_airport");
						String arrival_terminal = rs.getString("arrival_terminal");
						String arrival_country = rs.getString("arrival_country");
						String arrival_city = rs.getString("arrival_city");
						String economy_cost = rs.getString("economy_cost");
						String business_cost = rs.getString("business_cost");
						String first_cost = rs.getString("first_cost");
						String departure_datetime = (rs.getString("departure_datetime")).substring(0,19);
						String arrival_datetime = (rs.getString("arrival_datetime")).substring(0,19);
						String flight_time = rs.getString("flight_time");
						a++;%>
						<tr><td><span style="font-weight: bold;">Flight ID</span><br><%=flightschedule_id%><br><br><span style="font-weight: bold;">Aircraft</span><br><%=aircraft_id%><br><br><span style="font-weight: bold;">Flight</span><br><%=aircraft_flightno%><br><br></td><td><%=departure_airport%><br>Terminal <%=departure_terminal%><br><%=departure_datetime%></td><td><%=arrival_airport%><br>Terminal <%=arrival_terminal%><br><%=arrival_datetime%><br><br><span style="font-weight: bold;">Arrive At</span><br><%=arrival_country%>, <%=arrival_city%><br></td><td><%=flight_time%></td><td style="text-align: center;"><%=economy_cost%></td><td style="text-align: center;"><%=business_cost%></td><td style="text-align: center;"><%=first_cost%></td></tr>
					<%}%>
				</table>
				<%
				//deactivate the prepared statement
						conn.close();
				} catch (Exception e) {%>
				<h3>The server was unable to perform the requested action. Please try again.</h3>
			<%}%>
				
				<!-- the update form -->
				<form class="form-horizontal" action="flightschedulebackend.jsp?task=update" method="POST">
					<h3 style="margin-bottom: 30px">Please specify the fields to update.</h3>
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
									ResultSet rs = stmt.executeQuery(sqlStr);%>
									<option value=""></option>
									<%while(rs.next()){ %>
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
									ResultSet rs = stmt.executeQuery(sqlStr);%>
									<option value=""></option>
									<%while(rs.next()){ %>
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
							<input type="submit" class="btn btn-warning" value="Update Flight Schedules">
							<%for (int b=0; b<a; b++){%>
								<input type="hidden" name="flightschedule_ids" value=<%=flightschedule_ids[b]%>>
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