<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*" %>
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
				    	<li style="background-color: #afafaf; margin-right: 20px;"><a href="javascript:history.back()" style="color: #000000;">Return to Previous</a></li>
			    	</ul>
		    	</div>
			</nav>
			
			<!-- Article -->
			<article>
				<%
				//declare and initialize variables 
				String task = request.getParameter("task");
				
				if(task.equals("insert")){
					
					//declare and initialize variables  
					int aircraft_id = Integer.parseInt(request.getParameter("aircraft_id"));
					String aircraft_flightno = request.getParameter("aircraft_flightno");
					String departure_airport = request.getParameter("departure_airport");
					String departure_terminal = request.getParameter("departure_terminal");
					String arrival_airport = request.getParameter("arrival_airport");
					String arrival_terminal  = request.getParameter("arrival_terminal");
					String arrival_country = request.getParameter("arrival_country"); 
					String arrival_city = request.getParameter("arrival_city"); 
					String economy_cost = request.getParameter("economy_cost");
					String business_cost = request.getParameter("business_cost");
					String first_cost = request.getParameter("first_cost");
					String departure_datetime = request.getParameter("departure_datetime");
					String arrival_datetime = request.getParameter("arrival_datetime");
					String flight_time = request.getParameter("flight_time");
					
					//activate the prepared statement 
					String insertstr = "INSERT INTO flightschedule (aircraft_id,aircraft_flightno,departure_airport,departure_terminal,arrival_airport,arrival_terminal,arrival_country,arrival_city";
					
					if(!economy_cost.isEmpty()){
						insertstr += ",economy_cost";
					}
					
					if(!business_cost.isEmpty()){
						insertstr += ",business_cost";
					}
					
					if(!first_cost.isEmpty()){
						insertstr += ",first_cost";
					}
					
					insertstr += ",departure_datetime,arrival_datetime,flight_time) VALUES (?,?,?,?,?,?,?,?";
					
					if(!economy_cost.isEmpty()){
						insertstr += ",?";
					}
					
					if(!business_cost.isEmpty()){
						insertstr += ",?";
					}
					
					if(!first_cost.isEmpty()){
						insertstr += ",?";
					}
					
					insertstr += ",?,?,?)";
					
					try {
						Class.forName("com.mysql.jdbc.Driver"); 
						String connURL ="jdbc:mysql://localhost/spairlines?user=root&password=root";
						Connection conn = DriverManager.getConnection(connURL); 
						PreparedStatement pstmt = conn.prepareStatement(insertstr);
						pstmt.setInt(1,aircraft_id);
						pstmt.setString(2,aircraft_flightno);
						pstmt.setString(3,departure_airport);
						pstmt.setString(4,departure_terminal);
						pstmt.setString(5,arrival_airport);
						pstmt.setString(6,arrival_terminal);
						pstmt.setString(7,arrival_country);
						pstmt.setString(8,arrival_city);
						if((!economy_cost.isEmpty() && business_cost.isEmpty() && first_cost.isEmpty()) || (economy_cost.isEmpty() && !business_cost.isEmpty() && first_cost.isEmpty()) || (economy_cost.isEmpty() && business_cost.isEmpty() && !first_cost.isEmpty())){
							if(!economy_cost.isEmpty()){
								pstmt.setString(9,economy_cost);
							}else if(!business_cost.isEmpty()){
								pstmt.setString(9,business_cost);
							}else{
								pstmt.setString(9,first_cost);
							}
							pstmt.setString(10,departure_datetime);
							pstmt.setString(11,arrival_datetime);
							pstmt.setString(12,flight_time);
						}else if((!economy_cost.isEmpty() && !business_cost.isEmpty() && first_cost.isEmpty()) || (economy_cost.isEmpty() && !business_cost.isEmpty() && !first_cost.isEmpty()) || (!economy_cost.isEmpty() && business_cost.isEmpty() && !first_cost.isEmpty())){
							if(!economy_cost.isEmpty() && !business_cost.isEmpty()){
								pstmt.setString(9, economy_cost);
								pstmt.setString(10, business_cost);
							}else if(!business_cost.isEmpty() && !first_cost.isEmpty()){
								pstmt.setString(9,business_cost);
								pstmt.setString(10, first_cost);
							}else{
								pstmt.setString(9,economy_cost);
								pstmt.setString(10,first_cost);
							}
							pstmt.setString(11,departure_datetime);
							pstmt.setString(12,arrival_datetime);
							pstmt.setString(13,flight_time);
						}else{
							pstmt.setString(9,economy_cost);
							pstmt.setString(10,business_cost);
							pstmt.setString(11,first_cost);
							pstmt.setString(12,departure_datetime);
							pstmt.setString(13,arrival_datetime);
							pstmt.setString(14,flight_time);
						}
						
						int count = pstmt.executeUpdate();
						if(count > 0){%>
							<h3><%=count%> records inserted.</h3>
						<%}
						
					//deactivate the prepared statement 
						conn.close();
					} catch(Exception e) {%>
					<h3>The server was unable to perform the requested action. Please try again.</h3>
				<%}
					
				}else if(task.equals("update")){
					
					//declare and initialize variables 
					String[] flightschedule_ids = request.getParameterValues("flightschedule_ids");
					String[] updates = new String[14];
					updates[0] = request.getParameter("aircraft_id");
					updates[1] = request.getParameter("aircraft_flightno");
					updates[2] = request.getParameter("departure_airport");
					updates[3] = request.getParameter("departure_terminal"); 
					updates[4] = request.getParameter("arrival_airport");
					updates[5] = request.getParameter("arrival_terminal"); 
					updates[6] = request.getParameter("arrival_country");
					updates[7] = request.getParameter("arrival_city"); 
					updates[8] = request.getParameter("economy_cost");
					updates[9] = request.getParameter("business_cost"); 
					updates[10] = request.getParameter("first_cost"); 
					updates[11] = request.getParameter("departure_datetime");
					updates[12] = request.getParameter("arrival_datetime"); 
					updates[13] = request.getParameter("flight_time"); 
					
					String[] variables = new String[14]; 
					variables[0] = "aircraft_id";
					variables[1] = "aircraft_flightno";
					variables[2] = "departure_airport";
					variables[3] = "departure_terminal";
					variables[4] = "arrival_airport";
					variables[5] = "arrival_terminal";
					variables[6] = "arrival_country";
					variables[7] = "arrival_city";
					variables[8] = "economy_cost";
					variables[9] = "business_cost";
					variables[10] = "first_cost";
					variables[11] = "departure_datetime";
					variables[12] = "arrival_datetime";
					variables[13] = "flight_time";
					
					int county=0, counter=0; 
					
					//for loop (count number of given variables)
					for(int i=0; i<updates.length; i++){
						if(!updates[i].isEmpty()){
							county += 1;
						}
					}
					
					//activate the prepared statement 
					String updtstr = "UPDATE flightschedule SET ";
					
					for(int i=0; i<updates.length; i++){
						if (!updates[i].isEmpty()){
							updtstr += variables[i] + " = ?";
							if (counter < county-1){
								updtstr += ", ";
								counter++; 
							}
						}
					}
					
					updtstr += " WHERE flightschedule_id = ?";
					
					for(int i=1; i<flightschedule_ids.length; i++){
						updtstr += " OR flightschedule_id = ?";
					}
					
					try{
						Class.forName("com.mysql.jdbc.Driver");
						String connURL = "jdbc:mysql://localhost/spairlines?user=root&password=root";
						Connection conn = DriverManager.getConnection(connURL);
						PreparedStatement pstmt = conn.prepareStatement(updtstr);
						counter = 1;
						for(int i=0; i<updates.length; i++){
							if (!updates[i].isEmpty()){
								pstmt.setString(counter,updates[i]);
								counter++; 
							}
						}
						for(int i=0; i<flightschedule_ids.length; i++){
							pstmt.setString(counter,flightschedule_ids[i]);
							counter++;
						}
						int count = pstmt.executeUpdate();
						if(count > 0){%>
							<h3><%=count%> records updated.</h3>
						<%}
						
					//deactivate the prepared statement 
						conn.close();
					} catch(Exception e) {%>
					<h3>The server was unable to perform the requested action. Please try again.</h3>
				<%}
					
				}else if(task.equals("delete")){
					
					//declare and initialize variables 
					String[] flightschedule_ids = request.getParameterValues("flightschedule_ids");
					
					//activate the prepared statement 
					String delstr = "DELETE FROM flightschedule WHERE flightschedule_id = ?";
					
					try {
						Class.forName("com.mysql.jdbc.Driver"); 
						String connURL ="jdbc:mysql://localhost/spairlines?user=root&password=root";
						Connection conn = DriverManager.getConnection(connURL);
						for(int i=1; i<flightschedule_ids.length; i++){
							delstr += " OR flightschedule_id = ?";
						}
						PreparedStatement pstmt = conn.prepareStatement(delstr);
						for(int i=0; i<flightschedule_ids.length; i++){
							pstmt.setString(i+1,flightschedule_ids[i]);
						}
						int count = pstmt.executeUpdate();
						if(count > 0){%>
							<h3><%=count%> records deleted.</h3>
						<%}
						
					//deactivate the prepared statement 
						conn.close();
					} catch(Exception e) {%>
					<h3>The server was unable to perform the requested action. Please try again.</h3>
				<%}
					
				}else if(task.equals("individualdelete")){
					
					//declare and initialize variables 
					String flightschedule_id = request.getParameter("flightschedule_id");
					
					//activate the prepared statement 
					String delstr = "DELETE FROM flightschedule WHERE flightschedule_id = ?";
					
					try {
						Class.forName("com.mysql.jdbc.Driver"); 
						String connURL ="jdbc:mysql://localhost/spairlines?user=root&password=root";
						Connection conn = DriverManager.getConnection(connURL);
						PreparedStatement pstmt = conn.prepareStatement(delstr);
						pstmt.setString(1,flightschedule_id);
						int count = pstmt.executeUpdate();
						if(count > 0){%>
							<h3><%=count%> records deleted.</h3>
						<%}
						
					//deactivate the prepared statement 
						conn.close();
					} catch(Exception e) {%>
					<h3>The server was unable to perform the requested action. Please try again.</h3>
				<%}
					
				}else if(task.equals("individualupdate")){
					
					//declare and initialize variables 
					String flightschedule_id = request.getParameter("flightschedule_id");
					String[] updates = new String[14];
					updates[0] = request.getParameter("aircraft_id");
					updates[1] = request.getParameter("aircraft_flightno");
					updates[2] = request.getParameter("departure_airport");
					updates[3] = request.getParameter("departure_terminal"); 
					updates[4] = request.getParameter("arrival_airport");
					updates[5] = request.getParameter("arrival_terminal"); 
					updates[6] = request.getParameter("arrival_country");
					updates[7] = request.getParameter("arrival_city"); 
					updates[8] = request.getParameter("economy_cost");
					updates[9] = request.getParameter("business_cost"); 
					updates[10] = request.getParameter("first_cost"); 
					updates[11] = request.getParameter("departure_datetime");
					updates[12] = request.getParameter("arrival_datetime"); 
					updates[13] = request.getParameter("flight_time"); 
					
					String variables[] = new String[14];
					variables[0] = "aircraft_id";
					variables[1] = "aircraft_flightno";
					variables[2] = "departure_airport";
					variables[3] = "departure_terminal";
					variables[4] = "arrival_airport";
					variables[5] = "arrival_terminal";
					variables[6] = "arrival_country";
					variables[7] = "arrival_city";
					variables[8] = "economy_cost";
					variables[9] = "business_cost";
					variables[10] = "first_cost";
					variables[11] = "departure_datetime";
					variables[12] = "arrival_datetime";
					variables[13] = "flight_time";
					
					int county=0, counter=0;
					
					//for loop (count number of given variables)
					for(int i=0; i<updates.length; i++){
						if(!updates[i].isEmpty()){
							county += 1;
						}
					}
					
					//activate the prepared statement 
					String updtstr = "UPDATE flightschedule SET ";
					
					for(int i=0; i<updates.length; i++){
						if (!updates[i].isEmpty()){
							updtstr += variables[i] + " = ?";
							if (counter < county-1){
								updtstr += ", ";
								counter++; 
							}
						}
					}
					
					updtstr += " WHERE flightschedule_id = ?";
					
					try{
						Class.forName("com.mysql.jdbc.Driver"); 
						String connURL ="jdbc:mysql://localhost/spairlines?user=root&password=root";
						Connection conn = DriverManager.getConnection(connURL);
						PreparedStatement pstmt = conn.prepareStatement(updtstr);
						counter = 1; 
						for(int i=0; i<updates.length; i++){
							if (!updates[i].isEmpty()){
								pstmt.setString(counter,updates[i]);
								counter++; 
							}
						}
						pstmt.setString(counter,flightschedule_id);
						int count = pstmt.executeUpdate();
						if(count > 0){%>
							<h3><%=count%> records updated.</h3>
						<%}
						
					//deactivate the prepared statement 
						conn.close(); 
					} catch(Exception e) {%>
					<h3>The server was unable to perform the requested action. Please try again.</h3>
				<%}
				}%>
			</article>
		</div>
		
		<!-- Footer -->
		<%@include file="../files_other/footer.jsp"%>
	</body>
</html>