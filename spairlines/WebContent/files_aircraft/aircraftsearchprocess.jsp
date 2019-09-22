<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@page import="java.util.Arrays" %>
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
				String task = request.getParameter("task");
				String selectstr = "";
				String[] aircraft_ids = new String[100];
				int a=0;
				boolean records=false;
				
				if(task.equals("displayall")){
					
					//activate the prepared statement 
					selectstr = "SELECT * FROM aircraft";
					
					try{
						Class.forName("com.mysql.jdbc.Driver"); 
						String connURL ="jdbc:mysql://localhost/spairlines?user=root&password=root";
						Connection conn = DriverManager.getConnection(connURL); 
						PreparedStatement pstmt = conn.prepareStatement(selectstr);
						ResultSet rs = pstmt.executeQuery();
					%>
					
					<!-- DISPLAY THE RECORDS -->	
					<% if(rs.next()) { 
						records=true;%>
						<h3 style="margin-bottom: 30px;">All aircrafts are shown below.</h3>
						<table class="table table-hover">
							<tr style=background-color:#D0D0D0><td>Aircraft ID</td><td>Aircraft Model</td><td>Flight Number</td><td>Passenger Capacity</td><td>Image Path</td><td colspan="2">Actions</td></tr>
							<%do{ 
								String aircraft_id = rs.getString("aircraft_id");
								String aircraft_model = rs.getString("aircraft_model");
								String aircraft_flightno = rs.getString("aircraft_flightno");
								String passenger_capacity = rs.getString("passenger_capacity");
								String image_path = rs.getString("image_path");
								aircraft_ids[a] = aircraft_id;
								a++; 
							%>
							<tr><td><%=aircraft_id%></td><td><%=aircraft_model%></td><td><%=aircraft_flightno%></td><td><%=passenger_capacity%></td><td><%=image_path%></td>
							<td><form style="margin-top: 10px;" class="form-group" action="aircraftbackend.jsp?task=individualdelete" method="POST">
							<input type="hidden" name="aircraft_id" value=<%=aircraft_id%>>
							<input type="submit" class="btn btn-danger" name="btndelete" value="Delete"></form></td>
							<td><form style="margin-top: 10px;" class="form-group" action="aircraftupdate.jsp" method="POST">
							<input type="hidden" name="aircraft_id" value=<%=aircraft_id%>>
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
					
				}else if(task.equals("search")){
					
					//declare and initialize variables   
					String[] parameters = new String[5];
					parameters[0] = request.getParameter("searchString");
					parameters[1] = request.getParameter("searchString2");
					parameters[2] = request.getParameter("searchString3");
					parameters[3] = request.getParameter("searchString4");
					parameters[4] = request.getParameter("searchString5");
					
					String[] variables = new String[5];
					variables[0] = "aircraft_id";
					variables[1] = "aircraft_model";
					variables[2] = "aircraft_flightno";
					variables[3] = "passenger_capacity";
					variables[4] = "image_path";
					
					String[] conjunctions = new String[4];
					conjunctions[0] = request.getParameter("string2conjunction");
					conjunctions[1] = request.getParameter("string3conjunction");
					conjunctions[2] = request.getParameter("string4conjunction");
					conjunctions[3] = request.getParameter("string5conjunction");
					
					selectstr = "SELECT * FROM aircraft WHERE ";
					
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
						for(i=0; i<5; i++){
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
						<h3 style="margin-bottom: 30px;">All aircrafts are shown below.</h3>
						<table class="table table-hover">
							<tr style=background-color:#D0D0D0><td>Aircraft ID</td><td>Aircraft Model</td><td>Flight Number</td><td>Passenger Capacity</td><td>Image Path</td><td colspan="2">Actions</td></tr>
							<%do{ 
								String aircraft_id = rs.getString("aircraft_id");
								String aircraft_model = rs.getString("aircraft_model");
								String aircraft_flightno = rs.getString("aircraft_flightno");
								String passenger_capacity = rs.getString("passenger_capacity");
								String image_path = rs.getString("image_path");
								aircraft_ids[a] = aircraft_id;
								a++; 
							%>
							<tr><td><%=aircraft_id%></td><td><%=aircraft_model%></td><td><%=aircraft_flightno%></td><td><%=passenger_capacity%></td><td><%=image_path%></td>
							<td><form style="margin-top: 10px;" class="form-group" action="aircraftbackend.jsp?task=individualdelete" method="POST">
							<input type="hidden" name="aircraft_id" value=<%=aircraft_id%>>
							<input type="submit" class="btn btn-danger" name="btndelete" value="Delete"></form></td>
							<td><form class="form-group" action="aircraftupdate.jsp" method="POST">
							<input type="hidden" name="aircraft_id" value=<%=aircraft_id%>>
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
					<form class="form-group" action="aircraftbackend.jsp?task=delete" method="POST" style="display: inline-block; margin-right: 20px;">
						<input type="submit" class="btn btn-danger" name="btnDelete" value="Delete All Aircrafts">
						<%for (int b=0; b<a; b++){%>
							<input type="hidden" name="aircraft_ids" value=<%=aircraft_ids[b]%>>
						<%}%>
					</form>
					<form class="form-group" action="aircraftupdate2.jsp" method="POST" style="display: inline-block">
						<input type="submit" class="btn btn-warning" name="btnUpdate" value="Update All Aircrafts">
						<%for (int b=0; b<a; b++){%>
							<input type="hidden" name="aircraft_ids" value=<%=aircraft_ids[b]%>>
						<%}%>
					</form>
				<%}%>
			</article>
		</div>
		
		<!-- Footer -->
		<%@include file="../files_other/footer.jsp"%>
	</body>
</html>




