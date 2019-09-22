<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.*"%>
<%@page import="dbaccess.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>SpAirlines</title>
	</head>
	<body>
		<!-- Admin Navigation -->
		<nav class="navbar navbar-default">
			<div class="container-fluid">
				<ul class="nav navbar-nav navbar-left">
					<span class="navbar-text" style="height: 8px;">You are currently within the <span style="color: #2980b9; font-weight: bold;">Booking Portal</span>.</span>
				</ul>
				<ul class="nav navbar-nav navbar-right">
			    	<li style="background-color: #afafaf; margin-right: 20px;"><a href="<%=request.getContextPath()%>/KillSessionServlet" style="color: #000000;">Cancel Booking</a></li>
		    	</ul>
	    	</div>
		</nav>
		
		<!-- Guest Summary -->
		<%
		// declare and initialize variables 
		String departure_aircraft_flightno = "", departure_departure_datetime = "", departure_arrival_datetime = "", departure_flight_time = "", departure_departure_city = "", departure_arrival_city = "";
		String arrival_aircraft_flightno = "", arrival_departure_datetime = "", arrival_arrival_datetime = "", arrival_flight_time = "", arrival_departure_city = "", arrival_arrival_city = "";
		Long departure_cabin_cost = null, arrival_cabin_cost = null, total_cabin_cost = null; 
		String uri = request.getRequestURI();
		String url = uri.substring(uri.lastIndexOf("/")+1);
		ArrayList<Bk_guest> guestsummary = null; 
		
		// generate the summary 
		ArrayList<Bk_welcome> flightsummary = (ArrayList<Bk_welcome>)session.getAttribute("flightsretrieved");
		if(!url.equals("bk_flight.jsp")){
			ArrayList<Bk_flight> flightcart = (ArrayList<Bk_flight>)session.getAttribute("flightcart"); 
			for(Bk_welcome flight : flightsummary){
				if(flight.getFlightschedule_id() == flightcart.get(0).getFlightschedule_id()){
					departure_aircraft_flightno = " | " + flight.getAircraft_flightno(); 
					departure_departure_datetime = flight.getDeparture_datetime().substring(0, 10) + ", " + flight.getDeparture_datetime().substring(11, 16);
					departure_arrival_datetime = flight.getArrival_datetime().substring(0, 10) + ", " + flight.getArrival_datetime().substring(11, 16);
					departure_flight_time = flight.getFlight_time().substring(0,5); 
					departure_cabin_cost = flight.getCabin_cost(); 
					departure_departure_city = flight.getDeparture_city(); 
					departure_arrival_city = flight.getArrival_city(); 
				}else if(flight.getFlightschedule_id() == flightcart.get(1).getFlightschedule_id()){
					arrival_aircraft_flightno = " | " + flight.getAircraft_flightno(); 
					arrival_departure_datetime = flight.getDeparture_datetime().substring(0, 10) + ", " + flight.getDeparture_datetime().substring(11,16);
					arrival_arrival_datetime = flight.getArrival_datetime().substring(0, 10) + ", " + flight.getArrival_datetime().substring(11,16);
					arrival_flight_time = flight.getFlight_time().substring(0,5);
					arrival_cabin_cost = flight.getCabin_cost(); 
					arrival_departure_city = flight.getDeparture_city();
					arrival_arrival_city = flight.getArrival_city(); 
				}
			}
			
			if(arrival_cabin_cost != null){
				total_cabin_cost = arrival_cabin_cost + departure_cabin_cost;
			}else{
				total_cabin_cost = departure_cabin_cost; 
			}
		}
		
		if((url.equals("bk_guest.jsp")) || (url.equals("bk_payment.jsp"))){
			guestsummary = (ArrayList<Bk_guest>)session.getAttribute("guestcart");
		}
		%>
		<nav class="navbar navbar-default bookingnav">
			<div class="container-fluid">
				<ul class="nav navbar-nav navbar-left">
					<li style="margin-right: 40px; margin-top: 1px;"><a href="#" style="color: #ffffff; font-weight: bold; font-size: 26px;"><%=flightsummary.get(0).getDeparture_iata()%><span class="glyphicon glyphicon-menu-right"></span><%=flightsummary.get(0).getArrival_iata()%></a></li>
					<p class="navbar-text" style="color: #ffffff; margin-top: 7px; margin-bottom: 0px;"><span style="font-weight: bold">Depart - </span><%=session.getAttribute("flight_departuredate")%>
						<%if(session.getAttribute("flight_tripType").equals("return")){%>
							<br><span style="font-weight: bold">Return - </span><%=session.getAttribute("flight_returndate")%></p>
						<%}%>
				</ul>
				<ul class="nav navbar-nav navbar-right">
			    	<li style="margin-right: 40px; margin-top: 8px;"><a role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseOne" aria-expanded="false" aria-controls="collapseOne" style="color: #ffffff; font-weight: bold; font-size: 26px;">View Summary</a></li>
		    	</ul>
	    	</div>
		</nav>
		
		<!-- Enhanced Guest Summary -->
		<div id="collapseOne" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingOne" style="padding: 30px; background-color: #85929e;">
	    	<div class="panel-body" style="background-color: #ebedef; padding: 20px;">
	    		<div style="width: 60%; float: left;">
		        	<div style="background-color: #ffffff; height: 140px; padding: 20px;">
		        		<div style="float: left">
			        		<p>DEPARTING <%=departure_aircraft_flightno%></p>
			        		<h2 style="font-family: Optima, Verdana, Arial, sans-serif; margin-top: 2px;"><%=session.getAttribute("flight_fromcountry")%> to <%=session.getAttribute("flight_tocountry")%></h2>
			        		<%if(departure_departure_city!=""){%>
			        			<p style="font-weight: bold"><%=departure_departure_city%> to <%=departure_arrival_city%></p>
			        		<%}%>
			        	</div>
			        	<%if(departure_departure_datetime != ""){%>
				        	<div style="float: left; margin-left: 40px;">
				        		<p><span style="font-weight: bold; margin-right: 45px;">Departs</span><%=departure_departure_datetime%><br>
				        		 <span style="font-weight: bold; margin-right: 52px;">Arrives</span><%=departure_arrival_datetime%><br>
				        		 <span style="font-weight: bold; margin-right: 20px;">Flight Time</span><%=departure_flight_time.substring(0,2)%> h <%=departure_flight_time.substring(3,5)%> m<br>
				        		 </p>
				        	</div>
				        <%}%>
		        	</div><br>
		        	<%if(session.getAttribute("flight_tripType").equals("return")){%>
			        	<div style="background-color: #ffffff; height: 140px; padding: 20px;">
			        		<div style="float: left">
				        		<p>RETURNING <%=arrival_aircraft_flightno%></p>
				        		<h2 style="font-family: Optima, Verdana, Arial, sans-serif; margin-top: 2px;"><%=session.getAttribute("flight_tocountry")%> to <%=session.getAttribute("flight_fromcountry")%></h2>
				        		<%if(arrival_departure_city!=""){%>
				        			<p style="font-weight: bold"><%=arrival_departure_city%> to <%=arrival_arrival_city%></p>
				        		<%}%>
				        	</div>
				        	<%if(arrival_departure_datetime != ""){%>
					        	<div style="float: left; margin-left: 40px;">
					        		<p><span style="font-weight: bold; margin-right: 45px;">Departs</span><%=arrival_departure_datetime%><br>
					        		 <span style="font-weight: bold; margin-right: 52px;">Arrives</span><%=arrival_arrival_datetime%><br>
					        		 <span style="font-weight: bold; margin-right: 20px;">Flight Time</span><%=arrival_flight_time.substring(0,2)%> h <%=arrival_flight_time.substring(3,5)%> m<br>
					        		 </p>
					        	</div>
				        	<%}%>
			        	</div>
			        <%}%>
		        </div>
		        <div style="margin-left: 7.5%; width: 30%; float: left;">
		        	<h2 style="font-family: Optima, Verdana, Arial, sans-serif; margin-top: 2px; text-align: center; border-bottom: 2px solid black;">Total Fare</h2>
		        	<h3 style="background-color: <%=session.getAttribute("bk_seatColor")%>; color: #ffffff; padding: 8px 4px; text-align: center;"><%=session.getAttribute("bk_seatType")%> Class<br><span style="font-size: 14px"><%=session.getAttribute("bk_noOfSeats")%> Passengers</span></h3>
		        	<%if(guestsummary!=null){%>
		        		<h3 style="background-color: #85929e; color: #ffffff; padding: 8px 4px; text-align: center; font-size: 16px"><a style="color: #ffffff"role="button" data-toggle="collapse" href="#collapseExample" aria-expanded="false" aria-controls="collapseExample"">View Passenger Details</a></h3>
		        	<%}%>
		        	<%if(total_cabin_cost!=null){%>
		        		<h1 style="text-align: center;">SGD <%=total_cabin_cost%></h1>
		        	<%}%>
		        </div>
	      	</div>
	      	<%if(guestsummary!=null){%>
		      	<div class="collapse" id="collapseExample" style="background-color: #ebedef; padding: 20px;">
		      		<h2 style="font-family: Optima, Verdana, Arial, sans-serif; margin-top: 2px; text-align: center; border-bottom: 2px solid black;">Passenger Details</h2>
		      		<table class="table table-hover" style="width: 100%">
						<tr style=background-color:#D0D0D0><td>No.</td><td>Salutation</td><td>Full Name</td><td>Passport Number</td></tr>
						<%for(int i=0; i<guestsummary.size(); i++){
							String guest_salutation = guestsummary.get(i).getGuest_salutation();
							String guest_firstname = guestsummary.get(i).getGuest_firstname();
							String guest_lastname = guestsummary.get(i).getGuest_lastname();
							String guest_passportno = guestsummary.get(i).getGuest_passportno();%>
							<tr><td><%=i+1%></td><td><%=guest_salutation%></td><td><%=guest_firstname%> <%=guest_lastname%></td><td><%=guest_passportno%></td></tr>
						<%}%>
					</table>
				</div>
			<%}%>
		</div>
	</body>
</html>