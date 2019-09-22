<!DOCTYPE html>
<html>
	<head>
		<%String path = request.getContextPath() + "/files_other/styles.css";%>
		<meta charset="ISO-8859-1">
		<title>SpAirlines</title>
		<link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
		<link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css">
		<link rel="stylesheet" type="text/css" href=<%=path%>>
	</head>
	<body>
		<!-- Header -->
		<header style="margin-top: 50px;">
			<a href="<%=request.getContextPath()%>/KillSessionServlet"><img id="image" src="<%=request.getContextPath()%>/images/logo.png"></a>
			<h1>SP Airlines</h1>
			<h4>Serving Passengers with Spectacular Passion</h4>
		</header>
	</body>
</html>