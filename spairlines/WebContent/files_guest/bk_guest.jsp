<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.*"%>
<%@page import="dbaccess.*" %>

<%
response.setHeader("Cache-Control","no-cache"); //Forces caches to obtain a new copy of the page from the origin server
response.setHeader("Cache-Control","no-store"); //Directs caches not to store the page under any circumstance
response.setDateHeader("Expires", 0); //Causes the proxy cache to see the page as "stale"
response.setHeader("Pragma","no-cache"); //HTTP 1.0 backward compatibility

String track_guest = (String)session.getAttribute("track-guest");
if(track_guest == null){
	response.sendRedirect("../KillSessionServlet");
	return;
}%>

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
				<!-- Form Counts -->
				<% 
				// declare and initialize variables 
				Integer bk_noOfSeats = (Integer) session.getAttribute("bk_noOfSeats");
				Integer count = (Integer) session.getAttribute("guestcount");
				
				// no of passengers filled in 
				if(count==null){
					count = 0;
					session.setAttribute("guestcount", count);
				}
				String actionText = "Next Passenger";
				String onclickText = "confirmGuestModal()";
				String onsubmitText = "checkGuestForm()"; 
				
				// filled in all passengers 
				session.setAttribute("bk_noOfSeats",bk_noOfSeats);
				if((count+1) == bk_noOfSeats){
					actionText = "Proceed to Payment"; 
					onclickText = "confirmContactModal()";
					onsubmitText = "checkContactForm()";
				}
				%>
					
				<!-- Title -->
				<h1><b>Flight Reservation</b></h1>
				<h3>Please complete all passenger information.</h3>
				<%if(session.getAttribute("gueststat")!=null){%>
					<div class="alert alert-danger" role="alert" style="width: 70%; margin: 0 auto; margin-top: 30px;">
					<button type="button" class="close" data-dismiss="alert" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					An unexpected error occurred. Please ensure you have entered the correct information for the passenger.
					</div>
				<%}%>
				
				<!-- New Passenger Form -->				
				<h3 style="font-weight: bold; color: #2980b9">Passenger <%=count+1%></h3>
				<form name="bookdata" class="form-horizontal" action="<%=request.getContextPath()%>/AddToCart_guest_contact" method="POST" onsubmit="return(<%=onsubmitText%>);">
					<div class="form-group">
						<label class="col-sm-2 control-label" style="margin-bottom:20px;">Title*</label>
						<div class="col-sm-10" style="margin-bottom:20px;">
							<select class="form-control" id="guest_salutation" name="guest_salutation" style="width: 15%" onchange="checkFormSalutation()">
								<option value=""></option>
								<option value="MR">MR</option>
								<option value="MRS">MRS</option>
								<option value="MISS">MISS</option>
								<option value="MDM">MDM</option>
								<option value="MS">MS</option>
								<option value="MSTR">MSTR</option>
								<option value="DR">DR</option>
								<option value="PROF">PROF</option>
								<option value="ASSOC PROF">ASSOC PROF</option>
							</select>
							<p id="guest_salutation_msg" style="color: #cd6155"></p>
						</div>
					</div>
					<div class="form-group" style="margin-bottom: 20px">
						<label class="col-sm-2 control-label">First / Given Name</label>
						<div class="col-sm-10">
							<input type="text" style="width:65.5%" class="form-control" id="guest_firstname" name="guest_firstname"  onblur="this.value=this.value.toUpperCase()" onchange="checkFormFirstname()">
							<p id="guest_firstname_msg" style="color: #cd6155"></p>
							<br>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label">Last / Family Name*</label>
						<div class="col-sm-10">
							<input type="text" style="width:65.5%" class="form-control" name="guest_lastname" onblur="this.value=this.value.toUpperCase()" onchange="checkFormLastname()">
							<p id="guest_lastname_msg" style="color: #cd6155"></p>
							<br>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label">Passport Number*</label>
						<div class="col-sm-10">
							<input type="text" style="width:65.5%" class="form-control" name="guest_passportno" onchange="checkFormPassportno()">
							<p id="guest_passportno_msg" style="color: #cd6155"></p>
							<br>
						</div>
					</div>
					<%if((count+1) == bk_noOfSeats){%>
						<h3 style="font-weight: bold; color: #2980b9">Contact Information</h3>
						<p>Please enter the contact information of any passenger.</p>
						<div class="form-group" style="margin-top: 40px">
							<label class="col-sm-2 control-label">Email*</label>
							<div class="col-sm-10"">
								<input type="email" style="width:65.5%" class="form-control" placeholder="example@email.com" name="contact_email" onchange="checkFormEmail()">
								<p id="contact_email_msg" style="color: #cd6155"></p>
								<br>
							</div>
						</div>
						<div class="form-group">
					       <label class="col-sm-2 control-label">Contact Number</label>
					       <div class="col-md-10" onchange="checkFormTel()">
					           <div class="form-group row">
					               <div class="col-md-2">
					                   <input type="text" class="form-control" name="contact_tel_ctry" maxlength="3">
					                   <span class="control-label">Country*</span>
					               </div>
					               <div class="col-md-2">
					                   <input type="text" class="form-control" name="contact_tel_area" maxlength="4">
					                   <span class="control-label">Area</span>
					               </div>
					               <div class="col-md-4">
					                   <input type="text" class="form-control" name="contact_tel_hp" maxlength="11">
					                   <span class="control-label" style="width: 40%">Phone Number*</span>
					               </div>
					           </div>
					           <p id="contact_tel_msg" style="color: #cd6155"></p>
					       </div>
					   	</div> 
					<%}%>
				    <div class="form-group">
						<div class="col-sm-offset-2 col-sm-10">
							<!-- <button type="button" class="btn btn-info" data-toggle="modal" data-target="#myModal"><%=actionText%></button> -->
							<input type="button" name="btnNext" value="<%=actionText%>" class="btn btn-info" onclick="<%=onclickText%>;">
						</div>
						<!-- Confirmation Modal -->
						<div class="modal fade" id="myModal" role="dialog">
							<div class="modal-dialog">
						   		<div class="modal-content">
						      		<div class="modal-header">
						        		<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
						        		<h3 style="font-weight: bold; color: #2980b9">Confirm Passenger <%=count+1%></h3>
						      		</div>
							      	<div class="modal-body">
							        	<p>Passenger details cannot be edited after confirmation.</p>
							      	</div>
							      	<div class="modal-footer">
							        	<button type="button" class="btn btn-default" data-dismiss="modal">Edit</button>
							        	<input type="submit" name="btnNext" class="btn btn-info" value="Confirm">
							      	</div>
						    	</div>
						  	</div>
						</div>
					</div> 
				</form>
			</article>
		</div>
		
		<!-- Footer -->
		<%@include file="../files_other/footer.jsp"%>
		<script src="<%=request.getContextPath()%>/files_guest/bk_validate.js"></script>
	</body>
</html>