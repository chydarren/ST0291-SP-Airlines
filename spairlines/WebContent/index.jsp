<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import= "java.sql.*" %>
<%@page import="dbaccess.Bk_promotion" %>
<%@page import = "java.util.ArrayList" %> 
<%@page import = "java.util.Date" %> 
<%@page import = "java.time.*"%>
<%@page import = "java.time.format.DateTimeFormatter"%>
<%@page import = "java.text.*"%>
   
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
						<span class="navbar-text" style="height: 8px;">You are currently viewing as a <span style="color: #229954; font-weight: bold;">Guest</span>.</span>
					</ul>
					<ul class="nav navbar-nav navbar-right">
				    	<li style="background-color: #afafaf; margin-right: 20px;"><a href="<%=request.getContextPath()%>/files_admin/login.jsp" style="color: #000000;">Login</a></li>
			    	</ul>
		    	</div>
			</nav>
			
			<!-- Index Page Image -->
			<img src="<%=request.getContextPath()%>/images/airline.jpg" style="width: 100%;">
			
			<!-- Article -->
			<article>
				<!-- Title -->
				<h1><b>Welcome to SP Airlines</b></h1>
				<h3>Choose a service from this one-stop navigation.</h3>
				
				<ul class="nav nav-tabs" role="tablist" style="margin-top: 30px">
					<li role="presentation" class="active"><a href="#timetable" aria-controls="timetable" role="tab" data-toggle="tab">Flight Timetable</a></li>
				    <li role="presentation"><a href="#book" aria-controls="book" role="tab" data-toggle="tab">Book a Trip</a></li>
				    <li role="presentation"><a href="#promotion" aria-controls="promotion" role="tab" data-toggle="tab">Promotions</a></li>
			  	</ul>
			  	
			  	<div class="tab-content">
					<div role="tabpanel" class="tab-pane fade in active" id="timetable">
						<h3 style="font-weight: bold; color: #2980b9; text-align: center; margin-top: 30px;">Flight Timetable</h3>
						<!-- Display All Records -->
						<form class="form-horizontal" action="<%=request.getContextPath()%>/files_guest/guestsearchprocess.jsp?task=guestdisplayall" method="POST">
							<h4 class="text-center" style="margin-top: 30px; margin-bottom: 30px; font-weight: bold;">Display all flights</h4>
							<div class="form-group">
								<div class="col-sm-offset-2 col-sm-10" style="margin-left: 100px; text-align:center;">
									<input type="submit" class="btn btn-default" name="btnDisplay" value="Display All Flights">
								</div>
							</div>
						</form> 
						
						<!-- Find Records -->
						<form class="form-horizontal" action="<%=request.getContextPath()%>/files_guest/guestsearchprocess.jsp?task=guestsearch" method="POST">
							<h4 class="text-center" style="margin-top: 30px; margin-bottom: 30px; font-weight: bold;">or search flights with</h4>
							<div class="form-group">
								<label class="col-sm-2 control-label">From</label>
								<div class="col-sm-10">
									<select class="form-control" name="searchString" style="width: 70%">
										<%
										try {
											Class.forName("com.mysql.jdbc.Driver"); 
									        String connURL ="jdbc:mysql://localhost/spairlines?user=root&password=root";
									        Connection conn = DriverManager.getConnection(connURL); 
									        Statement stmt = conn.createStatement();
											String sqlStr = "SELECT DISTINCT departure_airport FROM flightschedule";
											ResultSet rs = stmt.executeQuery(sqlStr); 
											while(rs.next()){ %>
												<option value="<%=rs.getString(1)%>"><%=rs.getString(1)%></option>
											<% }
										} catch(Exception e) {%>
											<h3>The server was unable to perform the requested action. Please try again.</h3>
										<%} 
										%>
									</select>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label" style="margin-top: 20px; margin-bottom: 20px;">To</label>
								<div class="col-sm-10" style="margin-top: 20px; margin-bottom: 20px;">
									<select class="form-control" name="searchString2" style="width: 70%">
										<%
										try {
											Class.forName("com.mysql.jdbc.Driver"); 
									        String connURL ="jdbc:mysql://localhost/spairlines?user=root&password=root";
									        Connection conn = DriverManager.getConnection(connURL); 
									        Statement stmt = conn.createStatement();
											String sqlStr = "SELECT DISTINCT arrival_airport FROM flightschedule";
											ResultSet rs = stmt.executeQuery(sqlStr); 
											while(rs.next()){ %>
												<option value="<%=rs.getString(1)%>"><%=rs.getString(1)%></option>
											<% }
										} catch(Exception e) {%>
											<h3>The server was unable to perform the requested action. Please try again.</h3>
										<%} 
										%>
									</select>
								</div>
							</div>
							<div class="form-group">
						        <label class="col-sm-2 control-label">Dates</label>
						        <div class="col-md-10">
						            <div class="form-group row">
						                <div class="col-md-4">
						                    <input type="date" class="form-control" name="searchString3">
						                    <span class="control-label">Departure Date</span>
						                </div>
						                <div class="col-md-4">
						                    <input type="date" class="form-control" name="searchString4">
						                    <span class="control-label">Arrival Date</span>
						                </div>
						            </div>
						        </div>
						    </div>
							<div class="form-group">
								<div class="col-sm-offset-2 col-sm-10">
									<input type="submit" class="btn btn-primary" name="btnSearch" value="Search Flight" style="margin-right: 20px;">
									<input type="reset" class="btn btn-default">
								</div>
							</div>
						</form>
					</div>
				  	<div role="tabpanel" class="tab-pane fade" id="book">
				  		<!-- Book Trip Form -->				
						<h3 style="font-weight: bold; color: #2980b9; text-align: center; margin-top: 30px;">Book a Trip</h3>
						<%if(session.getAttribute("welcomestat")!=null){%>
							<div class="alert alert-danger" role="alert" style="width: 70%; margin: 0 auto; margin-top: 30px;">
							<button type="button" class="close" data-dismiss="alert" aria-label="Close">
								<span aria-hidden="true">&times;</span>
							</button>
							The flight you have specified earlier is not available.
							</div>
						<%}%>
						<%if(session.getAttribute("promotion_cost")!=null){%>
							<div class="alert alert-success" role="alert" style="width: 70%; margin: 0 auto; margin-top: 30px;">You are currently booking a promotion from <%=session.getAttribute("promotion_departure_country")%> to <%=session.getAttribute("promotion_arrival_country")%> (SGD <%=session.getAttribute("promotion_cost")%>).<br>
							<a href="<%=request.getContextPath()%>/KillSessionServlet">Click here </a> if you want to cancel the promotion.</div>
						<%}%>
						<form name="bookflight" class="form-horizontal" action="<%=request.getContextPath()%>/ObtainWelcomeServlet" method="POST">
							<div class="form-group">
								<label class="col-sm-2 control-label" style="margin-bottom:20px;">From*</label>
								<div class="col-sm-10">
									<%if(session.getAttribute("promotion_cost")!=null){%>
									<select class="form-control" name="flight_fromcountry" style="width: 65.5%">
										<option value="<%=session.getAttribute("promotion_departure_country")%>"><%=session.getAttribute("promotion_departure_country")%></option>
									<%}else{%><select class="form-control" name="flight_fromcountry" style="width: 65.5%" required>
										<option value="Singapore">Singapore</option>
										<option value="Afganistan">Afghanistan</option>
										<option value="Albania">Albania</option>
										<option value="Algeria">Algeria</option>
										<option value="American Samoa">American Samoa</option>
										<option value="Andorra">Andorra</option>
										<option value="Angola">Angola</option>
										<option value="Anguilla">Anguilla</option>
										<option value="Antigua &amp; Barbuda">Antigua &amp; Barbuda</option>
										<option value="Argentina">Argentina</option>
										<option value="Armenia">Armenia</option>
										<option value="Aruba">Aruba</option>
										<option value="Australia">Australia</option>
										<option value="Austria">Austria</option>
										<option value="Azerbaijan">Azerbaijan</option>
										<option value="Bahamas">Bahamas</option>
										<option value="Bahrain">Bahrain</option>
										<option value="Bangladesh">Bangladesh</option>
										<option value="Barbados">Barbados</option>
										<option value="Belarus">Belarus</option>
										<option value="Belgium">Belgium</option>
										<option value="Belize">Belize</option>
										<option value="Benin">Benin</option>
										<option value="Bermuda">Bermuda</option>
										<option value="Bhutan">Bhutan</option>
										<option value="Bolivia">Bolivia</option>
										<option value="Bonaire">Bonaire</option>
										<option value="Bosnia &amp; Herzegovina">Bosnia &amp; Herzegovina</option>
										<option value="Botswana">Botswana</option>
										<option value="Brazil">Brazil</option>
										<option value="British Indian Ocean Ter">British Indian Ocean Ter</option>
										<option value="Brunei">Brunei</option>
										<option value="Bulgaria">Bulgaria</option>
										<option value="Burkina Faso">Burkina Faso</option>
										<option value="Burundi">Burundi</option>
										<option value="Cambodia">Cambodia</option>
										<option value="Cameroon">Cameroon</option>
										<option value="Canada">Canada</option>
										<option value="Canary Islands">Canary Islands</option>
										<option value="Cape Verde">Cape Verde</option>
										<option value="Cayman Islands">Cayman Islands</option>
										<option value="Central African Republic">Central African Republic</option>
										<option value="Chad">Chad</option>
										<option value="Channel Islands">Channel Islands</option>
										<option value="Chile">Chile</option>
										<option value="China">China</option>
										<option value="Christmas Island">Christmas Island</option>
										<option value="Cocos Island">Cocos Island</option>
										<option value="Colombia">Colombia</option>
										<option value="Comoros">Comoros</option>
										<option value="Congo">Congo</option>
										<option value="Cook Islands">Cook Islands</option>
										<option value="Costa Rica">Costa Rica</option>
										<option value="Cote DIvoire">Cote D'Ivoire</option>
										<option value="Croatia">Croatia</option>
										<option value="Cuba">Cuba</option>
										<option value="Curaco">Curacao</option>
										<option value="Cyprus">Cyprus</option>
										<option value="Czech Republic">Czech Republic</option>
										<option value="Denmark">Denmark</option>
										<option value="Djibouti">Djibouti</option>
										<option value="Dominica">Dominica</option>
										<option value="Dominican Republic">Dominican Republic</option>
										<option value="East Timor">East Timor</option>
										<option value="Ecuador">Ecuador</option>
										<option value="Egypt">Egypt</option>
										<option value="El Salvador">El Salvador</option>
										<option value="Equatorial Guinea">Equatorial Guinea</option>
										<option value="Eritrea">Eritrea</option>
										<option value="Estonia">Estonia</option>
										<option value="Ethiopia">Ethiopia</option>
										<option value="Falkland Islands">Falkland Islands</option>
										<option value="Faroe Islands">Faroe Islands</option>
										<option value="Fiji">Fiji</option>
										<option value="Finland">Finland</option>
										<option value="France">France</option>
										<option value="French Guiana">French Guiana</option>
										<option value="French Polynesia">French Polynesia</option>
										<option value="French Southern Ter">French Southern Ter</option>
										<option value="Gabon">Gabon</option>
										<option value="Gambia">Gambia</option>
										<option value="Georgia">Georgia</option>
										<option value="Germany">Germany</option>
										<option value="Ghana">Ghana</option>
										<option value="Gibraltar">Gibraltar</option>
										<option value="Great Britain">Great Britain</option>
										<option value="Greece">Greece</option>
										<option value="Greenland">Greenland</option>
										<option value="Grenada">Grenada</option>
										<option value="Guadeloupe">Guadeloupe</option>
										<option value="Guam">Guam</option>
										<option value="Guatemala">Guatemala</option>
										<option value="Guinea">Guinea</option>
										<option value="Guyana">Guyana</option>
										<option value="Haiti">Haiti</option>
										<option value="Hawaii">Hawaii</option>
										<option value="Honduras">Honduras</option>
										<option value="Hong Kong">Hong Kong</option>
										<option value="Hungary">Hungary</option>
										<option value="Iceland">Iceland</option>
										<option value="India">India</option>
										<option value="Indonesia">Indonesia</option>
										<option value="Iran">Iran</option>
										<option value="Iraq">Iraq</option>
										<option value="Ireland">Ireland</option>
										<option value="Isle of Man">Isle of Man</option>
										<option value="Israel">Israel</option>
										<option value="Italy">Italy</option>
										<option value="Jamaica">Jamaica</option>
										<option value="Japan">Japan</option>
										<option value="Jordan">Jordan</option>
										<option value="Kazakhstan">Kazakhstan</option>
										<option value="Kenya">Kenya</option>
										<option value="Kiribati">Kiribati</option>
										<option value="Korea North">Korea North</option>
										<option value="Korea Sout">Korea South</option>
										<option value="Kuwait">Kuwait</option>
										<option value="Kyrgyzstan">Kyrgyzstan</option>
										<option value="Laos">Laos</option>
										<option value="Latvia">Latvia</option>
										<option value="Lebanon">Lebanon</option>
										<option value="Lesotho">Lesotho</option>
										<option value="Liberia">Liberia</option>
										<option value="Libya">Libya</option>
										<option value="Liechtenstein">Liechtenstein</option>
										<option value="Lithuania">Lithuania</option>
										<option value="Luxembourg">Luxembourg</option>
										<option value="Macau">Macau</option>
										<option value="Macedonia">Macedonia</option>
										<option value="Madagascar">Madagascar</option>
										<option value="Malaysia">Malaysia</option>
										<option value="Malawi">Malawi</option>
										<option value="Maldives">Maldives</option>
										<option value="Mali">Mali</option>
										<option value="Malta">Malta</option>
										<option value="Marshall Islands">Marshall Islands</option>
										<option value="Martinique">Martinique</option>
										<option value="Mauritania">Mauritania</option>
										<option value="Mauritius">Mauritius</option>
										<option value="Mayotte">Mayotte</option>
										<option value="Mexico">Mexico</option>
										<option value="Midway Islands">Midway Islands</option>
										<option value="Moldova">Moldova</option>
										<option value="Monaco">Monaco</option>
										<option value="Mongolia">Mongolia</option>
										<option value="Montserrat">Montserrat</option>
										<option value="Morocco">Morocco</option>
										<option value="Mozambique">Mozambique</option>
										<option value="Myanmar">Myanmar</option>
										<option value="Nambia">Nambia</option>
										<option value="Nauru">Nauru</option>
										<option value="Nepal">Nepal</option>
										<option value="Netherland Antilles">Netherland Antilles</option>
										<option value="Netherlands">Netherlands (Holland, Europe)</option>
										<option value="Nevis">Nevis</option>
										<option value="New Caledonia">New Caledonia</option>
										<option value="New Zealand">New Zealand</option>
										<option value="Nicaragua">Nicaragua</option>
										<option value="Niger">Niger</option>
										<option value="Nigeria">Nigeria</option>
										<option value="Niue">Niue</option>
										<option value="Norfolk Island">Norfolk Island</option>
										<option value="Norway">Norway</option>
										<option value="Oman">Oman</option>
										<option value="Pakistan">Pakistan</option>
										<option value="Palau Island">Palau Island</option>
										<option value="Palestine">Palestine</option>
										<option value="Panama">Panama</option>
										<option value="Papua New Guinea">Papua New Guinea</option>
										<option value="Paraguay">Paraguay</option>
										<option value="Peru">Peru</option>
										<option value="Phillipines">Philippines</option>
										<option value="Pitcairn Island">Pitcairn Island</option>
										<option value="Poland">Poland</option>
										<option value="Portugal">Portugal</option>
										<option value="Puerto Rico">Puerto Rico</option>
										<option value="Qatar">Qatar</option>
										<option value="Republic of Montenegro">Republic of Montenegro</option>
										<option value="Republic of Serbia">Republic of Serbia</option>
										<option value="Reunion">Reunion</option>
										<option value="Romania">Romania</option>
										<option value="Russia">Russia</option>
										<option value="Rwanda">Rwanda</option>
										<option value="St Barthelemy">St Barthelemy</option>
										<option value="St Eustatius">St Eustatius</option>
										<option value="St Helena">St Helena</option>
										<option value="St Kitts-Nevis">St Kitts-Nevis</option>
										<option value="St Lucia">St Lucia</option>
										<option value="St Maarten">St Maarten</option>
										<option value="St Pierre &amp; Miquelon">St Pierre &amp; Miquelon</option>
										<option value="St Vincent &amp; Grenadines">St Vincent &amp; Grenadines</option>
										<option value="Saipan">Saipan</option>
										<option value="Samoa">Samoa</option>
										<option value="Samoa American">Samoa American</option>
										<option value="San Marino">San Marino</option>
										<option value="Sao Tome &amp; Principe">Sao Tome &amp; Principe</option>
										<option value="Saudi Arabia">Saudi Arabia</option>
										<option value="Senegal">Senegal</option>
										<option value="Serbia">Serbia</option>
										<option value="Seychelles">Seychelles</option>
										<option value="Sierra Leone">Sierra Leone</option>
										<option value="Slovakia">Slovakia</option>
										<option value="Slovenia">Slovenia</option>
										<option value="Solomon Islands">Solomon Islands</option>
										<option value="Somalia">Somalia</option>
										<option value="South Africa">South Africa</option>
										<option value="Spain">Spain</option>
										<option value="Sri Lanka">Sri Lanka</option>
										<option value="Sudan">Sudan</option>
										<option value="Suriname">Suriname</option>
										<option value="Swaziland">Swaziland</option>
										<option value="Sweden">Sweden</option>
										<option value="Switzerland">Switzerland</option>
										<option value="Syria">Syria</option>
										<option value="Tahiti">Tahiti</option>
										<option value="Taiwan">Taiwan</option>
										<option value="Tajikistan">Tajikistan</option>
										<option value="Tanzania">Tanzania</option>
										<option value="Thailand">Thailand</option>
										<option value="Togo">Togo</option>
										<option value="Tokelau">Tokelau</option>
										<option value="Tonga">Tonga</option>
										<option value="Trinidad &amp; Tobago">Trinidad &amp; Tobago</option>
										<option value="Tunisia">Tunisia</option>
										<option value="Turkey">Turkey</option>
										<option value="Turkmenistan">Turkmenistan</option>
										<option value="Turks &amp; Caicos Is">Turks &amp; Caicos Is</option>
										<option value="Tuvalu">Tuvalu</option>
										<option value="Uganda">Uganda</option>
										<option value="Ukraine">Ukraine</option>
										<option value="United Arab Erimates">United Arab Emirates</option>
										<option value="United Kingdom">United Kingdom</option>
										<option value="United States of America">United States of America</option>
										<option value="Uraguay">Uruguay</option>
										<option value="Uzbekistan">Uzbekistan</option>
										<option value="Vanuatu">Vanuatu</option>
										<option value="Vatican City State">Vatican City State</option>
										<option value="Venezuela">Venezuela</option>
										<option value="Vietnam">Vietnam</option>
										<option value="Virgin Islands (Brit)">Virgin Islands (Brit)</option>
										<option value="Virgin Islands (USA)">Virgin Islands (USA)</option>
										<option value="Wake Island">Wake Island</option>
										<option value="Wallis &amp; Futana Is">Wallis &amp; Futana Is</option>
										<option value="Yemen">Yemen</option>
										<option value="Zaire">Zaire</option>
										<option value="Zambia">Zambia</option>
										<option value="Zimbabwe">Zimbabwe</option>
									<%}%>
									</select>
									<br>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label" style="margin-bottom:20px;">To*</label>
								<div class="col-sm-10">
									<%if(session.getAttribute("promotion_cost")!=null){%>
									<select class="form-control" name="flight_tocountry" style="width: 65.5%">
										<option value="<%=session.getAttribute("promotion_arrival_country")%>"><%=session.getAttribute("promotion_arrival_country")%></option>
									<%}else{%><select class="form-control" name="flight_tocountry" style="width: 65.5%" required>
										<option value="Singapore">Singapore</option>
										<option value="Afganistan">Afghanistan</option>
										<option value="Albania">Albania</option>
										<option value="Algeria">Algeria</option>
										<option value="American Samoa">American Samoa</option>
										<option value="Andorra">Andorra</option>
										<option value="Angola">Angola</option>
										<option value="Anguilla">Anguilla</option>
										<option value="Antigua &amp; Barbuda">Antigua &amp; Barbuda</option>
										<option value="Argentina">Argentina</option>
										<option value="Armenia">Armenia</option>
										<option value="Aruba">Aruba</option>
										<option value="Australia">Australia</option>
										<option value="Austria">Austria</option>
										<option value="Azerbaijan">Azerbaijan</option>
										<option value="Bahamas">Bahamas</option>
										<option value="Bahrain">Bahrain</option>
										<option value="Bangladesh">Bangladesh</option>
										<option value="Barbados">Barbados</option>
										<option value="Belarus">Belarus</option>
										<option value="Belgium">Belgium</option>
										<option value="Belize">Belize</option>
										<option value="Benin">Benin</option>
										<option value="Bermuda">Bermuda</option>
										<option value="Bhutan">Bhutan</option>
										<option value="Bolivia">Bolivia</option>
										<option value="Bonaire">Bonaire</option>
										<option value="Bosnia &amp; Herzegovina">Bosnia &amp; Herzegovina</option>
										<option value="Botswana">Botswana</option>
										<option value="Brazil">Brazil</option>
										<option value="British Indian Ocean Ter">British Indian Ocean Ter</option>
										<option value="Brunei">Brunei</option>
										<option value="Bulgaria">Bulgaria</option>
										<option value="Burkina Faso">Burkina Faso</option>
										<option value="Burundi">Burundi</option>
										<option value="Cambodia">Cambodia</option>
										<option value="Cameroon">Cameroon</option>
										<option value="Canada">Canada</option>
										<option value="Canary Islands">Canary Islands</option>
										<option value="Cape Verde">Cape Verde</option>
										<option value="Cayman Islands">Cayman Islands</option>
										<option value="Central African Republic">Central African Republic</option>
										<option value="Chad">Chad</option>
										<option value="Channel Islands">Channel Islands</option>
										<option value="Chile">Chile</option>
										<option value="China">China</option>
										<option value="Christmas Island">Christmas Island</option>
										<option value="Cocos Island">Cocos Island</option>
										<option value="Colombia">Colombia</option>
										<option value="Comoros">Comoros</option>
										<option value="Congo">Congo</option>
										<option value="Cook Islands">Cook Islands</option>
										<option value="Costa Rica">Costa Rica</option>
										<option value="Cote DIvoire">Cote D'Ivoire</option>
										<option value="Croatia">Croatia</option>
										<option value="Cuba">Cuba</option>
										<option value="Curaco">Curacao</option>
										<option value="Cyprus">Cyprus</option>
										<option value="Czech Republic">Czech Republic</option>
										<option value="Denmark">Denmark</option>
										<option value="Djibouti">Djibouti</option>
										<option value="Dominica">Dominica</option>
										<option value="Dominican Republic">Dominican Republic</option>
										<option value="East Timor">East Timor</option>
										<option value="Ecuador">Ecuador</option>
										<option value="Egypt">Egypt</option>
										<option value="El Salvador">El Salvador</option>
										<option value="Equatorial Guinea">Equatorial Guinea</option>
										<option value="Eritrea">Eritrea</option>
										<option value="Estonia">Estonia</option>
										<option value="Ethiopia">Ethiopia</option>
										<option value="Falkland Islands">Falkland Islands</option>
										<option value="Faroe Islands">Faroe Islands</option>
										<option value="Fiji">Fiji</option>
										<option value="Finland">Finland</option>
										<option value="France">France</option>
										<option value="French Guiana">French Guiana</option>
										<option value="French Polynesia">French Polynesia</option>
										<option value="French Southern Ter">French Southern Ter</option>
										<option value="Gabon">Gabon</option>
										<option value="Gambia">Gambia</option>
										<option value="Georgia">Georgia</option>
										<option value="Germany">Germany</option>
										<option value="Ghana">Ghana</option>
										<option value="Gibraltar">Gibraltar</option>
										<option value="Great Britain">Great Britain</option>
										<option value="Greece">Greece</option>
										<option value="Greenland">Greenland</option>
										<option value="Grenada">Grenada</option>
										<option value="Guadeloupe">Guadeloupe</option>
										<option value="Guam">Guam</option>
										<option value="Guatemala">Guatemala</option>
										<option value="Guinea">Guinea</option>
										<option value="Guyana">Guyana</option>
										<option value="Haiti">Haiti</option>
										<option value="Hawaii">Hawaii</option>
										<option value="Honduras">Honduras</option>
										<option value="Hong Kong">Hong Kong</option>
										<option value="Hungary">Hungary</option>
										<option value="Iceland">Iceland</option>
										<option value="India">India</option>
										<option value="Indonesia">Indonesia</option>
										<option value="Iran">Iran</option>
										<option value="Iraq">Iraq</option>
										<option value="Ireland">Ireland</option>
										<option value="Isle of Man">Isle of Man</option>
										<option value="Israel">Israel</option>
										<option value="Italy">Italy</option>
										<option value="Jamaica">Jamaica</option>
										<option value="Japan">Japan</option>
										<option value="Jordan">Jordan</option>
										<option value="Kazakhstan">Kazakhstan</option>
										<option value="Kenya">Kenya</option>
										<option value="Kiribati">Kiribati</option>
										<option value="Korea North">Korea North</option>
										<option value="Korea Sout">Korea South</option>
										<option value="Kuwait">Kuwait</option>
										<option value="Kyrgyzstan">Kyrgyzstan</option>
										<option value="Laos">Laos</option>
										<option value="Latvia">Latvia</option>
										<option value="Lebanon">Lebanon</option>
										<option value="Lesotho">Lesotho</option>
										<option value="Liberia">Liberia</option>
										<option value="Libya">Libya</option>
										<option value="Liechtenstein">Liechtenstein</option>
										<option value="Lithuania">Lithuania</option>
										<option value="Luxembourg">Luxembourg</option>
										<option value="Macau">Macau</option>
										<option value="Macedonia">Macedonia</option>
										<option value="Madagascar">Madagascar</option>
										<option value="Malaysia">Malaysia</option>
										<option value="Malawi">Malawi</option>
										<option value="Maldives">Maldives</option>
										<option value="Mali">Mali</option>
										<option value="Malta">Malta</option>
										<option value="Marshall Islands">Marshall Islands</option>
										<option value="Martinique">Martinique</option>
										<option value="Mauritania">Mauritania</option>
										<option value="Mauritius">Mauritius</option>
										<option value="Mayotte">Mayotte</option>
										<option value="Mexico">Mexico</option>
										<option value="Midway Islands">Midway Islands</option>
										<option value="Moldova">Moldova</option>
										<option value="Monaco">Monaco</option>
										<option value="Mongolia">Mongolia</option>
										<option value="Montserrat">Montserrat</option>
										<option value="Morocco">Morocco</option>
										<option value="Mozambique">Mozambique</option>
										<option value="Myanmar">Myanmar</option>
										<option value="Nambia">Nambia</option>
										<option value="Nauru">Nauru</option>
										<option value="Nepal">Nepal</option>
										<option value="Netherland Antilles">Netherland Antilles</option>
										<option value="Netherlands">Netherlands (Holland, Europe)</option>
										<option value="Nevis">Nevis</option>
										<option value="New Caledonia">New Caledonia</option>
										<option value="New Zealand">New Zealand</option>
										<option value="Nicaragua">Nicaragua</option>
										<option value="Niger">Niger</option>
										<option value="Nigeria">Nigeria</option>
										<option value="Niue">Niue</option>
										<option value="Norfolk Island">Norfolk Island</option>
										<option value="Norway">Norway</option>
										<option value="Oman">Oman</option>
										<option value="Pakistan">Pakistan</option>
										<option value="Palau Island">Palau Island</option>
										<option value="Palestine">Palestine</option>
										<option value="Panama">Panama</option>
										<option value="Papua New Guinea">Papua New Guinea</option>
										<option value="Paraguay">Paraguay</option>
										<option value="Peru">Peru</option>
										<option value="Phillipines">Philippines</option>
										<option value="Pitcairn Island">Pitcairn Island</option>
										<option value="Poland">Poland</option>
										<option value="Portugal">Portugal</option>
										<option value="Puerto Rico">Puerto Rico</option>
										<option value="Qatar">Qatar</option>
										<option value="Republic of Montenegro">Republic of Montenegro</option>
										<option value="Republic of Serbia">Republic of Serbia</option>
										<option value="Reunion">Reunion</option>
										<option value="Romania">Romania</option>
										<option value="Russia">Russia</option>
										<option value="Rwanda">Rwanda</option>
										<option value="St Barthelemy">St Barthelemy</option>
										<option value="St Eustatius">St Eustatius</option>
										<option value="St Helena">St Helena</option>
										<option value="St Kitts-Nevis">St Kitts-Nevis</option>
										<option value="St Lucia">St Lucia</option>
										<option value="St Maarten">St Maarten</option>
										<option value="St Pierre &amp; Miquelon">St Pierre &amp; Miquelon</option>
										<option value="St Vincent &amp; Grenadines">St Vincent &amp; Grenadines</option>
										<option value="Saipan">Saipan</option>
										<option value="Samoa">Samoa</option>
										<option value="Samoa American">Samoa American</option>
										<option value="San Marino">San Marino</option>
										<option value="Sao Tome &amp; Principe">Sao Tome &amp; Principe</option>
										<option value="Saudi Arabia">Saudi Arabia</option>
										<option value="Senegal">Senegal</option>
										<option value="Serbia">Serbia</option>
										<option value="Seychelles">Seychelles</option>
										<option value="Sierra Leone">Sierra Leone</option>
										<option value="Slovakia">Slovakia</option>
										<option value="Slovenia">Slovenia</option>
										<option value="Solomon Islands">Solomon Islands</option>
										<option value="Somalia">Somalia</option>
										<option value="South Africa">South Africa</option>
										<option value="Spain">Spain</option>
										<option value="Sri Lanka">Sri Lanka</option>
										<option value="Sudan">Sudan</option>
										<option value="Suriname">Suriname</option>
										<option value="Swaziland">Swaziland</option>
										<option value="Sweden">Sweden</option>
										<option value="Switzerland">Switzerland</option>
										<option value="Syria">Syria</option>
										<option value="Tahiti">Tahiti</option>
										<option value="Taiwan">Taiwan</option>
										<option value="Tajikistan">Tajikistan</option>
										<option value="Tanzania">Tanzania</option>
										<option value="Thailand">Thailand</option>
										<option value="Togo">Togo</option>
										<option value="Tokelau">Tokelau</option>
										<option value="Tonga">Tonga</option>
										<option value="Trinidad &amp; Tobago">Trinidad &amp; Tobago</option>
										<option value="Tunisia">Tunisia</option>
										<option value="Turkey">Turkey</option>
										<option value="Turkmenistan">Turkmenistan</option>
										<option value="Turks &amp; Caicos Is">Turks &amp; Caicos Is</option>
										<option value="Tuvalu">Tuvalu</option>
										<option value="Uganda">Uganda</option>
										<option value="Ukraine">Ukraine</option>
										<option value="United Arab Erimates">United Arab Emirates</option>
										<option value="United Kingdom">United Kingdom</option>
										<option value="United States of America">United States of America</option>
										<option value="Uraguay">Uruguay</option>
										<option value="Uzbekistan">Uzbekistan</option>
										<option value="Vanuatu">Vanuatu</option>
										<option value="Vatican City State">Vatican City State</option>
										<option value="Venezuela">Venezuela</option>
										<option value="Vietnam">Vietnam</option>
										<option value="Virgin Islands (Brit)">Virgin Islands (Brit)</option>
										<option value="Virgin Islands (USA)">Virgin Islands (USA)</option>
										<option value="Wake Island">Wake Island</option>
										<option value="Wallis &amp; Futana Is">Wallis &amp; Futana Is</option>
										<option value="Yemen">Yemen</option>
										<option value="Zaire">Zaire</option>
										<option value="Zambia">Zambia</option>
										<option value="Zimbabwe">Zimbabwe</option>
									<%}%>
									</select>
									<br>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label" style="margin-bottom:20px;">Number of Adults*</label>
								<div class="col-sm-10">
									<select class="form-control" name="bk_noOfSeats" style="width: 10%">
										<option value="1">1</option>
										<option value="2">2</option>
										<option value="3">3</option>
										<option value="4">4</option>
										<option value="5">5</option>
										<option value="6">6</option>
										<option value="7">7</option>
										<option value="8">8</option>
										<option value="9">9</option>
									</select>
									<br>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label" style="margin-bottom:20px;">Cabin Class*</label>
								<div class="col-sm-10">
									<%if(session.getAttribute("promotion_cost")!=null){
										if(session.getAttribute("promotion_cabin_class").equals("Economy")){%>
											<input type="radio" style="margin-right: 10px" name="flight_radio1" value="economy_cost" checked>Economy Class
											<input type="radio" style="margin-left: 10px; margin-right: 10px;" name="flight_radio1" value="business_cost" disabled>Business Class
											<input type="radio" style="margin-left: 10px; margin-right: 10px;" name="flight_radio1" value="first_cost" disabled>First Class
										<%}else if(session.getAttribute("promotion_cabin_class").equals("Business")){%>
											<input type="radio" style="margin-right: 10px" name="flight_radio1" value="economy_cost" disabled>Economy Class
											<input type="radio" style="margin-left: 10px; margin-right: 10px;" name="flight_radio1" value="business_cost" checked>Business Class
											<input type="radio" style="margin-left: 10px; margin-right: 10px;" name="flight_radio1" value="first_cost" disabled>First Class
										<%}else{%>
											<input type="radio" style="margin-right: 10px" name="flight_radio1" value="economy_cost" disabled>Economy Class
											<input type="radio" style="margin-left: 10px; margin-right: 10px;" name="flight_radio1" value="business_cost" disabled>Business Class
											<input type="radio" style="margin-left: 10px; margin-right: 10px;" name="flight_radio1" value="first_cost" checked>First Class
										<%}%>
									<%}else{%>
									<input type="radio" style="margin-right: 10px" name="flight_radio1" value="economy_cost" checked>Economy Class
									<input type="radio" style="margin-left: 10px; margin-right: 10px;" name="flight_radio1" value="business_cost">Business Class
									<input type="radio" style="margin-left: 10px; margin-right: 10px;" name="flight_radio1" value="first_cost">First Class
									<%}%>
									<br>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label" style="margin-bottom:20px;">Trip Type*</label>
								<div class="col-sm-10">
									<input type="radio" style="margin-right: 10px" name="flight_radio2" value="single" checked>Single Trip
									<input type="radio" style="margin-left: 10px; margin-right: 10px;" name="flight_radio2" value="return">Return Trip
									<br>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">Travel Period</label>
								<div class="col-md-10">
						           <div class="form-group row">
						               <div class="col-md-4">
						               		<%
						               		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
					               			String startDate = dateFormat.format(new Date());
						               		if(session.getAttribute("promotion_cost")!=null){
						               		%>
						               			<input type="date" class="form-control" name="flight_searchDepart" min="<%=startDate%>" max="<%=session.getAttribute("promotion_enddate")%>" required>
						               		<%}else{%>
						               			<input type="date" class="form-control" name="flight_searchDepart" min="<%=startDate%>">
						               		<%}%>
						               		<span class="control-label">Departure Date*</span>
						               </div>
						               <div class="col-md-4">
						                   <%if(session.getAttribute("promotion_cost")!=null){%>
						                   		<input type="date" class="form-control" name="flight_searchReturn" min="<%=startDate%>" max="<%=session.getAttribute("promotion_enddate")%>">
						                   	<%}else{%>
						                   		<input type="date" class="form-control" name="flight_searchReturn" min="<%=startDate%>">
						                   	<%}%>
						                   <span class="control-label">Return Date*</span>
						               </div>
						           </div>
								</div>
							</div>
							<div class="form-group">
								<div class="col-sm-offset-2 col-sm-10">
									<input type="submit" class="btn btn-info" name="btnSearch" value="Search Flights">
								</div>
							</div>
						</form>
				  	</div>
				  	<div role="tabpanel" class="tab-pane fade" id="promotion">
				  		<h3 style="font-weight: bold; color: #2980b9; text-align: center; margin-top: 30px;">Promotions</h3>
				  		<% 
				  		ArrayList<Bk_promotion> promotionsretrieved = (ArrayList<Bk_promotion>)session.getAttribute("promotionsretrieved");
						if(promotionsretrieved!=null){%>
							<table class="table table-hover" style="width: 80%; margin: 0 auto; margin-top: 30px;">
								<tr style=background-color:#D0D0D0><td>Departure</td><td>Arrival</td><td>Cabin Class</td><td>Promotion Fare</td><td>Book</td></tr>
								<%for(Bk_promotion promotion : promotionsretrieved){
									String promotion_departure_country = promotion.getPromotion_departure_country();
									String promotion_arrival_country = promotion.getPromotion_arrival_country(); 
									String cabin_class = promotion.getSeat_type();
									Long cabin_cost = promotion.getCabin_cost(); 
									String promotion_enddate = promotion.getPromotion_enddate();%>
									<tr><td><%=promotion_departure_country%></td><td><%=promotion_arrival_country%></td><td><%=cabin_class%></td><td>SGD <%=cabin_cost%></td>
									<td>
									<form class="form-group" style="margin-top: 10px;" action="<%=request.getContextPath()%>/AddToCart_promotion" method="POST">
									<input type="hidden" name="cabin_cost" value=<%=cabin_cost%>>
									<input type="hidden" name="promotion_departure_country" value=<%=promotion_departure_country%>>
									<input type="hidden" name="promotion_arrival_country" value=<%=promotion_arrival_country%>>
									<input type="hidden" name="cabin_class" value=<%=cabin_class%>>
									<input type="hidden" name="promotion_enddate" value=<%=promotion_enddate%>>
									<input type="submit" class="btn btn-info" name="btnbook" value="Book"><br><br>By <%=promotion_enddate%></form></td></tr>
								<%}%>
							</table>
				  		<%}else{%>
				  			<form action="ObtainPromotionServlet" class="form-horizontal" method="POST">
					  			<h4 class="text-center" style="margin-top: 30px; margin-bottom: 30px; font-weight: bold;">Display all promotions</h4>
					  			<div class="form-group" style="margin: 0 auto;">
									<div class="col-sm-offset-2 col-sm-10" style="margin-left: 100px; text-align:center;">
										<input type="submit" class="btn btn-default" name="btnDisplay" value="Display All Promotions">
									</div>
								</div>
					  		</form>
				  		<%}%>
					</div>
				</div>
			</article>
		</div>
		
		<!-- Footer -->
		<%@include file="files_other/footer.jsp"%>
	</body>
</html>