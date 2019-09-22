<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import = "dbaccess.Bk_welcome" %>   
<%@page import = "java.util.ArrayList" %> 

<%
response.setHeader("Cache-Control","no-cache"); //Forces caches to obtain a new copy of the page from the origin server
response.setHeader("Cache-Control","no-store"); //Directs caches not to store the page under any circumstance
response.setDateHeader("Expires", 0); //Causes the proxy cache to see the page as "stale"
response.setHeader("Pragma","no-cache"); //HTTP 1.0 backward compatibility

String track_flight = (String)session.getAttribute("track-flight");
if(track_flight == null){
	response.sendRedirect("../KillSessionServlet");
	return;
}
%>

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
		
			<!-- Admin Navigation and Guest Summary -->
			<%@include file="bk_guest_summary.jsp"%>
			
			<!-- Article -->
			<article>
				<!-- Title -->
				<h1><b>Flight Reservation</b></h1>
				<h3>Please select your preferred flight(s).</h3>
				<%if(session.getAttribute("flightstat")!=null){%>
					<div class="alert alert-danger" role="alert" style="width: 70%; margin: 0 auto; margin-top: 30px;">
					<button type="button" class="close" data-dismiss="alert" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					An unexpected error occurred. Please ensure you have chosen the a flight for your departure, and return (if any).
					</div>
				<%}%>
				
				<!-- Flight Information -->		
				<%
				int counter=0;
				ArrayList<Bk_welcome> flightsretrieved = (ArrayList<Bk_welcome>)session.getAttribute("flightsretrieved");
				if(flightsretrieved!=null){%>
				<form name="bookflight" class="form-horizontal" method="POST" action="<%=request.getContextPath()%>/AddToCart_flight">
					<h3 style="background-color: yellow; font-weight: bold; width: 120px; text-align: center;">Departure</h3>
					<h3 style="margin-bottom: 30px;">All available flights from <%=flightsretrieved.get(0).getDeparture_country()%> to <%=flightsretrieved.get(0).getArrival_country()%> are shown below.</h3>
					<table class="table table-hover" style="width: 80%">
						<tr style=background-color:#D0D0D0><td>Flight Info</td><td>Departure</td><td>Arrival</td><td style="text-align: center; background-color: <%=session.getAttribute("bk_seatColor")%>; color: #ffffff"><%=session.getAttribute("bk_seatType")%></td></tr>
						<%for(Bk_welcome flight : flightsretrieved){
							int flightschedule_id = flight.getFlightschedule_id();
							int aircraft_id = flight.getAircraft_id();
							String aircraft_flightno = flight.getAircraft_flightno();
							String departure_IATA = flight.getDeparture_iata();
							String departure_airport = flight.getDeparture_airport(); 
							char departure_terminal = flight.getDeparture_terminal();
							String departure_country = flight.getDeparture_country();
							String arrival_IATA = flight.getArrival_iata();
							String arrival_airport = flight.getArrival_airport(); 
							char arrival_terminal = flight.getArrival_terminal();
							String arrival_country = flight.getArrival_country(); 
							Long cabin_cost = flight.getCabin_cost(); 
							String departure_datetime = flight.getDeparture_datetime(); 
							String arrival_datetime = flight.getArrival_datetime();
							if(departure_country.equals(flightsretrieved.get(0).getDeparture_country())){%>
							<tr><td><span style="font-weight: bold;">Aircraft</span><br><%=aircraft_id%><br><br><span style="font-weight: bold;">Flight</span><br><%=aircraft_flightno%></td>
							<td><h3><%=departure_IATA%> <%=departure_datetime.substring(10,16)%></h3><%=departure_country%><br><%=departure_datetime.substring(0,10)%><br><%=departure_airport%><br>Terminal <%=departure_terminal%><br><br></td>
							<td><h3><%=arrival_IATA%> <%=arrival_datetime.substring(10,16)%></h3><%=arrival_country%><br><%=arrival_datetime.substring(0,10)%><br><%=arrival_airport%><br>Terminal <%=arrival_terminal%><br><br></td>
							<td style="text-align: center; vertical-align: middle;"><input type="radio" name="flight_departure" value=<%=flightschedule_id%> 
							<%
							if(cabin_cost == 0){%>
								disabled 
							<%}
							%> required><br><span style="font-weight: bold;">
							<%if(cabin_cost != 0){%>
								SGD <%=cabin_cost%></span><br><%=session.getAttribute("bk_noOfSeats")%> Passenger(s)
							<%}else{%>
								<p>Cabin class not available.<br>
								Please select other flights (if available)<br>
								or re-book your flight with a different cabin class.
								</p>
							<%}%></td></tr>
						<%}
					}%>
					</table>
				<%}%>
				
				<%if(flightsretrieved!=null && (session.getAttribute("flight_tripType").equals("return"))){%>
					<%for(Bk_welcome flight : flightsretrieved){
						int flightschedule_id = flight.getFlightschedule_id();
						int aircraft_id = flight.getAircraft_id();
						String aircraft_flightno = flight.getAircraft_flightno();
						String departure_IATA = flight.getDeparture_iata();
						String departure_airport = flight.getDeparture_airport(); 
						char departure_terminal = flight.getDeparture_terminal();
						String departure_country = flight.getDeparture_country();
						String arrival_IATA = flight.getArrival_iata();
						String arrival_airport = flight.getArrival_airport(); 
						char arrival_terminal = flight.getArrival_terminal();
						String arrival_country = flight.getArrival_country(); 
						Long cabin_cost = flight.getCabin_cost(); 
						String departure_datetime = flight.getDeparture_datetime(); 
						String arrival_datetime = flight.getArrival_datetime();
						if(departure_country.equals(flightsretrieved.get(0).getArrival_country())){%>
							<%if(counter==0){%>
								<h3 style="background-color: yellow; font-weight: bold; width: 120px; text-align: center;">Arrival</h3>
								<h3 style="margin-bottom: 30px;">All available flights from <%=flightsretrieved.get(0).getArrival_country()%> to <%=flightsretrieved.get(0).getDeparture_country()%> are shown below.</h3>
								<table class="table table-hover" style="width: 80%">
									<tr style=background-color:#D0D0D0><td>Flight Info</td><td>Departure</td><td>Arrival</td><td style="text-align: center; background-color: <%=session.getAttribute("bk_seatColor")%>; color: #ffffff"><%=session.getAttribute("bk_seatType")%></td></tr>
								<%counter++; 
							}%>
							<tr><td><span style="font-weight: bold;">Aircraft</span><br><%=aircraft_id%><br><br><span style="font-weight: bold;">Flight</span><br><%=aircraft_flightno%></td>
							<td><h3><%=departure_IATA%> <%=departure_datetime.substring(10,16)%></h3><%=departure_country%><br><%=departure_datetime.substring(0,10)%><br><%=departure_airport%><br>Terminal <%=departure_terminal%><br><br></td>
							<td><h3><%=arrival_IATA%> <%=arrival_datetime.substring(10,16)%></h3><%=arrival_country%><br><%=arrival_datetime.substring(0,10)%><br><%=arrival_airport%><br>Terminal <%=arrival_terminal%><br><br></td>
							<td style="text-align: center; vertical-align: middle;"><input type="radio" name="flight_arrival" value=<%=flightschedule_id%> 
							<%
							if(cabin_cost == 0){%>
								disabled 
							<%}
							%> required><br><span style="font-weight: bold;">
							<%if(cabin_cost != 0){%>
								SGD <%=cabin_cost%></span><br><%=session.getAttribute("bk_noOfSeats")%> Passenger(s)
							<%}else{%>
								<p>Cabin class not available.<br>
								Please select other flights (if available)<br>
								or re-book your flight with a different cabin class.
								</p>
							<%}%></td></tr>
						<%}%>
					<%}%>
					</table>
				<%}%>
					<div class="form-group">
						<div class="col-sm-offset-4">
							<input type="submit" name="btnSubmit" value="Proceed" class="btn btn-info">
						</div>
					</div>
				</form>
			</article>		
		</div>
		
		<!-- Footer -->
		<%@include file="../files_other/footer.jsp"%>
	</body>
</html>