<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import = "java.security.SecureRandom" %>    
<%@ page import = "java.util.Random" %>   

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>SpAirlines</title>
	</head>
	<body>
		<!-- Header -->
		<%@ include file = "../files_other/header.jsp" %>
		
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
				<h1><strong>SP Airlines Management</strong></h1>
				<h3 style="margin-bottom: 30px;" id="subheading">Reset to a new password.</h3>
				
				<!-- Security Form -->
				<form id="inputs" class="form-horizontal" action="verifyuser.jsp?task=security" method="post">
					<div class="form-group">
						<label class="col-sm-2 control-label">Admin ID</label>
						<div class="col-sm-10">
							<input style="width:50%" type="text" class="form-control" name="adminid" required><br>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label">Security Answer</label>
						<div class="col-sm-10">
							<input style="width:50%; margin-bottom: 20px;" type="text" class="form-control" name="answer" placeholder="What is the name of your first pet?" required>
						</div>
					</div>
					<div class="form-group">
						<div class="col-sm-offset-2 col-sm-10">
							<input type="submit" class="btn btn-primary" name="btnSubmit" value="Reset Password" style="margin-right: 20px;">
							<input type="reset" class="btn btn-default">
						</div>
					</div>
				</form>
				
				<%
				//declare and initialize variables 
				String reset = request.getParameter("reset");
				String adminid = request.getParameter("adminid");
				session.setAttribute("currentAdmin", adminid);
				
				if(reset != null) {
					if(reset.equals("success")) {%>
						<script>document.getElementById('inputs').style.display = 'none';</script>
						<%Random random = new SecureRandom();
						
						//Set length of random password to 8
						int passlength = 8;
						
						//Choose characters that are usable in generated password
						String characters = "abcdefghjkmnpqrstuvwxyzABCDEFGHJKMNPQRSTUVWXYZ23456789!@#$%^&*";
						String pw = "";
						
						for (int i=0; i<passlength; i++) {
							  //Generate random character and add to password
					          int index = (int)(random.nextDouble()*characters.length());
					          pw += characters.substring(index, index+1);
						}%>
				
				<script>
					var element = document.getElementById("subheading");
					element.innerHTML = "Use and remember this password for now. You can change your password later.";
				</script>
				
				<!-- Use This Password Form -->
				<form class="form-horizontal" action="adminbackend.jsp?task=resetpassword" method="post">
					<div class="form-group">
						<label class="col-sm-2 control-label">New Password</label>
						<div class="col-sm-10">
							<input style="width:50%; margin-bottom: 20px;" type="text" class="form-control" name="password" value=<%=pw%> readonly>
						</div>
					</div>
					<div class="form-group">
						<div class="col-sm-offset-2 col-sm-10">
							<input type="submit" class="btn btn-primary" name="btnSubmit" value="Use This Password">
						</div>
					</div>
				</form>
				<%			
					} else if(reset.equals("fail")) {%>
						<script>
							var element = document.getElementById("subheading");
							element.innerHTML = "You have entered an invalid security answer. Please try again.";
						</script>
					<%}
				}	
				%>
			</div>
		</article>
		
		<!-- Footer -->
		<%@ include file = "../files_other/footer.jsp" %>
	</body>
</html>