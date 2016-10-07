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
			function deleteEmpDetails(id)
			{
				var myData="";
				myData={"id":id};
				
				$.ajax({
					url:"deleteEmpDetails",
					type:'POST',
					data:myData,
					success:function (data){
						
							alert("TimeStamp Deleted");
							$('#deleteid'+id).hide();
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
													<th>NAME</th>
													<th>START TIME</th>
													<th>STOP TIME</th>
													<th> TOTAL TIME</th>
													<th>DELETE TIME</th>
												</tr>
											</thead>
											<c:forEach var='employee' items='${employeeList}'>
											<tbody>
												<tr id="deleteid${employee.id}"> 
													<td> ${employee.empId} </td>
													<td> ${employee.empName} </td> 
													<td> ${employee.startTime} </td>
													<td> ${employee.stopTime} </td>
													<td> ${employee.timeDifference} </td>
													<td align="center">
														<a   class="button small special icon fa-remove" onclick="deleteEmpDetails(${employee.id})">Delete</a>
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

<%-- href="./deleteEmpDetails?id=${employee.id}" --%>