<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*" %>
<%@page import="java.util.Arrays" %>
<%@page import = "java.io.*,java.util.*, javax.servlet.*"%>
<%@page import = "javax.servlet.http.*"%>
<%@page import = "org.apache.commons.fileupload.*"%>
<%@page import = "org.apache.commons.fileupload.disk.*"%>
<%@page import = "org.apache.commons.fileupload.servlet.*"%>
<%@page import = "org.apache.commons.io.output.*"%>
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
				<li><a href="./aircraftinsert.jsp">Insert Aircraft</a></li>
				<li><a href="./aircraftsearch.jsp">Update/Delete Aircrafts</a></li>
				<li><a href="../files_flight/flightscheduleinsert.jsp">Insert Flight Schedule</a></li>
				<li><a href="../files_flight/flightschedulesearch.jsp">Update/Delete Flight Schedules</a></li>
				<li><a href="../files_booking/bookingform.jsp">View Flight Bookings</a></li>
				<li><a href="../files_booking/promotions.jsp">Insert/Delete Promotions</a></li>
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
				<%
				//declare and initialize variables 
				String task = request.getParameter("task");
				
				if(task.equals("insert")){
					
					//declare and initialize variables 
					String aircraft_model = null, aircraft_flightno = null, passenger_capacity = null, image_path = "images\\default.png";
					
					//upload image 
					File file ;
					int maxFileSize = 5000 * 1024;
					int maxMemSize = 5000 * 1024;
					ServletContext context = pageContext.getServletContext();
					String filePath = "C:\\spairlines\\WebContent\\images\\";
					
					//verify content type 
				   	String contentType = request.getContentType();
				   
				   	if ((contentType.indexOf("multipart/form-data") >= 0)){
				    	DiskFileItemFactory factory = new DiskFileItemFactory();
				      
				    	//maximum size stored in memory 
				      	factory.setSizeThreshold(maxMemSize);
				      
				      	//if larger than memory size 
				      	factory.setRepository(new File("c:\\temp"));
		
				      	//create file upload handler 
				      	ServletFileUpload upload = new ServletFileUpload(factory);
				      
				      	//maximum file size to be uploaded 
				      	upload.setSizeMax(maxFileSize);
				      
				      	try { 
				         	//parse request to get file items 
				         	List fileItems = upload.parseRequest(request);
		
				         	//process upload file items 
				         	Iterator i = fileItems.iterator();
				         
				         	while (i.hasNext()){
				             	FileItem fi = (FileItem)i.next();
				             	if(fi.isFormField()){
				             		if(fi.getFieldName().equals("aircraft_model")){
				            			aircraft_model = fi.getString();
				            		}
				            		
				            		if(fi.getFieldName().equals("aircraft_flightno")){
				            			aircraft_flightno = fi.getString();
				            		}
				            		
				            		if(fi.getFieldName().equals("passenger_capacity")){
				            			passenger_capacity = fi.getString(); 
				            		}
				             	
				             	}else if (!fi.isFormField()) {
				             		
				            		//get uploaded file parameters 
				                	String fieldName = fi.getFieldName();
				                	String fileName = fi.getName();
				                	boolean isInMemory = fi.isInMemory();
				                	long sizeInBytes = fi.getSize();
				                	image_path = "images\\" + aircraft_model + aircraft_flightno + fileName.substring(fileName.lastIndexOf("."));
				                	
				                	//write file 
		                  			file = new File(filePath + aircraft_model + aircraft_flightno + fileName.substring(fileName.lastIndexOf(".")));
		               				fi.write(file);
				             	}
				         	}
				         	
				     	 } catch(Exception ex) {
				          	System.out.println(ex);
				      	}
				   	}
				   	
					//activate the prepared statement 
					String insertstr = "INSERT INTO aircraft (aircraft_model,aircraft_flightno,passenger_capacity,image_path) VALUES (?,?,?,?)";
		
					try {
						Class.forName("com.mysql.jdbc.Driver"); 
						String connURL ="jdbc:mysql://localhost/spairlines?user=root&password=root";
						Connection conn = DriverManager.getConnection(connURL); 
						PreparedStatement pstmt = conn.prepareStatement(insertstr);
						pstmt.setString(1,aircraft_model);
						pstmt.setString(2,aircraft_flightno);
						pstmt.setString(3,passenger_capacity);
						pstmt.setString(4,image_path);
						int count = pstmt.executeUpdate();
						if(count > 0){%>
							<h3><%=count%> records inserted.</h3>
						<%}
						
					//deactivate the prepared statement 
						conn.close();
					} catch(Exception e) {%>
						<h3>The server was unable to perform the requested action. Please try again.</h3>
					<%}
			
				}else if(task.equals("update")){
					
					//declare and initialize variables 
					String[] aircraft_ids = request.getParameterValues("aircraft_ids");
					String[] updates = new String[4];
					updates[0] = request.getParameter("aircraft_model");
					updates[1] = request.getParameter("aircraft_flightno");
					updates[2] = request.getParameter("passenger_capacity");
					updates[3] = request.getParameter("image_path"); 
					
					String[] variables = new String[4]; 
					variables[0] = "aircraft_model";
					variables[1] = "aircraft_flightno";
					variables[2] = "passenger_capacity";
					variables[3] = "image_path";
					
					int county=0, counter=0; 
					
					//for loop (count number of given variables)
					for(int i=0; i<updates.length; i++){
						if(!updates[i].isEmpty()){
							county += 1;
						}
					}
					
					//activate the prepared statement 
					String updtstr = "UPDATE aircraft SET ";
					
					for(int i=0; i<updates.length; i++){
						if (!updates[i].isEmpty()){
							updtstr += variables[i] + " = ?";
							if (counter < county-1){
								updtstr += ", ";
								counter++; 
							}
						}
					}
					
					updtstr += " WHERE aircraft_id = ?";
					
					for(int i=1; i<aircraft_ids.length; i++){
						updtstr += " OR aircraft_id = ?";
					}
					
					try{
						Class.forName("com.mysql.jdbc.Driver");
						String connURL = "jdbc:mysql://localhost/spairlines?user=root&password=root";
						Connection conn = DriverManager.getConnection(connURL);
						PreparedStatement pstmt = conn.prepareStatement(updtstr);
						counter = 1;
						for(int i=0; i<updates.length; i++){
							if (!updates[i].isEmpty()){
								pstmt.setString(counter,updates[i]);
								counter++; 
							}
						}
						for(int i=0; i<aircraft_ids.length; i++){
							pstmt.setString(counter,aircraft_ids[i]);
							counter++;
						}
						int count = pstmt.executeUpdate();
						if(count > 0){%>
							<h3><%=count%> records updated.</h3>
						<%}
						
					//deactivate the prepared statement 
						conn.close();
					} catch(Exception e) {%>
						<h3>The server was unable to perform the requested action. Please try again.</h3>
				<%}
					
				}else if(task.equals("delete")){
					
					//declare and initialize variables 
					String[] aircraft_ids = request.getParameterValues("aircraft_ids");
					
					//activate the prepared statement 
					String delstr = "DELETE FROM aircraft WHERE aircraft_id = ?";
					
					try {
						Class.forName("com.mysql.jdbc.Driver"); 
						String connURL ="jdbc:mysql://localhost/spairlines?user=root&password=root";
						Connection conn = DriverManager.getConnection(connURL);
						for(int i=1; i<aircraft_ids.length; i++){
							delstr += " OR aircraft_id = ?";
						}
						PreparedStatement pstmt = conn.prepareStatement(delstr);
						for(int i=0; i<aircraft_ids.length; i++){
							pstmt.setString(i+1,aircraft_ids[i]);
						}
						int count = pstmt.executeUpdate();
						if(count > 0){%>
							<h3><%=count%> records deleted.</h3>
						<%}
						
					//deactivate the prepared statement 
						conn.close();
					} catch(Exception e) {%>
					<h3>The server was unable to perform the requested action. Please try again.</h3>
				<%}
					
				}else if(task.equals("individualdelete")){
					
					//declare and initialize variables 
					String aircraft_id = request.getParameter("aircraft_id");
					
					//activate the prepared statement 
					String delstr = "DELETE FROM aircraft WHERE aircraft_id = ?";
					
					try {
						Class.forName("com.mysql.jdbc.Driver"); 
						String connURL ="jdbc:mysql://localhost/spairlines?user=root&password=root";
						Connection conn = DriverManager.getConnection(connURL);
						PreparedStatement pstmt = conn.prepareStatement(delstr);
						pstmt.setString(1,aircraft_id);
						int count = pstmt.executeUpdate();
						if(count > 0){%>
							<h3><%=count%> records deleted.</h3>
						<%}
						
					//deactivate the prepared statement 
						conn.close();
					} catch(Exception e) {%>
					<h3>The server was unable to perform the requested action. Please try again.</h3>
				<%}
					
				}else if(task.equals("individualupdate")){
					
					//declare and initialize variables 
					String aircraft_id = request.getParameter("aircraft_id");
					String[] updates = new String[4];
					updates[0] = request.getParameter("aircraft_model");
					updates[1] = request.getParameter("aircraft_flightno");
					updates[2] = request.getParameter("passenger_capacity");
					updates[3] = request.getParameter("image_path"); 
					
					String variables[] = new String[4];
					variables[0] = "aircraft_model";
					variables[1] = "aircraft_flightno";
					variables[2] = "passenger_capacity";
					variables[3] = "image_path";
					
					int county=0, counter=0;
					
					//for loop (count number of given variables)
					for(int i=0; i<updates.length; i++){
						if(!updates[i].isEmpty()){
							county += 1;
						}
					}
					
					//activate the prepared statement 
					String updtstr = "UPDATE aircraft SET ";
					
					for(int i=0; i<updates.length; i++){
						if (!updates[i].isEmpty()){
							updtstr += variables[i] + " = ?";
							if (counter < county-1){
								updtstr += ", ";
								counter++; 
							}
						}
					}
					
					updtstr += " WHERE aircraft_id = ?";
					
					try{
						Class.forName("com.mysql.jdbc.Driver"); 
						String connURL ="jdbc:mysql://localhost/spairlines?user=root&password=root";
						Connection conn = DriverManager.getConnection(connURL);
						PreparedStatement pstmt = conn.prepareStatement(updtstr);
						counter = 1; 
						for(int i=0; i<updates.length; i++){
							if (!updates[i].isEmpty()){
								pstmt.setString(counter,updates[i]);
								counter++; 
							}
						}
						pstmt.setString(counter,aircraft_id);
						int count = pstmt.executeUpdate();
						if(count > 0){%>
							<h3><%=count%> records updated.</h3>
						<%}
						
					//deactivate the prepared statement 
						conn.close(); 
					} catch(Exception e) {%>
					<h3>The server was unable to perform the requested action. Please try again.</h3>
				<%}
				}
				%>
			</article>
		</div>
		
		<!-- Footer -->
		<%@include file="../files_other/footer.jsp"%>
	</body>
</html>