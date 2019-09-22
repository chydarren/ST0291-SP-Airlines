<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.*"%>
<%@page import="dbaccess.*" %>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.io.*"%>
<%@ page import = "javax.mail.*"%>
<%@ page import = "javax.mail.internet.*"%>
<%@ page import = "javax.activation.*" %>
<%@ page import = "javax.servlet.http.*" %>  
<%@ page import = "javax.servlet.*" %>   

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
						<span class="navbar-text" style="height: 8px;">You are currently within the <span style="color: #2980b9; font-weight: bold;">Booking Portal</span>.</span>
					</ul>
					<ul class="nav navbar-nav navbar-right">
				    	<li style="background-color: #afafaf; margin-right: 20px;"><a href="<%=request.getContextPath()%>/KillSessionServlet" style="color: #000000;">Close Window</a></li>
			    	</ul>
		    	</div>
			</nav>
			
			<!-- Article -->
			<article>
				<!-- Title -->
				<h1><b>Flight Reservation</b></h1>
				<%if(session.getAttribute("success").equals("yes")){
					Bk_contact contact = (Bk_contact) session.getAttribute("contactinfo");
					Bk_payment payment = (Bk_payment) session.getAttribute("paymentinfo");
					final String username = "spairlines5682and5554@gmail.com";
					final String password = "EAD123root";
					
					Properties props = new Properties();
					props.put("mail.smtp.auth", "true");
					props.put("mail.smtp.starttls.enable", "true");
					props.put("mail.smtp.host", "smtp.gmail.com");
					props.put("mail.smtp.port", "587");
					
					Session mail = Session.getInstance(props,new javax.mail.Authenticator() {
						protected PasswordAuthentication getPasswordAuthentication() {
							return new PasswordAuthentication(username, password);
						}
					});
					try {
						Message message = new MimeMessage(mail);
						message.setFrom(new InternetAddress("spairlines5682and5554@gmail.com"));
						message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(contact.getContact_email()));
						message.setSubject("Transaction Details for Booking Reference ID "+session.getAttribute("booking_ref_id"));
						message.setText(
						"Dear " + payment.getPayment_card_holder() +", " + "(Booking Ref ID: "+session.getAttribute("booking_ref_id")+"),"
						+ "\n\n Thank you for having booked your flight with SP Airlines."
						+ "\n\n You may use this booking reference id for your flight in future."
						+ "\n\n Please do not reply to this email directly as it is an auto-generated email.");
						Transport.send(message);
					}catch(Exception e){
						e.printStackTrace();
					}%>
					<h3>Your flight have been successfully booked. An email has been sent to you.</h3>
					<p>Thank you for choosing SP Airlines. Your booking reference id is <span style="font-weight: bold"><%=session.getAttribute("booking_ref_id")%></span>.</p>
					<img src="<%=request.getContextPath()%>/images/confirmation.jpg" height="50%" width="70%" style="margin-top: 10px;">
				<%}else{%>
					<h3>An unexpected error occurred during your booking.</h3>
					<p>Please close this window and re-book your flight.</p>
				<%}%>
			</article>
		</div>
		
		<!-- Footer -->
		<%@include file="../files_other/footer.jsp"%>
		<script src="<%=request.getContextPath()%>/files_guest/bk_validate.js"></script>
	</body>
</html>