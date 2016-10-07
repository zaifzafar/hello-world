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
		<title>Admin Page</title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1" />
		<!--[if lte IE 8]><script src="resources/js/ie/html5shiv.js"></script><![endif]-->
		<link rel="stylesheet" href="resources/css/main.css" />
		<!--[if lte IE 9]><link rel="stylesheet" href="resources/css/ie9.css" /><![endif]-->
		<!--[if lte IE 8]><link rel="stylesheet" href="resources/css/ie8.css" /><![endif]-->
		
		<script type="text/javascript">
		
			function approved(empId, month, year) {
				 var myData="";
				 myData = {"empID":empId, "month": month, "year":year };
				 $.ajax({
					 url:"approve",
				     type:'POST',
				     data: myData,
				     success: function (data) {
				    	 if(data == "yes"){
				    		 alert("data Updated Successfully");
				    		 $("#approve"+empId+""+month+""+year).css("background-color", "green");
				    	 }
				    	 else{
				    		 alert("Error Occured");
				    	 }
				     }
				 });  
			}
			function notapproved(empId, month, year) {
				var myData="";
				myData = {"empID":empId, "month": month, "year":year};
				 $.ajax({
					 url:"notapprove",
				     type:'POST',
				     data: myData,
				     success: function (data) {
				    	 if(data == "yes"){
				    		 alert("Updated Successfully");
				    		 $("#notapprove"+empId+""+month+""+year).css("background-color","red");
				    	 }
				    	 else{
				    		 alert("Error Occured")
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
							<li><a href="time">Employee TimeStamp</a></li>
							<li><a href="viewAttendance">Employee Attendance</a></li>
							<li><a href="approveLeave">Approve Leave</a></li>
						</ul>
					</nav>
				</div>
			</section>

		<!-- Wrapper -->
			<div id="wrapper">				
				<!-- Intro -->
					<section id="intro" class="wrapper style1 fullscreen fade-up">
						<div align="right" style="margin-top: 5px;margin-right: 5px; ">
							<a href="logout" class="button">LOGOUT</a>
						</div>
						<div class="inner">
							<h1 class="major">Welcome Admin</h1>
							
							<%--  <select>
								<c:forEach var='employee' items='${name}'>
								<option>${employee.empName}</option>
								</c:forEach>
							</select>  --%>
							<!-- Table -->
								<section>
									<div align="center" >
										<h3> ${msg }</h3>
										<!-- <h3> Employee List</h3> -->
									</div>
									<div class="table-wrapper">
										<table class="alt">
											<thead>
												<tr>
													<th>EMPID</th>													
													<th>LEAVE DAY</th>
													<th>LEAVE MONTH</th>
													<th>LEAVE YEAR</th>
													<th>LEAVE REASON</th>
													<th>APPROVED</th>													
												</tr>
											</thead>
											<c:forEach var='leave' items='${leaveList}'>
											<tbody>
												<tr>
													<td >${leave.empId }</td>
													<td>${leave.leaveDay }</td>
													<td >${leave.month}</td> 
													<td >${leave.year }</td>
													<td>${leave.reason}</td>
													
													<td align="center">
														<a  class="button small special"  onclick="approved(${leave.empId}, ${leave.month}, ${leave.year});" 
														id="approve${leave.empId}${leave.month}${leave.year}" >Approve</a>
														
														<a class="button small special" onclick="notapproved(${leave.empId}, ${leave.month}, ${leave.year});" 
														id="notapprove${leave.empId}${leave.month}${leave.year}">Not Approve</a>
													</td>
												</tr>
											</tbody>
										  </c:forEach>
										</table>
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

<!-- alert(JSON.stringify(myData)); -->


<!-- //this.disabled=true;
			//document.getElementById("#approve").disabled = true;
			//$("#approve").prop("disabled","disabled");
			//$("#approve").attr("disabled","disabled"); -->