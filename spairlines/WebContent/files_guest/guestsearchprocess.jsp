<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.DateFormat"%>
<%@ page import="java.util.Arrays" %>

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
				<!-- Title -->
				<h1><strong>Browse Flights</strong></h1>
				
				<%
				//declare and initialize variables 
				String task = request.getParameter("task");
				String selectstr = "", selectstr2 = "";
				String[] flightschedule_ids = new String[100];
				String[] parameters = new String[4];
				parameters[0] = request.getParameter("searchString");
				parameters[1] = request.getParameter("searchString2");
				parameters[2] = request.getParameter("searchString3");
				parameters[3] = request.getParameter("searchString4");
				
				if(task.equals("guestsearch")){
					selectstr = "SELECT * FROM flightschedule WHERE departure_airport = ? AND arrival_airport = ? AND DATE(departure_datetime) = ?";
					selectstr2 = "SELECT * FROM flightschedule WHERE departure_airport = ? AND arrival_airport = ? AND DATE(departure_datetime) = ?";
					
					int i=0, count=0, counter = 1; 
					
					//activate the prepared statement 
					//direct flight 
					try{
						Class.forName("com.mysql.jdbc.Driver"); 
						String connURL ="jdbc:mysql://localhost/spairlines?user=root&password=root";
						Connection conn = DriverManager.getConnection(connURL); 
						PreparedStatement pstmt = conn.prepareStatement(selectstr);
						for(i=0; i<3; i++){
							pstmt.setString(counter,parameters[i]);
							counter++;
						}
						ResultSet rs1 = pstmt.executeQuery(); %>
						
						<!-- display the records-->	
						<%if(rs1.next()){%>
							<h3 style="background-color: yellow; font-weight: bold; width: 120px; text-align: center;">Departure</h3>
							<h3 style="margin-bottom: 30px;">All available flights from <%=parameters[0]%> to <%=parameters[1]%> are shown below.</h3>
							<table class="table table-hover">
								<tr style=background-color:#D0D0D0><td>Flight ID</td><td>Flight Number</td><td>Departure</td><td>Arrival</td><td>Flight Time</td><td>Action</td></tr>
								<%do{ 
									String flightschedule_id = rs1.getString("flightschedule_id");
									String aircraft_flightno = rs1.getString("aircraft_flightno");
									String departure_airport = rs1.getString("departure_airport");
									String arrival_airport = rs1.getString("arrival_airport");
									String departure_datetime = (rs1.getString("departure_datetime")).substring(0,19);
									String arrival_datetime = (rs1.getString("arrival_datetime")).substring(0,19);
									String flight_time = rs1.getString("flight_time");
								%>
								<tr><td><%=flightschedule_id%></td><td><%=aircraft_flightno%></td><td><%=departure_airport%><br><%=departure_datetime%></td><td><%=arrival_airport%><br><%=arrival_datetime%></td><td><%=flight_time%></td>
								<td><form style="margin-top: 10px;" class="form-group" action="guestbackend.jsp" method="POST">
								<input type="hidden" name="flightschedule_id" value=<%=flightschedule_id%>>
								<input type="submit" class="btn btn-default" name="btnview" value="View"></form></td></tr>
								<%}while(rs1.next());%>
							</table>
						
						<%}else{
							
							//declare and initialize variables 
							String[] interDepar = new String[100];
							String[] interDeparAcc = new String[100];
							String[] interArriv = new String[100];
							int status=0;
							
							//activate the prepared statement 
							//interconnecting flight 
							//step 1: select flight schedules where arrival airport matches input 
							selectstr = "SELECT * FROM flightschedule WHERE arrival_airport = ?";
							pstmt = conn.prepareStatement(selectstr);
							pstmt.setString(1,parameters[1]);
							rs1 = pstmt.executeQuery();
							count=0;
							i=0;
							if(rs1.next()){
								status=1;
								do{
									interDepar[i] = rs1.getString("departure_airport");
									count++; 
									i++;
								}while(rs1.next());
							}
						
							//if arrival airport exists 
							if(status==1){
								//step 2: select flight schedules where interconnecting arrival airport matches interconnecting departure airport 
								selectstr = "SELECT * FROM flightschedule WHERE departure_airport = ? AND (arrival_airport = ? ";
								for(i=0; i<count-1; i++){
									selectstr += "OR arrival_airport = ? ";
								}
								
								selectstr += ") AND DATE(departure_datetime) = ?";
							
								pstmt = conn.prepareStatement(selectstr);
								pstmt.setString(1,parameters[0]);
								counter = 2;
								for(i=0; i<count; i++){
									pstmt.setString(i+2,interDepar[i]);
									counter++;
								}
								pstmt.setString(counter,parameters[2]);
								rs1 = pstmt.executeQuery();%>
								
								<!-- step 3: display the records -->
								<%if(rs1.next()){
									count=0;%>
									<h3 style="background-color: yellow; font-weight: bold; width: 120px; text-align: center;">Departure</h3>
									<h3 style="margin-bottom: 30px;">All available flights from <%=parameters[0]%> to the interconnecting airport(s) are shown below.</h3>
									<table class="table table-hover">
										<tr style=background-color:#D0D0D0><td>Flight ID</td><td>Flight Number</td><td>Departure</td><td>Arrival</td><td>Flight Time</td><td>Action</td></tr>
										<%
										i=0;
										do{ 
											String flightschedule_id = rs1.getString("flightschedule_id");
											String aircraft_flightno = rs1.getString("aircraft_flightno");
											String departure_airport = rs1.getString("departure_airport");
											String arrival_airport = rs1.getString("arrival_airport");
											String departure_datetime = (rs1.getString("departure_datetime")).substring(0,19);
											String arrival_datetime = (rs1.getString("arrival_datetime")).substring(0,19);
											String flight_time = rs1.getString("flight_time");
											interArriv[i] = arrival_airport;
											i++;
											count++; 
										%>
										<tr><td><%=flightschedule_id%></td><td><%=aircraft_flightno%></td><td><%=departure_airport%><br><%=departure_datetime%></td><td><%=arrival_airport%><br><%=arrival_datetime%></td><td><%=flight_time%></td>
										<td><form style="margin-top: 10px;" class="form-group" action="guestbackend.jsp" method="POST">
										<input type="hidden" name="flightschedule_id" value=<%=flightschedule_id%>>
										<input type="submit" class="btn btn-default" name="btnview" value="View"></form></td></tr>
										<%}while(rs1.next());%>
									</table>
								<%}else{%>
									<h3>No related records were found for the departure flight.</h3>
								<%}
								
								//step 4: select flight schedules where interconnecting arrival airport matches interconnecting departure airport 
								selectstr = "SELECT * FROM flightschedule WHERE arrival_airport = ? AND (departure_airport = ? ";
								for(i=0; i<count-1; i++){
									selectstr += "OR departure_airport = ? ";
								}
									
								selectstr += ")";
								
								pstmt = conn.prepareStatement(selectstr);
								pstmt.setString(1,parameters[1]);
								counter = 1;
								for(i=0; i<count; i++){
									pstmt.setString(i+2,interArriv[i]);
									counter++;
								}
								rs1 = pstmt.executeQuery();%>
							
								<!-- step 5: display the records -->
								<%if(rs1.next()){%>
									<h3 style="margin-bottom: 30px;">All available flights from the interconnecting airport(s) to <%=parameters[1]%> are shown below.</h3>
									<table class="table table-hover">
										<tr style=background-color:#D0D0D0><td>Flight ID</td><td>Flight Number</td><td>Departure</td><td>Arrival</td><td>Flight Time</td><td>Action</td></tr>
										<%do{ 
											String flightschedule_id = rs1.getString("flightschedule_id");
											String aircraft_flightno = rs1.getString("aircraft_flightno");
											String departure_airport = rs1.getString("departure_airport");
											String arrival_airport = rs1.getString("arrival_airport");
											String departure_datetime = (rs1.getString("departure_datetime")).substring(0,19);
											String arrival_datetime = (rs1.getString("arrival_datetime")).substring(0,19);
											String flight_time = rs1.getString("flight_time");
										%>
										<tr><td><%=flightschedule_id%></td><td><%=aircraft_flightno%></td><td><%=departure_airport%><br><%=departure_datetime%></td><td><%=arrival_airport%><br><%=arrival_datetime%></td><td><%=flight_time%></td>
										<td><form class="form-group" style="margin-top: 10px;" action="guestbackend.jsp" method="POST">
										<input type="hidden" name="flightschedule_id" value=<%=flightschedule_id%>>
										<input type="submit" class="btn btn-default" name="btnview" value="View"></form></td></tr>
										<%}while(rs1.next());%>
									</table>
								<%}
							}
						}
						
						//declare and initialize variables 
						if((!parameters[3].isEmpty()) && (parameters[2].compareTo(parameters[3]) < 0)){
							PreparedStatement pstmt2 = conn.prepareStatement(selectstr2);
							pstmt2.setString(1,parameters[1]);
							pstmt2.setString(2,parameters[0]);
							pstmt2.setString(3,parameters[3]);
							ResultSet rs2 = pstmt2.executeQuery();%> 
							
							<!-- display the records-->	
							<%if(rs2.next()) {%>
							<h3 style="background-color: yellow; font-weight: bold; width: 120px; text-align: center;">Arrival</h3>
							<h3 style="margin-bottom: 30px;">All available flights from <%=parameters[1]%> to <%=parameters[0]%> are shown below.</h3>
							<table class="table table-hover">
								<tr style=background-color:#D0D0D0><td>Flight ID</td><td>Flight Number</td><td>Departure</td><td>Arrival</td><td>Flight Time</td><td>Action</td></tr>
								<%do{ 
									String flightschedule_id = rs2.getString("flightschedule_id");
									String aircraft_flightno = rs2.getString("aircraft_flightno");
									String departure_airport = rs2.getString("departure_airport");
									String arrival_airport = rs2.getString("arrival_airport");
									String departure_datetime = (rs2.getString("departure_datetime")).substring(0,19);
									String arrival_datetime = (rs2.getString("arrival_datetime")).substring(0,19);
									String flight_time = rs2.getString("flight_time");
								%>
								<tr><td><%=flightschedule_id%></td><td><%=aircraft_flightno%></td><td><%=departure_airport%><br><%=departure_datetime%></td><td><%=arrival_airport%><br><%=arrival_datetime%></td><td><%=flight_time%></td>
								<td><form class="form-group" style="margin-top: 10px;" action="guestbackend.jsp" method="POST">
								<input type="hidden" name="flightschedule_id" value=<%=flightschedule_id%>>
								<input type="submit" class="btn btn-default" name="btnview" value="View"></form></td></tr>
								<%}while(rs2.next());%>
							</table>
							
							<%}else{
								
								//declare and initialize variables 
								String[] interDepar = new String[100];
								String[] interDeparAcc = new String[100];
								String[] interArriv = new String[100];
								int status=0;
								
								//activate the prepared statement 
								//interconnecting flight 
								//step 1: select flight schedules where arrival airport matches input 
								selectstr2 = "SELECT * FROM flightschedule WHERE arrival_airport = ?";
								pstmt2 = conn.prepareStatement(selectstr2);
								pstmt2.setString(1,parameters[0]);
								rs2 = pstmt2.executeQuery();
								count=0;
								i=0;
								if(rs2.next()){
									status=1;
									do{
										interDepar[i] = rs2.getString("departure_airport");
										count++;
										i++;
									}while(rs2.next());
								}
	
								//if arrival airport exists 
								if(status==1){
									//step 2: select flight schedules where interconnecting arrival airport matches interconnecting departure airport 
									selectstr2 = "SELECT * FROM flightschedule WHERE departure_airport = ? AND (arrival_airport = ? ";
									for(i=0; i<count-1; i++){
										selectstr2 += "OR arrival_airport = ? ";
									}
									
									selectstr2 += ") AND DATE(departure_datetime) = ?";
								
									pstmt2 = conn.prepareStatement(selectstr2);
									pstmt2.setString(1,parameters[1]);
									counter = 2;
									for(i=0; i<count; i++){
										pstmt2.setString(i+2,interDepar[i]);
										counter++;
									}
									
									pstmt2.setString(counter,parameters[3]);
									rs2 = pstmt2.executeQuery();%>
									
									<!-- step 3: display the records -->
									<%if(rs2.next()){
										count=0;%>
										<h3 style="background-color: yellow; font-weight: bold; width: 120px; text-align: center;">Arrival</h3>
										<h3 style="margin-bottom: 30px;">All available flights from <%=parameters[1]%> to the interconnecting airport(s) are shown below.</h3>
										<table class="table table-hover">
											<tr style=background-color:#D0D0D0><td>Flight ID</td><td>Flight Number</td><td>Departure</td><td>Arrival</td><td>Flight Time</td><td>Action</td></tr>
											<%
											i=0;
											do{ 
												String flightschedule_id = rs2.getString("flightschedule_id");
												String aircraft_flightno = rs2.getString("aircraft_flightno");
												String departure_airport = rs2.getString("departure_airport");
												String arrival_airport = rs2.getString("arrival_airport");
												String departure_datetime = (rs2.getString("departure_datetime")).substring(0,19);
												String arrival_datetime = (rs2.getString("arrival_datetime")).substring(0,19);
												String flight_time = rs2.getString("flight_time");
												interArriv[i] = arrival_airport;
												i++;
												count++; 
											%>
											<tr><td><%=flightschedule_id%></td><td><%=aircraft_flightno%></td><td><%=departure_airport%><br><%=departure_datetime%></td><td><%=arrival_airport%><br><%=arrival_datetime%></td><td><%=flight_time%></td>
											<td><form class="form-group" style="margin-top: 10px;" action="guestbackend.jsp" method="POST">
											<input type="hidden" name="flightschedule_id" value=<%=flightschedule_id%>>
											<input type="submit" class="btn btn-default" name="btnview" value="View"></form></td></tr>
											<%}while(rs2.next());%>
										</table>
									<%}else{%>
										<h3>No related records were found for the return flight.</h3>
									<%}
									
									//step 4: select flight schedules where interconnecting arrival airport matches interconnecting departure airport 
									selectstr2 = "SELECT * FROM flightschedule WHERE arrival_airport = ? AND (departure_airport = ? ";
									for(i=0; i<count-1; i++){
										selectstr2 += "OR departure_airport = ? ";
									}
									
									selectstr2 += ")";
									
									pstmt2 = conn.prepareStatement(selectstr2);
									pstmt2.setString(1,parameters[0]);
									counter = 1;
									for(i=0; i<count; i++){
										pstmt2.setString(i+2,interArriv[i]);
										counter++;
									}
									rs2 = pstmt2.executeQuery();%>
									
									<!-- step 5: display the records -->
									<%if(rs2.next()){%>
										<h3 style="margin-bottom: 30px;">All available flights from the interconnecting airport(s) to <%=parameters[0]%> are shown below.</h3>
										<table class="table table-hover">
											<tr style=background-color:#D0D0D0><td>Flight ID</td><td>Flight Number</td><td>Departure</td><td>Arrival</td><td>Flight Time</td><td>Action</td></tr>
											<%do{ 
												String flightschedule_id = rs2.getString("flightschedule_id");
												String aircraft_flightno = rs2.getString("aircraft_flightno");
												String departure_airport = rs2.getString("departure_airport");
												String arrival_airport = rs2.getString("arrival_airport");
												String departure_datetime = (rs2.getString("departure_datetime")).substring(0,19);
												String arrival_datetime = (rs2.getString("arrival_datetime")).substring(0,19);
												String flight_time = rs2.getString("flight_time");
											%>
											<tr><td><%=flightschedule_id%></td><td><%=aircraft_flightno%></td><td><%=departure_airport%><br><%=departure_datetime%></td><td><%=arrival_airport%><br><%=arrival_datetime%></td><td><%=flight_time%></td>
											<td><form class="form-group" style="margin-top: 10px; action="guestbackend.jsp" method="POST">
											<input type="hidden" name="flightschedule_id" value=<%=flightschedule_id%>>
											<input type="submit" class="btn btn-default" name="btnview" value="View"></form></td></tr>
											<%}while(rs2.next());%>
										</table>
									<%}%>
								<%}else{%>
									<h3>No related records were found for the return flight.</h3> 
								<%}
							}
						}else if((!parameters[3].isEmpty()) && (parameters[2].compareTo(parameters[3]) > 0)){%>
							<h3 class="bg-danger" style="padding: 10px;">The return date needs to be after the departure date.</h3>
						<%}%>
						
					<%
					//deactivate the prepared statement
					conn.close();
					}catch (Exception e) {%>
					<h3>The server was unable to perform the requested action. Please try again.</h3>
				<%}
					
				}else if(task.equals("guestdisplayall")){
					
					//activate the prepared statement 
					selectstr = "SELECT * FROM flightschedule";
					
					try{
						Class.forName("com.mysql.jdbc.Driver"); 
						String connURL = "jdbc:mysql://localhost/spairlines?user=root&password=root";
						Connection conn = DriverManager.getConnection(connURL); 
						PreparedStatement pstmt = conn.prepareStatement(selectstr);
						ResultSet rs = pstmt.executeQuery();
					%>
					
					<!-- display the records -->	
					<% if(rs.next()) {%>
							<h3 style="margin-bottom: 30px;">All available flights are shown below.</h3>
							<table class="table table-hover">
								<tr style=background-color:#D0D0D0><td>Flight ID</td><td>Flight Number</td><td>Departure</td><td>Arrival</td><td>Flight Time</td><td>Action</td></tr>
								<%do{ 
									String flightschedule_id = rs.getString("flightschedule_id");
									String aircraft_flightno = rs.getString("aircraft_flightno");
									String departure_airport = rs.getString("departure_airport");
									String arrival_airport = rs.getString("arrival_airport");
									String departure_datetime = (rs.getString("departure_datetime")).substring(0,19);
									String arrival_datetime = (rs.getString("arrival_datetime")).substring(0,19);
									String flight_time = rs.getString("flight_time");
								%>
								<tr><td><%=flightschedule_id%></td><td><%=aircraft_flightno%></td><td><%=departure_airport%><br><%=departure_datetime%></td><td><%=arrival_airport%><br><%=arrival_datetime%></td><td><%=flight_time%></td>
								<td><form style="margin-top: 10px;" class="form-group" action="guestbackend.jsp" method="POST">
								<input type="hidden" name="flightschedule_id" value=<%=flightschedule_id%>>
								<input type="submit" class="btn btn-default" name="btnview" value="View"></form></td></tr>
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
				%>
			</article>
		</div>
		
		<!-- Footer -->
		<%@include file="../files_other/footer.jsp"%>
	</body>
</html>




