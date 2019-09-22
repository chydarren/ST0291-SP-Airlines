<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
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
				<!--  Title -->
				<h1><strong>SP Airlines Management</strong></h1>
				<h3 style="margin-bottom: 30px;">Welcome back. Log in to manage the database.</h3>
				<%	
					String login = request.getParameter("login");
					if (login != null && login.equals("fail")){%>
						<h3>You have entered an invalid ID/Password.</h3>
					<%} 		
				%>
				<!-- Login Form -->
				<form class="form-horizontal" action="../CreateSessionServlet" method="post">
					<div class="form-group">
						<label class="col-sm-2 control-label">Admin ID</label>
						<div class="col-sm-10">
							<input style="width:50%" type="text" class="form-control" name="loginid"><br>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label">Password</label>
						<div class="col-sm-10">
							<input style="width:50%" type="password" class="form-control" name="password"><br>
						</div>
						<a href="adminforgot.jsp" style="margin-left: 220px;">Forgot your password?</a>
					</div>
					<div class="form-group">
						<div class="col-sm-offset-2 col-sm-10">
							<input type="submit" class="btn btn-primary" name="btnSubmit" value="Login" style="margin-right: 20px;">
							<input type="reset" class="btn btn-default">
						</div>
					</div>
				</form>
			</article>
		</div>
		
		<!-- Footer -->
		<%@include file="../files_other/footer.jsp"%>
	</body>
</html>