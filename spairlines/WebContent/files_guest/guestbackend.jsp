<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*" %>

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
						<span class="navbar-text" style="height: 8px;">You are currently viewing as a <span style="color: #229954; font-weight: bold;">Guest</span>.</span>
					</ul>
					<ul class="nav navbar-nav navbar-right">
				    	<li style="background-color: #afafaf; margin-right: 20px;"><a href="javascript:history.back()" style="color: #000000;">Return to Previous</a></li>
			    	</ul>
		    	</div>
			</nav>
			
			<!-- Article -->
			<article>
				<%//declare and initialize variables 
				String flightschedule_id = request.getParameter("flightschedule_id");
				
				//activate the prepared statement 
				String selectstr = "SELECT * FROM flightschedule WHERE flightschedule_id = ?";
				
				try{
					Class.forName("com.mysql.jdbc.Driver"); 
					String connURL ="jdbc:mysql://localhost/spairlines?user=root&password=root";
					Connection conn = DriverManager.getConnection(connURL); 
					PreparedStatement pstmt = conn.prepareStatement(selectstr);
					pstmt.setString(1,flightschedule_id);
					ResultSet rs = pstmt.executeQuery();%>
				
					<!-- display the records -->	
					<h1><strong>Browse Flights</strong></h1>
					<h3 style="margin-bottom: 30px;">The flight schedule for <%=flightschedule_id%> is shown below.</h3>
					<table class="table table-hover">
						<tr style=background-color:#D0D0D0><td>Flight Info</td><td>Departure</td><td>Arrival</td><td>Flight Time</td><td class="classcost" style="background-color: #0b664b">Economy</td><td class="classcost" style="background-color: #053870">Business</td><td class="classcost" style="background-color: #99422e">First</td></tr>
						<%String aircraft_id = "";
						while(rs.next()){ 
							aircraft_id = rs.getString("aircraft_id");
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
						%>
						<tr><td><span style="font-weight: bold;">Aircraft</span><br><%=aircraft_id%><br><br><span style="font-weight: bold;">Flight</span><br><%=aircraft_flightno%></td><td><%=departure_airport%><br>Terminal <%=departure_terminal%><br><%=departure_datetime%></td><td><%=arrival_airport%><br>Terminal <%=arrival_terminal%><br><%=arrival_datetime%><br><br><span style="font-weight: bold;">Arrive At</span><br><%=arrival_country%>, <%=arrival_city%><br><br></td><td><%=flight_time%></td><td style="text-align: center;"><%=economy_cost%></td><td style="text-align: center;"><%=business_cost%></td><td style="text-align: center;"><%=first_cost%></td></tr>
					<%}
					
					//activate the prepared statement 
					String selectstrimg = "SELECT image_path FROM aircraft WHERE aircraft_id = ?";
					PreparedStatement pstmtimg = conn.prepareStatement(selectstrimg);
					pstmtimg.setString(1,aircraft_id);
					ResultSet rsimg = pstmtimg.executeQuery();
					
					//get the image 
					String image_path="";
					while(rsimg.next()){ 
						image_path = rsimg.getString("image_path");
					}
					%>
						<tr style="background-color:#D0D0D0"><td colspan="15">Seat Map</td></tr>
						<tr><td colspan="15" align="center"><img src="../<%=image_path%>"></td></tr> 
					</table>
					
					<%//deactivate the prepared statement
						conn.close();
					} catch (Exception e) {%>
						<h3>The server was unable to perform the requested action. Please try again.</h3>
				<%}%>
			</article>
		</div>
		
		<!-- Footer -->
		<%@include file="../files_other/footer.jsp"%>
	</body>
</html>