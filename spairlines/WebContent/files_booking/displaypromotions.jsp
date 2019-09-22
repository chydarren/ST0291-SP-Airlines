<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import = "dbaccess.AdminBookings" %>   
<%@page import = "java.util.ArrayList" %>    
<%@page import="dbaccess.Bk_promotion" %> 
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
				<li><a href="<%=request.getContextPath()%>/files_aircraft/aircraftinsert.jsp">Insert Aircraft</a></li>
				<li><a href="<%=request.getContextPath()%>/files_aircraft/aircraftsearch.jsp">Update/Delete Aircrafts</a></li>
				<li><a href="<%=request.getContextPath()%>/files_flight/flightscheduleinsert.jsp">Insert Flight Schedule</a></li>
				<li><a href="<%=request.getContextPath()%>/files_flight/flightschedulesearch.jsp">Update/Delete Flight Schedules</a></li>
				<li><a href="files_booking/bookingform.jsp">View Flight Bookings</a></li>
				<li class="active"><a href="files_booking/promotions.jsp">Insert/Delete Promotions</a></li>
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
				if(session.getAttribute("delpromotionstat")!=null){
					if(session.getAttribute("delpromotionstat").equals("YES")){%>
						<div class="alert alert-success" role="alert" style="width: 70%; margin: 0 auto; margin-top: 30px;">The promotion was successfully deleted.</div>
						<%session.setAttribute("delpromotionstat", null);%>
					<%}else if(session.getAttribute("delpromotionstat").equals("NO")){%>
						<div class="alert alert-danger" role="alert" style="width: 70%; margin: 0 auto; margin-top: 30px;">An error occurred during the deletion. Please try again.</div>
						<%session.setAttribute("delpromotionstat", null);%>
					<%}
				}%>
				<%
				ArrayList<Bk_promotion> promotionsretrieved = (ArrayList<Bk_promotion>)session.getAttribute("promotionsretrieved");
				if(promotionsretrieved!=null){%>
					<h3 style="margin-bottom: 30px;">All promotions are shown below.</h3>
					<table class="table table-hover" style="width: 80%; margin: 0 auto; margin-top: 30px;">
						<tr style=background-color:#D0D0D0><td>Start Date</td><td>End Date</td><td>Departure</td><td>Arrival</td><td>Cabin Class</td><td>Promotion Fare</td><td>Action</td></tr>
						<%for(Bk_promotion promotion : promotionsretrieved){
							int promotion_id = promotion.getPromotion_id(); 
							String promotion_startdate = promotion.getPromotion_startdate(); 
							String promotion_enddate = promotion.getPromotion_enddate(); 
							String promotion_departure_country = promotion.getPromotion_departure_country();
							String promotion_arrival_country = promotion.getPromotion_arrival_country(); 
							String cabin_class = promotion.getSeat_type();
							Long cabin_cost = promotion.getCabin_cost(); %>
							<tr><td><%=promotion_startdate%></td><td><%=promotion_enddate%></td><td><%=promotion_departure_country%></td><td><%=promotion_arrival_country%></td><td><%=cabin_class%></td><td>SGD <%=cabin_cost%></td>
							<td>
							<form class="form-group" style="margin-top: 10px;" action="<%=request.getContextPath()%>/DeletePromotionServlet" method="POST">
							<input type="hidden" name="promotion_id" value=<%=promotion_id%>>
							<input type="button" name="btnSubmit" value="Delete" class="btn btn-danger" onclick="confirmDeleteModal();">
							<!-- Confirmation Modal -->
							<div class="modal fade" id="deleteModal" role="dialog">
								<div class="modal-dialog">
							   		<div class="modal-content">
							      		<div class="modal-header">
							        		<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
							        		<h3 style="font-weight: bold; color: #2980b9">Confirm Delete</h3>
							      		</div>
								      	<div class="modal-body">
								        	<p>Please confirm that you want to delete the flight promotion.</p>
								      	</div>
								      	<div class="modal-footer">
								        	<button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
								        	<input type="submit" name="btnNext" class="btn btn-danger" value="Delete">
								      	</div>
							    	</div>
							  	</div>
							</div>
							</form></td></tr>
						<%}%>
					</table>
				<%}else{%>
					<h3>No related records were found.</h3>
				<%}%>
			</article>
		</div>
		<script>
		function confirmDeleteModal() {
			$('#deleteModal').modal();
		}
		</script>
	</body>
	<!-- Footer -->
	<%@include file="../files_other/footer.jsp"%>
</html>