<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.DateFormat"%>
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
				<h1><strong>SP Airlines Management</strong></h1>
				<%
				//declare and initialize variables 
				String task = request.getParameter("task");
				String selectstr = "", selectstr2 = "";
				String[] flightschedule_ids = new String[100];
				int a=0;
				boolean records=false;
				
				if(task.equals("displayall")){%>

					<%//activate the prepared statement 
					selectstr = "SELECT * FROM flightschedule";
					
					try{
						Class.forName("com.mysql.jdbc.Driver"); 
						String connURL ="jdbc:mysql://localhost/spairlines?user=root&password=root";
						Connection conn = DriverManager.getConnection(connURL); 
						PreparedStatement pstmt = conn.prepareStatement(selectstr);
						ResultSet rs = pstmt.executeQuery();
					%>
					
					<!-- display the records -->	
					<% if(rs.next()) { 
						records=true;%>
						<h3 style="margin-bottom: 30px;">All flight schedules are shown below.</h3>
						<table class="table table-hover">
							<tr style=background-color:#D0D0D0><td>Flight Info</td><td>Departure</td><td>Arrival</td><td>Flight Time</td><td class="classcost" style="background-color: #0b664b">Economy</td><td class="classcost" style="background-color: #053870">Business</td><td class="classcost" style="background-color: #99422e">First</td><td colspan="2">Actions</td></tr>
							<%do{ 
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
								flightschedule_ids[a] = flightschedule_id;
								a++; 
							%>
							<tr><td><span style="font-weight: bold;">Flight ID</span><br><%=flightschedule_id%><br><br><span style="font-weight: bold;">Aircraft</span><br><%=aircraft_id%><br><br><span style="font-weight: bold;">Flight</span><br><%=aircraft_flightno%><br><br></td><td><%=departure_airport%><br>Terminal <%=departure_terminal%><br><%=departure_datetime%></td><td><%=arrival_airport%><br>Terminal <%=arrival_terminal%><br><%=arrival_datetime%><br><br><span style="font-weight: bold;">Arrive At</span><br><%=arrival_country%>, <%=arrival_city%><br></td><td><%=flight_time%></td><td style="text-align: center;"><%=economy_cost%></td><td style="text-align: center;"><%=business_cost%></td><td style="text-align: center;"><%=first_cost%></td>
							<td><form class="form-group" style="margin-top: 10px;" action="flightschedulebackend.jsp?task=individualdelete" method="POST">
							<input type="hidden" name="flightschedule_id" value=<%=flightschedule_id%>>
							<input type="submit" class="btn btn-danger" name="btndelete" value="Delete"></form></td>
							<td><form class="form-group" style="margin-top: 10px;" action="flightscheduleupdate.jsp" method="POST">
							<input type="hidden" name="flightschedule_id" value=<%=flightschedule_id%>>
							<input type="submit" class="btn btn-warning" name="btnupdate" value="Update"></form></td></tr>
							<%}while(rs.next());%>
						</table>
					<%}else{%>
						<h3>No related records were  found.</h3>
					<%}
					
					//deactivate the prepared statement
						conn.close();
					} catch (Exception e) {%>
					<h3>The server was unable to perform the requested action. Please try again.</h3>
				<%}
					
				}else if(task.equals("search")){%>
			
				<%	// declare and initialize variables   
					String[] parameters = new String[15];
					parameters[0] = request.getParameter("searchString");
					parameters[1] = request.getParameter("searchString2");
					parameters[2] = request.getParameter("searchString3");
					parameters[3] = request.getParameter("searchString4");
					parameters[4] = request.getParameter("searchString5");
					parameters[5] = request.getParameter("searchString6");
					parameters[6] = request.getParameter("searchString7");
					parameters[7] = request.getParameter("searchString8");
					parameters[8] = request.getParameter("searchString9");
					parameters[9] = request.getParameter("searchString10");
					parameters[10] = request.getParameter("searchString11");
					parameters[11] = request.getParameter("searchString12");
					parameters[12] = request.getParameter("searchString13");
					parameters[13] = request.getParameter("searchString14");
					parameters[14] = request.getParameter("searchString15");
					
					String[] variables = new String[15];
					variables[0] = "flightschedule_id";
					variables[1] = "aircraft_id";
					variables[2] = "aircraft_flightno";
					variables[3] = "departure_airport";
					variables[4] = "departure_terminal";
					variables[5] = "arrival_airport";
					variables[6] = "arrival_terminal";
					variables[7] = "arrival_country";
					variables[8] = "arrival_city";
					variables[9] = "economy_cost";
					variables[10] = "business_cost";
					variables[11] = "first_cost";
					variables[12] = "departure_datetime";
					variables[13] = "arrival_datetime";
					variables[14] = "flight_time";
					
					String[] conjunctions = new String[14];
					conjunctions[0] = request.getParameter("string2conjunction");
					conjunctions[1] = request.getParameter("string3conjunction");
					conjunctions[2] = request.getParameter("string4conjunction");
					conjunctions[3] = request.getParameter("string5conjunction");
					conjunctions[4] = request.getParameter("string6conjunction");
					conjunctions[5] = request.getParameter("string7conjunction");
					conjunctions[6] = request.getParameter("string8conjunction");
					conjunctions[7] = request.getParameter("string9conjunction");
					conjunctions[8] = request.getParameter("string10conjunction");
					conjunctions[9] = request.getParameter("string11conjunction");
					conjunctions[10] = request.getParameter("string12conjunction");
					conjunctions[11] = request.getParameter("string13conjunction");
					conjunctions[12] = request.getParameter("string14conjunction");
					conjunctions[13] = request.getParameter("string15conjunction");
					
					selectstr = "SELECT * FROM flightschedule WHERE ";
					
					int i=0, count=0, counter=0;
					
					//for loop (count number of given variables)
					for (i=0; i<parameters.length; i++){
						if (parameters[i] != ""){
							count++; 
						}
					}
					
					//for loop (combine the variables to form select string)
					for(i=0; i<parameters.length; i++){
						if (parameters[i] != "" && counter == 0){
							selectstr += variables[i] + " REGEXP ? ";
							counter++; 
						} else if (parameters[i] != "" && counter != count){
							selectstr += conjunctions[i-1] + " " + variables[i] + " REGEXP ? ";
							counter++; 
						}
			 		}
					
					//activate the prepared statement 
					try{
						Class.forName("com.mysql.jdbc.Driver"); 
						String connURL ="jdbc:mysql://localhost/spairlines?user=root&password=root";
						Connection conn = DriverManager.getConnection(connURL); 
						PreparedStatement pstmt = conn.prepareStatement(selectstr);
						counter = 1; 
						for(i=0; i<13; i++){
							if (!parameters[i].isEmpty()){
								pstmt.setString(counter,parameters[i]);
								counter++;
							}
						}
						ResultSet rs = pstmt.executeQuery();
					%>
					
					<!-- display the records -->	
					<% if(rs.next()) { 
						records=true;%>
						<h3 style="margin-bottom: 30px;">All flight schedules are shown below.</h3>
						<table class="table table-hover">
							<tr style=background-color:#D0D0D0><td>Flight Info</td><td>Departure</td><td>Arrival</td><td>Flight Time</td><td class="classcost" style="background-color: #0b664b">Economy</td><td class="classcost" style="background-color: #053870">Business</td><td class="classcost" style="background-color: #99422e">First</td><td colspan="2">Actions</td></tr>
							<%do{ 
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
								flightschedule_ids[a] = flightschedule_id;
								a++; 
							%>
							<tr><td><span style="font-weight: bold;">Flight ID</span><br><%=flightschedule_id%><br><br><span style="font-weight: bold;">Aircraft</span><br><%=aircraft_id%><br><br><span style="font-weight: bold;">Flight</span><br><%=aircraft_flightno%><br><br></td><td><%=departure_airport%><br>Terminal <%=departure_terminal%><br><%=departure_datetime%></td><td><%=arrival_airport%><br>Terminal <%=arrival_terminal%><br><%=arrival_datetime%><br><br><span style="font-weight: bold;">Arrive At</span><br><%=arrival_country%>, <%=arrival_city%><br></td><td><%=flight_time%></td><td style="text-align: center;"><%=economy_cost%></td><td style="text-align: center;"><%=business_cost%></td><td style="text-align: center;"><%=first_cost%></td>
							<td><form class="form-group" style="margin-top: 20px" action="flightschedulebackend.jsp?task=individualdelete" method="POST">
							<input type="hidden" name="flightschedule_id" value=<%=flightschedule_id%>>
							<input type="submit" class="btn btn-danger" name="btndelete" value="Delete"></form></td>
							<td><form class="form-group" style="margin-top: 20px" action="flightscheduleupdate.jsp" method="POST">
							<input type="hidden" name="flightschedule_id" value=<%=flightschedule_id%>>
							<input type="submit" class="btn btn-warning" name="btnupdate" value="Update"></form></td></tr>
							<%}while(rs.next());%>
						</table>
					<%}else{%>
						<h3>No related records were found.</h3>
					<%}
					
					//deactivate the prepared statement
					conn.close();
					} catch (Exception e) {%>
					<h3>The server was unable to perform the requested action. Please try again.</h3>
				<%}
				}
				
				//delete or update all records 
				if(records==true){%>
					<form class="form-group" action="flightschedulebackend.jsp?task=delete" method="POST" style="display: inline-block; margin-right: 20px;">
						<input type="submit" class="btn btn-danger" name="btnDelete" value="Delete All Flight Schedules">
						<%for (int b=0; b<a; b++){%>
							<input type="hidden" name="flightschedule_ids" value=<%=flightschedule_ids[b]%>>
						<%}%>
					</form>
					<form class="form-group" action="flightscheduleupdate2.jsp" method="POST" style="display: inline-block">
						<input type="submit" class="btn btn-warning" name="btnUpdate" value="Update All Flight Schedules">
						<%for (int b=0; b<a; b++){%>
							<input type="hidden" name="flightschedule_ids" value=<%=flightschedule_ids[b]%>>
						<%}%>
					</form>
				<%}%>
			</article>
		</div>
		
		<!-- Footer -->
		<%@include file="../files_other/footer.jsp"%>
	</body>
</html>




