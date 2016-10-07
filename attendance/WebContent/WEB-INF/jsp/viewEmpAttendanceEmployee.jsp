  <%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
  <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
  <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
  <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
  <%@ page  language="java" import="java.util.*,java.text.*"%>
  <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

  
<!DOCTYPE HTML>

<html>
	<head>
		<title>Employee Attendance</title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1" />
		<!--[if lte IE 8]><script src="resources/js/ie/html5shiv.js"></script><![endif]-->
		<link rel="stylesheet" href="resources/css/main.css" />
		<!--[if lte IE 9]><link rel="stylesheet" href="resources/css/ie9.css" /><![endif]-->
		<!--[if lte IE 8]><link rel="stylesheet" href="resources/css/ie8.css" /><![endif]-->		
	</head>
	<body>
		<!-- Sidebar -->
			<section id="sidebar">
				<div class="inner">
					<nav>
						<ul>
							<!-- <li><a href="time">Employee TimeStamp</a></li> -->
							<li><a href="viewEmpAttendance" >View Attendance</a></li>
							<li><a href="leaveCalendar" >Apply For Leave</a></li>
							
						</ul>
					</nav>
				</div>
			</section>
		
		<!-- Wrapper -->
			<div id="wrapper">
			
				<!-- Intro -->
					<section id="intro" class="wrapper style1 fullscreen fade-up">
						<div align="right" style="margin-top: 5px;margin-right: 5px;">
							<a href="logout" class="button">LOGOUT</a>
						</div>
						
						<div class="inner">
							<h1 class="major">Employee</h1>
															
							<!-- Main -->
							<section id="main" class="wrapper">
								<div class="inner">	
										<div style="margin-left: 0px; ">	
									<form name="frm" method="post" action="getDetails">									
										<table class="alt">										   
										  <tr>
											 <td>&nbsp;</td>
										     <td>
										    	<table >
											  	 <tr>
											    	 <td>
											    		<table >
											      			<tr>
														        <td width="3%">Year ${empcalendar}</td>
														         <td width="3%">
															         <select name="iYear" id= "iYear">																         														     
																         <c:forEach var="iy" begin="${empDetails.iTYear-70}" end="${empDetails.iTYear+70}">
																        	<c:choose>
																        		<c:when test="${iy eq empDetails.iYear}">
																        			<option value="${iy}" selected="selected"> ${iy}</option>
																        		</c:when>
																        		<c:otherwise>
																        			<option value="${iy}"> ${iy} </option>
																        		</c:otherwise>
																        	</c:choose>																        	
																        </c:forEach> 
															        </select> 
															          <%-- <td width="20%" align="center" style="color:#4E96DE">
																          <h3>
																	          <fmt:parseDate value="${iMonth}" dateStyle="long" pattern="MM" var="monthDate"></fmt:parseDate>
																			  <fmt:formatDate value="${monthDate}" pattern="MM"></fmt:formatDate>${iYear}</h3>
																	  </td> --%>
															        <td width="1%">Month</td>
															        <td width="2%">
																        <select name="iMonth" id="iMonth">
																	        <c:forEach var="im" begin="${1}" end="${12}">																       
																		        <c:choose>
																		        	<c:when test="${im==empDetails.iMonth}">
																		        		<option value="${im}" selected="selected">
																		        			<fmt:parseDate value="${im}" dateStyle="long" pattern="MM" var="monthDate"/>
																		        			<fmt:formatDate value="${monthDate}" pattern="MM"/>
																		        		</option>
																		        	</c:when>
																		        	<c:otherwise>
																		        		  <option value="${im}">
																			        		  <%-- <jsp:useBean id="monthNames" class="java.text.DateFormatSymbols" />
																			        		  <c:set value="${monthNames.im}" var="im" /> --%>
																		        		  	<fmt:parseDate value="${im}" dateStyle="long" pattern="MM" var="monthDate"/>
																		        		  	<fmt:formatDate value="${monthDate}" pattern="MM"/>
																		        		  </option>
																		        	</c:otherwise>
																		        </c:choose>
																	         </c:forEach>  																         
															         	 </select>
														         	 </td>
											     			  	 </tr>
											   			   	 </table>
											   		   	 </td>
											 	    	</tr>
													     <tr>
													      <td><table >
													       <tbody>
														        <tr>
														          <th>Sun</th>
														          <th>Mon</th>
														          <th>Tue</th>
														          <th>Wed</th>
														          <th>Thu</th>
														          <th>Fri</th>
														          <th>Sat</th>
														       </tr>													       		
														       	<c:set var="cnt" value="1"/>
														        <c:forEach begin="1" end="${empDetails.iTotalweeks }">
														        	<tr>
															       		<c:forEach begin="1" end="7">
															       		   <c:set var="present" value="false" scope="request" />
															       		   <c:set var="absent" value="false" scope="request" />
															       		   <c:set var="leave" value="false" scope="request" />
																	       <c:choose>
																		       	<c:when test="${cnt < empDetails.weekStartDay || cnt- empDetails.weekStartDay+1 > empDetails.days }">
																		       		<td align="center" height="35">&nbsp;</td>
																		       	</c:when>
																	       	 <c:otherwise>
																		       	 
																		       	 	<c:if test="${fn:length(empDetails.present) gt 0}">																	       	 
																	       	 			 <c:forEach var="presentDay" items="${empDetails.present}">
																			       			<c:if test="${cnt-empDetails.weekStartDay+1 eq presentDay}">
																			       				<c:set var="present" value="${true}" scope="request" />
																			       				<td align="center" style="background-color: #86b300;" height="35" id="day_${cnt-empDetails.weekStartDay+1}">
																			       					<span>${cnt-empDetails.weekStartDay+1}</span>
																			       				</td>
																			       			</c:if>	
																			       																		       			
																			       		</c:forEach>
																		       		</c:if> 
																		       		<c:if test="${fn:length(empDetails.absent) gt 0}">												       	 	
																       	       		  <c:forEach var="absentDay" items="${empDetails.absent}">														       	       		    															       		  								       		  
																		       			 <c:if test="${cnt-empDetails.weekStartDay+1 eq absentDay}">
																		       			 	<c:set var="absent" value="${true}" scope="request"/>															       			 	
																		       				<td align="center" style="background-color: #ff66cc;" height="35" id="day_${cnt-empDetails.weekStartDay+1}">
																		       					<span>${cnt-empDetails.weekStartDay+1}</span>
																		       				</td> 
																		       			</c:if> 														       																       			
																       				</c:forEach>
															       				</c:if>
															       				<c:if test="${empDetails.approve eq 'yes'}">
																       				<c:if test="${fn:length(empDetails.leave) gt 0}">																       	
																			       		<c:forEach var="leaveDay" items="${empDetails.leave}">
																			       			<c:if test="${cnt-empDetails.weekStartDay+1 eq leaveDay}">
																			       				<c:set var="leave" value="${true}" scope="request"/>
																			       				<td align="center" style="background-color: #009999;" height="35" id="day_${cnt-empDetails.weekStartDay+1}">
																			       					<span>${cnt-empDetails.weekStartDay+1}</span>
																			       				</td>
																			       			</c:if>
																			       		</c:forEach>
																		       		</c:if>
																	       		</c:if>																	       		
																	       			<c:if test="${present eq false && absent eq false && leave eq false }">																		       																				       																	       																			       																		       		 	
																			       		<td align="center" height="35" id="day_${cnt-empDetails.weekStartDay+1}">
																	       					<span>${cnt-empDetails.weekStartDay+1}</span>
																	       				</td>																	       				
																	       			</c:if>																       				 																	       		 																		  															       															       																	     
																        </c:otherwise>  			
														       		</c:choose>    	
														       	 <c:set var="cnt" value="${cnt+1}"/>														       	  
														       </c:forEach>
													       	</tr>
													       </c:forEach>													       													      
														  </tbody>
														 </table>
													    </td>
													  </tr>
													</table>
												  </td>
												<td>&nbsp;</td> 
											  </tr>
										   </table>										
									    </form>
									 </div>	
								  </div>
							 </section>
						 </div>
					 </section>
				</div>			
		<!-- Footer -->
			<footer id="footer" class="wrapper style1-alt">
				<div class="inner">
					<ul class="menu">
						<li>&copy; Untitled. All rights reserved.</li><li>Design: <a href="http://html5up.net">HTML5 UP</a></li>
					</ul>
				</div>
			</footer>
		<!-- Scripts -->
			<script src="resources/js/jquery.min.js"></script>
			<script src="resources/js/jquery.scrollex.min.js"></script>
			<script src="resources/js/jquery.scrolly.min.js"></script>
			<script src="resources/js/skel.min.js"></script>
			<script src="resources/js/util.js"></script>
			<!--[if lte IE 8]><script src="resources/js/ie/respond.min.js"></script><![endif]-->
			<script src="resources/js/main.js"></script>
	</body>
</html>
