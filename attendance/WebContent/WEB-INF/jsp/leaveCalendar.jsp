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
		<title>Leave</title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1" />
		<!--[if lte IE 8]><script src="resources/js/ie/html5shiv.js"></script><![endif]-->
		<link rel="stylesheet" href="resources/css/main.css" />
		<!--[if lte IE 9]><link rel="stylesheet" href="resources/css/ie9.css" /><![endif]-->
		<!--[if lte IE 8]><link rel="stylesheet" href="resources/css/ie8.css" /><![endif]-->
		
		<script type="text/javascript" src="http://code.jquery.com/jquery-1.3.2.min.js"></script>
		
		<script type="text/javascript">		
			function getdate(cnt)
			{
				$("#day"+cnt).css("background-color", "red");
				
				
				//document.getElementById(cnt).disabled = true;
				//$("this").attr("dis");

				var date="";
				date=$('#leaveDay').val();
				date=date+cnt+",";
				$('#leaveDay').val(date);
			}
			
			 function applyLeave() {
				 
				var empId= ${ID};				
				var leaveDay= $('#leaveDay').val();				 
				var month=$('#iMonth').val();				 
				var year=$('#iYear').val();				 
				var reason=$('#reason').val();
				 
				 
				var myData="";
				myData={"empId":empId, "leaveDay":leaveDay, "month":month, "year":year, "reason":reason};
				$.ajax({
					url:"applyLeave",
					type:'POST',
					data:myData,
					success:function(data){						
							alert("Successfully Applied for Leave");	
					}
				});
			} 	
		</script>		
	</head>
	<body>
		<!-- Sidebar -->
			<section id="sidebar">
				<div class="inner">
					<nav>
						<ul>
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
										
										<!-- <div class="4u 12u$(xsmall)"> 
												<input type="text"  id="dateValue" />
										 	</div> <br>	 --> 
								 <div class="row">
									<form name="frm" method="post"  onclick="" > 	
										<div class="row">
											<div class="6u 12u$(xsmall)"> 
												<input type="text"  id="leaveDay" name="leaveDay" placeholder="Select Day"/>
												
										 	</div>	
										 	<div class="6u 12u$(xsmall)"> 
												<textarea rows="3" cols="60" id="reason" name="reason" placeholder="Reason for Leave" required></textarea>
										 	</div>
										 	</div><br>
											<div class="4u 12u$(xsmall)">						
											<table    class="alt">										   
											  <tr>
												 
											     <td>
											    	<table>
												  	 <tr>
												    	 <td>
												    		<table>
												      			<tr>
															        <td width="3%">Year ${empcalendar}</td>
															         <td width="3%">
																         <select name="iYear" id= "iYear">																         														     
																	         <c:forEach var="iy" begin="${leaveDetails.iTYear-70}" end="${leaveDetails.iTYear+70}">
																	        	<c:choose>
																	        		<c:when test="${iy eq leaveDetails.iYear}">
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
																			        	<c:when test="${im==leaveDetails.iMonth}">
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
														      <td><table  >
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
															        <c:forEach begin="1" end="${leaveDetails.iTotalweeks }">
															        	<tr>
																       		<c:forEach begin="1" end="7">
																       		  
																		       <c:choose>
																			       	<c:when test="${cnt < leaveDetails.weekStartDay || cnt- leaveDetails.weekStartDay+1 > leaveDetails.days }">
																			       		<td align="center" class="2u 10u$(xsmall)">&nbsp;</td>
																			       	</c:when>
																		       	 <c:otherwise>																       	 														       																				       																	       																			       																		       		 	
																		       		
																       				<td align="center" height="35"  class="1u 2u$(xsmall)">
																       					<span class="button small"  id="day${cnt-leaveDetails.weekStartDay+1}" onclick="getdate(${cnt-leaveDetails.weekStartDay+1});">${cnt-leaveDetails.weekStartDay+1}</span>
																       				</td>																	       																					       																			       				 																	       		 																		  															       															       																	     
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
										   </div>										   
										   <div class="2u 12u$(xsmall)" >
											<input type="button" value="Apply" class="special" onclick="applyLeave();">
										   </div>																				
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



