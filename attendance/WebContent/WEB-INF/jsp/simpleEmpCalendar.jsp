<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page  language="java" import="java.util.*,java.text.*"%>

 <%! public int nullIntconv(String inv)
{   
    int conv=0;
        
    try{
        conv=Integer.parseInt(inv);
    }
    catch(Exception e)
    {}
    return conv;
}
%>
<%
	
 int iYear=nullIntconv(request.getParameter("iYear"));
 int iMonth=nullIntconv(request.getParameter("iMonth"));

 Calendar ca = new GregorianCalendar();
 int iTDay=ca.get(Calendar.DATE); 
 int iTYear=ca.get(Calendar.YEAR);
 int iTMonth=ca.get(Calendar.MONTH);

  if(iYear==0)
 {
      iYear=iTYear;
      iMonth=iTMonth;
 } 

 GregorianCalendar cal = new GregorianCalendar (iYear, iMonth, 1); 

 int days=cal.getActualMaximum(Calendar.DAY_OF_MONTH);
 int weekStartDay=cal.get(Calendar.DAY_OF_WEEK);
 
 cal = new GregorianCalendar (iYear, iMonth, days); 
 int iTotalweeks=cal.get(Calendar.WEEK_OF_MONTH);
  
%> 

<!DOCTYPE HTML>

<html>
	<head>
		<title>Calendar</title>
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
					<h1 class="major" align="center">Employee</h1>
						<div class="inner">
						
							<form name="frm" method="post" action="getEmpDetails">
							<div class="row">
								
								<div class="9u 12u$(small)">
							
								
								<table >
								  
								  <tr>
								    
								    <td><table >
								  <tr>
								    <td><table >
								      <tr>
								        <td width="2%">Year</td>
								        <td width="17%">
								        <select name="iYear" onChange="" >
								         <%
						       				  // start year and end year in combo box to change year in calendar
						       					 for(int iy=iTYear-70;iy<=iTYear+70;iy++)
						       					 {
						        				  if(iy==iYear)
						          				{
						           		 %>
								          <option value="<%=iy%>" selected="selected"><%=iy%></option>
								          <%
						         			 }
						         			 else
						         			 {
						           		 %>
								          <option value="<%=iy%>"><%=iy%></option>
								          <%
						         			 }
						        			}
						     			  %> 
								        </select></td>
								        <td width="20%" align="center" style="color:#4E96DE"><h3><%=new SimpleDateFormat("MMMM").format(new Date(2008,iMonth,01))%> <%=iYear%></h3></td>
								        <td width="2%">Month</td>
								        <td width="20%">
								        <select name="iMonth" onChange="">
								        <%
						      				  // print month in combo box to change month in calendar
						       					 for(int im=0;im<=11;im++)
						       					 {
						         					 if(im==iMonth)
						         					 {
						        		 %>
								          <option value="<%=im%>" selected="selected"><%=new SimpleDateFormat("MMMM").format(new Date(2008,im,01))%></option>
								          <%
						         			 }
						         			 else
						         			 {
						           		 %>
								          <option value="<%=im%>"><%=new SimpleDateFormat("MMMM").format(new Date(2008,im,01))%></option>
								          <%
						         				 }
						       				 }
						      			 %>
								        </select></td>
								      </tr>
								    </table>
								  
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
								        
								         
								        <%
								        	// String color="red"; 
								        //style="background-color:<%=color 
						        			int cnt =1;
						        			for(int i=1;i<=iTotalweeks;i++)
						       				 {
						       			 %>
								        <tr>
								      
								          <% 
						           			 for(int j=1;j<=7;j++)
						           			 {
						             		   if(cnt<weekStartDay || (cnt-weekStartDay+1)>days)
						              		  {
						                 %>
								                <td align="center" height="35" class="dsb">&nbsp;</td>
								               <% 
						               			 }
						               			 else
						               			 {
						                		 %>
								                <td align="center" height="35"  id="day_<%=(cnt-weekStartDay+1)%>"><span><%=(cnt-weekStartDay+1)%></span></td>
								               <% 
						               				 }
						               			 cnt++;
						             			 }
						           			 %>
								        </tr>
								       
								        <% 
						       				 }
						       			 %>
						       			
								      </tbody>
								    </table>
								 
								</table>								   
							 								 
						    </table>
							</div>
							<div class="1u 12u$(small)">
								<input type="submit" value="GO" class="special">
							</div>
						</div>
					</form>			
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

<!-- <div class="row">
								
								<div class="9u 12u$(small)">


<div class="1u 12u$(small)">
								<input type="submit" value="GO" class="special">
							</div> -->