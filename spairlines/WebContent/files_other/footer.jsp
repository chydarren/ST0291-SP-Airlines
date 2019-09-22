<!DOCTYPE html>
<html>
	<head>
		<%String path2 = request.getContextPath() + "/files_other/styles.css";%>
		<meta charset="ISO-8859-1">
		<title>SpAirlines</title>
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css">
		<link rel="stylesheet" type="text/css" href="<%=path2%>">
		<script src="<%=request.getContextPath()%>/scripts/jquery-3.1.1.min.js"></script>  
		<style>
			html {
		    position: relative;
		    min-height: 100%;
			}
			body {
				background-color: #e0e0e0;
			    margin: 0px 0px 170px 0px; 
			}
		</style>
	</head>
	<body>
		<!-- back to top --> 
		<a href="#" id="top" title="Back To Top">&#8593;</a>
		
		<script>
		if ($("#top").length) {
			var scrollTrigger = 200, 
				backToTop = function () {
					var scrollTop = $(window).scrollTop();
					if (scrollTop > scrollTrigger) {
						$("#top").addClass("show");
					} else {
						$("#top").removeClass("show");
					}
				};
				
			backToTop();
			$(window).on('scroll', function () {
				backToTop();
			});
			
			$("#top").on('click', function (e) {
				e.preventDefault();
				$("html,body").animate({
					scrollTop: 0
				}, 800);
			});
		}
		</script>
		
		<!-- Footer -->
		<footer>
			<p id="copyright">All Rights Reserved &#9400; 2017 SP Airlines</p>
			<p>Chua Han Yong Darren and Chng Wei Cheng<br>
			Email: spairlines5682and5554@gmail.com</p>
		</footer>
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	</body>
</html>