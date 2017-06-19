<!DOCTYPE html>
<%@tag description="Main Template Wrapper" pageEncoding="UTF-8"%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Login</title>
		<link href="${pageContext.request.contextPath}/assets/bootstrap/css/bootstrap.css" rel="stylesheet" type="text/css" >
		<link href="${pageContext.request.contextPath}/assets/css/main-style.css" rel="stylesheet" type="text/css" >
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
		<script src="${pageContext.request.contextPath}/assets/bootstrap/js/bootstrap.js"></script>
		
		<style>
			.profile-img {
				max-width: 100%;
				height: auto;
				margin-left: auto;
			    margin-right: auto;
			    margin-top: 20px;
			    margin-bottom: 10px;
				border: 3px solid white;
			    display: block;
			}
		</style>
		
	</head>
	<body>
		<div id="wrapper">
			<div id="sidebar-navigator">
				<div class="container-fluid text-center">
					<img class="img-circle profile-img" src="assets/img/profile_img.jpg" height="100" width="100" >
					<div class="btn-group" role="group">
						<button type="button" class="btn btn-default btn-xs" aria-label="Settings">
							<span class="glyphicon glyphicon-cog" data-toggle="tooltip" title="Settings"></span>
						</button>
						<button type="button" class="btn btn-default btn-xs" aria-label="Notifications">
							<span class="glyphicon glyphicon-bell" data-toggle="tooltip" title="Notifications"></span>
						</button>
					</div>
				</div>
				<ul class="sidebar-nav">
		            <li class="sidebar-brand"><a href="/Gopher/index.html">Gopher</a></li>
		            <li><a href="/Gopher/browse.jsp">Browse</a></li>
		            <li><a href="/Gopher/request.jsp">Request</a></li>
		            <li><a href="/Gopher/dashboard.jsp">Profile</a></li>
		            <li><a href="/Gopher/contact.jsp">Contact</a></li>
        		</ul>
			</div>
			<div class="content">
				<div class="container-fluid">
					<jsp:doBody/>
				</div>
			</div>
		</div>
	</body>
</html>