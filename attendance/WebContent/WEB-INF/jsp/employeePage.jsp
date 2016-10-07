<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
     <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE HTML>
<!--
	Hyperspace by HTML5 UP
	html5up.net | @ajlkn
	Free for personal and commercial use under the CCA 3.0 license (html5up.net/license)
-->
<html>
	<head>
		<title>Attendance</title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1" />
		<!--[if lte IE 8]><script src="resources/js/ie/html5shiv.js"></script><![endif]-->
		<link rel="stylesheet" href="resources/css/main.css" />
		<!--[if lte IE 9]><link rel="stylesheet" href="resources/css/ie9.css" /><![endif]-->
		<!--[if lte IE 8]><link rel="stylesheet" href="resources/css/ie8.css" /><![endif]-->
		<script type = "text/javascript" 
	         src = "http://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
	<script type="text/javascript">
	
	 function start(){
		 var d = new Date();
		 var empId=${ID};
		 var month=d.getMonth();
		 var year=d.getFullYear();
		 
		  var myData="";
		  myData={"empId":empId, "month":month, "year":year};
		  $.ajax({  
		      url: "startTime",
		     type: 'POST',
		     data:myData,
		     success: function (data) {
		       if(data ==="start"){
		    	  $('#startTime').hide();
		     	  $('#stopTime').show();

		    	  
		        }
		      }
		  });  
	  }
	 function stop(empId){
			  $.ajax({  
			      url: "stopTime",
			     type: 'POST',
			     
			     success: function (data) {
			       if(data ==="stop"){
			    	  $('#stopTime').hide();
			    	  $('#logout').show();

			    	  
			        }
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
							<li>
								<c:choose>
								    <c:when test="${status=='stop'}">
										<div id= "startTime"  >
											<input id="start" type="button" class="button fit" onclick="start();"  value="Start Time"/>
										</div>
									</c:when>
				
									 <c:otherwise >
									 	<div id="stopTime" style="display:block;">
											<input  id="stop" type="button" class="button fit" onclick="stop()"  value="Stop Time"/>
										</div>
										<!-- <div id="logout" style="display:block;">
											<a href="logout" class="button" >LOGOUT</a>
										</div> -->
									</c:otherwise>
								</c:choose>
							</li>
							<!-- <li><a href="empHome" >Home</a></li> -->
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
						<section id="main" class="wrapper">
							<!-- <iframe src="https://calendar.google.com/calendar/embed?src=eil5jlpmna90bv139qj2fankms%40group.calendar.google.com&ctz=Asia/Calcutta" style="border: 1" width="800" height="600" frameborder="0" scrolling="no"></iframe> -->
							<h1>Roshi Software Solutions Pvt Ltd</h1>
							<p>One Stop for all your Technical needs.</p>
							<ul class="actions">
								<!-- <li><a href="#one" class="button scrolly">Learn more</a></li> -->
							</ul>
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
