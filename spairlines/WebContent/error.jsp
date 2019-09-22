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
		<%@include file="files_other/header.jsp"%>
		
		<!-- Main -->
		<div class="main">
		
			<!-- Admin Navigation -->
			<nav class="navbar navbar-default">
				<div class="container-fluid">
					<ul class="nav navbar-nav navbar-left">
						<span class="navbar-text" style="height: 8px;">This is an <span style="color: #ec7063; font-weight: bold;">error</span> page.</span>
					</ul>
					<ul class="nav navbar-nav navbar-right">
				    	<li style="background-color: #afafaf; margin-right: 20px;"><a href="<%=request.getContextPath()%>/index.jsp" style="color: #ec;">Return to Home</a></li>
			    	</ul>
		    	</div>
			</nav>
				
			<!-- Index Page Image -->
			<img src="<%=request.getContextPath()%>/images/airline.jpg" style="width: 100%;">
				
			<!-- Article -->
			<article>
				<h1>Sorry, the plane crashed.</h1>
				<p>General Error</p>
			</article>
		</div>
		
		<!-- Footer -->
		<%@include file="files_other/footer.jsp"%>
	</body>
</html>