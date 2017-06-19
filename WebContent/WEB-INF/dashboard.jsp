<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="entities.User" %>
<%@page import="entities.Errand" %>
<%@ taglib  prefix = "c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page import="java.io.*, java.net.*,java.util.*"%>

<%-- Language Declaration and Resource Bundle --%>
<% 
String lang = request.getParameter( "lang" );
  if ( lang == null){ lang = "en";}
  ResourceBundle RB = ResourceBundle.getBundle("com.lang.i18n.text", new Locale(lang));
%> 

<%-- Variable Declarations --%>
<%! String profile, notifications, activeErrands, pastErrands, ratings, myAccount, 
     editProfile, changePhoto, settings, gophRating, custRating, username, email,
     toGopher, needGopher, errand, reward, deadline, reqDate, reqErrand, gopheredErrands, 
     dateCompleted, ratingsAsCust, ratingsAsGopher, rating, comments, date, by; %>

<%-- Variable Initializations --%>
<% 
  profile = RB.getString("profile"); 
  notifications = RB.getString("notifications"); 
  activeErrands = RB.getString("activeErrands"); 
  pastErrands = RB.getString("pastErrands"); 
  ratings = RB.getString("ratings"); 
  myAccount = RB.getString("myAccount"); 
  editProfile = RB.getString("editProfile"); 
  changePhoto = RB.getString("changePhoto"); 
  settings = RB.getString("settings"); 
  gophRating = RB.getString("gophRating"); 
  custRating = RB.getString("custRating"); 
  username = RB.getString("username"); 
  email = RB.getString("email"); 
  toGopher = RB.getString("toGopher"); 
  needGopher = RB.getString("needGopher");
  errand = RB.getString("errand"); 
  reward = RB.getString("reward"); 
  deadline = RB.getString("deadline"); 
  reqDate = RB.getString("reqDate"); 
  reqErrand = RB.getString("reqErrand"); 
  gopheredErrands = RB.getString("gopheredErrands"); 
  dateCompleted = RB.getString("dateCompleted"); 
  ratingsAsCust = RB.getString("ratingsAsCust");
  ratingsAsGopher = RB.getString("ratingsAsGopher");
  rating = RB.getString("rating"); 
  comments = RB.getString("comments"); 
  date = RB.getString("date"); 
  by = RB.getString("by");  
%>

<jsp:include page="header.jsp"/>	


	<style>
		.jumbotron {
			margin-bottom: 0px !important;
		}
		.jumbotron h1 {
  			font-size: 36px !important;
		}
		.profile-header {
			padding-top: 50px;
			padding-bottom: 50px;
			background-color: #c7eaee;
		}
		
		.profile-header-img {
			margin-top: 20px;
		}
	
		.img-circle {
			border-radius: 50%;
			border: 3px solid white;
		}
		
		.dashboard-nav a, a:hover {
			padding: 10px 15px;
			font-size: 16px;
			color: #555;
		}
		.dashboard-nav{
			background-color:ghostwhite;
		}
		
		.dashboard-content {
			border-style: solid;
			border-color: #ddd;
			border-width: 0px 1px 1px 1px;
			border-radius: 0px 0px 10px 10px;
			background-color: white;
			margin: 0px;
			padding: 20px;
			min-height: 500px;
		}
		
		table {
			table-layout: fixed;
			/*width: 100%;*/
			/*cell-padding: 20px;*/
		}
		
		.table-title {
			display: inline-flex;
			padding: 0px 10px 10px 0px;
		}
		
		tr {
			/*margin: 5px;*/
		}
		
		.edit-btns {
			float: right;
		}
		
		.tab-icon {
			padding-right: 10px;
		}
	</style>
	
	<!-- ****************END STYLE BLOCK******************* -->
	
	
	<!-- User dashboard header -->
    <div class="container-fluid profile-header text-center jumbotron">
    	<div class="profile-header-img">
    	
    		<!-- Hack for demo to show profile pic for Skye only -->
    		<c:if test="${userObject.getId() == 102}">
    			<img class="img-circle" src="assets/img/profile_img.jpg" >
    		</c:if>
    		<c:if test="${userObject.getId() != 102}">
    			<img class="img-circle" src="assets/img/cute_gopher.png" >
    		</c:if>		
    		
		</div>
		<h1><c:out value="${userObject.getUsername()}" /> </h1>
	</div>
	
	<!-- Tab navigation for dashboard content -->	
	<div>
		<div class="dashboard-nav">
			<ul class="nav nav-tabs">
				<li class="active"><a data-toggle="tab" href="#profile"><%=profile%></a></li>
				<li><a data-toggle="tab" href="#alerts"><%=notifications%></a></li>
				<li><a data-toggle="tab" href="#active-errands"><%=activeErrands%></a></li>
				<li><a data-toggle="tab" href="#past-errands"><%=pastErrands%></a></li>
				<li><a data-toggle="tab" href="#ratings"><%=ratings%></a></li>
			</ul>
		</div>
		
		<!-- This section holds dashboard content for the selected tab -->
		<div class="tab-content dashboard-content">
			
			<!-- Profile info, displayed by default -->
			<div id="profile" class="tab-pane fade in active table-responsive">
				<h3 class="table-title"><span class="glyphicon glyphicon-user tab-icon"></span>
					<%=myAccount%>
				</h3>
				<div class="btn-group edit-btns" role="group">
					<button type="button" class="btn btn-default btn-sm" aria-label=<%=editProfile%>>
						<span class="glyphicon glyphicon-pencil" data-toggle="tooltip" title=<%=editProfile%>></span>
					</button>
					<button type="button" class="btn btn-default btn-sm" aria-label=<%=changePhoto%>>
						<span class="glyphicon glyphicon-camera" data-toggle="tooltip" title=<%=changePhoto%>></span>
					</button>
					<button type="button" class="btn btn-default btn-sm" aria-label=<%=settings%>>
						<span class="glyphicon glyphicon-cog" data-toggle="tooltip" title=<%=settings%>></span>
					</button>
				</div>
				<table class="table">
					<tr>
						<th><%=username%>:</th>
						<td>${userObject.getUsername()}
					<tr>
						<th><%=email%>:</th>
						<td>${userObject.getEmail()}</td>
					</tr>
					<tr>
						<th><%=gophRating%>:</th>
						<td><c:forEach begin="1" end="${gopherRatingAvg}">
							<img class="img-circle" src="assets/img/rating.png" >
						</c:forEach></td>
					</tr>
					<tr>
						<th><%=custRating%>:</th>
						<td><c:forEach begin="1" end="${customerRatingAvg}">
							<img class="img-circle" src="assets/img/rating.png" >
						</c:forEach></td>
					</tr>
				</table>
			</div>
			
			<!--  Notifications tab -->
			<div id="alerts" class="tab-pane fade table-responsive">
				<h3 class="table-title"><span class="glyphicon glyphicon-bell tab-icon"></span>
					<%=notifications%>
				</h3>
				<table class="table">
					<tr>
						<th>Message Type</th>
						<th>Title</th>
						<th>Message</th>
					</tr>
<!-- 					<tr> -->
<!-- 						<td>No notifications to show</td> -->
<!-- 					</tr> -->
					
					<!-- List all notifications for this user -->
					<c:forEach items="${notifs}" var="notif">
						<tr>
							<td>${notif.getNotificationTypeID().getTitle() }
							<td>${notif.getTitle() }</td>
							<td>${notif.getMessage() }</td>
						</tr>
					</c:forEach>
				</table>
			</div>
			
			<!--  User's active errands - requesting or to-do -->
			<div id="active-errands" class="tab-pane fade table-responsive">
				<h3 class="table-title"><span class="glyphicon glyphicon-exclamation-sign tab-icon"></span>
					<%=toGopher %>
				</h3>
				<table class="table">					
						<tr>
							<th><%=errand%></th>
							<th><%=reward%></th>
							<th><%=deadline%></th>
						</tr>
						
						<!-- List all errands for which this user is registered as a Gopher -->
						<c:forEach items="${errandsGopher}" var="errand">
							<tr>
								<td><a href="/errand?id=${errand.getId() }" >${errand.getName()}</a></td>
								<td>$ ${errand.getRewardId().getRewardValue() }</td>
								<td>${errand.getDeadline() }</td>
							</tr>
						</c:forEach>
				</table>
				<h3 class="table-title"><span class="glyphicon glyphicon-hourglass tab-icon"></span>
					<%=needGopher %>
				</h3>
				<table class="table">
					<tr>
						<th><%=errand%></th>
						<th><%=reward%></th>
						<th><%=reqDate%></th>
					</tr>
					
					<!-- List all errands for which this user is registered as a Customer -->
					<c:forEach items="${errandsCustomer}" var="errand">
					<tr>
						<td><a href="/errand?id=${errand.getId() }" >${errand.getName()}</a></td>
						<td>$ ${errand.getRewardId().getRewardValue() }</td>
						<td>${errand.getDateCreated() }</td>
					</tr>
					</c:forEach>
				</table>
			</div>
			
			<!-- Past errands completed or requested by user -->
			<div id="past-errands" class="tab-pane fade table-responsive">
				<h3 class="table-title"><span class="glyphicon glyphicon-star tab-icon"></span>
					<%=gopheredErrands %>
					</h3>
				<table class="table">
					<tr>
						<th><%=errand%></th>
						<th><%=reward%></th>
						<th><%=dateCompleted %></th>
					</tr>
					
					<!-- List all completed errands for which this user is registered as a Gopher -->
					<c:forEach items="${completedErrandsGopher}" var="errand">
						<tr>
							<td><a href="/errand?id=${errand.getId() }" >${errand.getName()}</a></td>
							<td>$ ${errand.getRewardId().getRewardValue() }</td>
							<td>${errand.getDeadline() }</td>
						</tr>
					</c:forEach>
				</table>
				<h3 class="table-title"><span class="glyphicon glyphicon-list-alt tab-icon"></span>
					<%=reqErrand %>
				</h3>
				<table class="table">
					<tr>
						<th><%=errand%></th>
						<th><%=reward%></th>
						<th><%=dateCompleted %></th>
					</tr>
					
					<!-- List all completed errands for which this user is registered as a Customer -->
					<c:forEach items="${completedErrandsCustomer}" var="errand">
					<tr>
						<td><a href="/errand?id=${errand.getId() }" >${errand.getName()}</a></td>
						<td>$ ${errand.getRewardId().getRewardValue() }</td>
						<td>${errand.getDateCreated() }</td>
					</tr>
					</c:forEach>
				</table>
			</div>
			
			<!--  Ratings tab -->
			<div id="ratings" class="tab-pane fade table-responsive">
				<h3 class="table-title"><span class="glyphicon glyphicon-heart tab-icon"></span>
					<%=ratingsAsCust %>
				</h3>
				<table class="table">
					<tr>
						<td><%=rating%></td>
						<td><%=comments%></td>
						<td><%=date%></td>
						<td><%=by%></td>
						<td><%=errand%><td>
					</tr>
					
					<!-- List all ratings for which this user was registered as a customer -->
						<c:forEach items="${ratingsCustomer}" var="rating">
							<tr>
								<td><c:forEach begin="1" end="${rating.getRatingValue()}">
									<img class="img-circle" src="assets/img/rating.png" >
								</c:forEach></td>
								<td>${rating.getComments()}</td>
								<td>${rating.getCreationDate()}</td>
								<td>${rating.getUserIdRater().getUsername()}
								<td>${rating.getErrandId().getName()}
							</tr>
						</c:forEach>
				</table>
				<h3 class="table-title"><span class="glyphicon glyphicon-heart tab-icon"></span>
					<%=ratingsAsGopher %>
				</h3>
				<table class="table">
					<tr>
						<td>Rating</td>
						<td>Comments</td>
						<td>Date</td>
						<td>By</td>
						<td>Errand<td>
					</tr>
					
					<!-- List all ratings for which this user was registered as a gopher -->
						<c:forEach items="${ratingsGopher}" var="rating">
							<tr>
								<td><c:forEach begin="1" end="${rating.getRatingValue()}">
									<img class="img-circle" src="assets/img/rating.png" >
								</c:forEach></td>
								<td>${rating.getComments()}</td>
								<td>${rating.getCreationDate()}</td>
								<td>${rating.getUserIdRater().getUsername()}
								<td>${rating.getErrandId().getName()}
							</tr>
						</c:forEach>
				</table>
			</div>
					
		</div>
	</div>
<jsp:include page="footer.jsp"/>