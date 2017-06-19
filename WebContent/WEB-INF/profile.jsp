<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="entities.User" %>
<%@page import="entities.Errand" %>
<%@ taglib  prefix = "c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page import="java.io.*, java.net.*,java.util.*"%>

<%-- Language Declaration and Resource Bundle --%>
<% 
String lang = request.getParameter( "lang" );
if ( lang == null){ lang = "en";};
  ResourceBundle RB = ResourceBundle.getBundle("com.lang.i18n.text", new Locale(lang));
%> 

<%-- Variable Declarations --%>
<%! String profile, activeErrands, pastErrands, ratings, basicInfo, username, gophRating, custRating,
    toGopher, needGopher, errand, reward, deadline, reqDate, dateCompleted, reqErrand, gopheredErrands,
    ratingsAsCust, ratingsAsGopher, rating, comments, date, by;; %>

<%-- Variable Initializations --%>
<% 
profile = RB.getString("profile"); 
activeErrands = RB.getString("activeErrands"); 
pastErrands = RB.getString("pastErrands"); 
ratings = RB.getString("ratings"); 
basicInfo = RB.getString("basicInfo"); 
username = RB.getString("username"); 
gophRating = RB.getString("gophRating"); 
custRating = RB.getString("custRating"); 
toGopher = RB.getString("toGopher");
needGopher = RB.getString("needGopher");
errand = RB.getString("errand"); 
reward = RB.getString("reward"); 
deadline = RB.getString("deadline"); 
reqDate = RB.getString("reqDate"); 
dateCompleted = RB.getString("dateCompleted"); 
reqErrand = RB.getString("reqErrand"); 
gopheredErrands = RB.getString("gopheredErrands"); 
ratingsAsCust = RB.getString("ratingsAsCust");
ratingsAsGopher = RB.getString("ratingsAsGopher");
rating = RB.getString("rating"); 
comments = RB.getString("comments"); 
date = RB.getString("date"); 
by = RB.getString("by");  
%>

<jsp:include page="header.jsp"/>	


	<style>
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
    <div class="container-fluid profile-header text-center">
    	<div class="profile-header-img">
    			<img class="img-circle" src="assets/img/cute_gopher.png" >	  		
		</div>
		<h1><c:out value="${viewUser.getUsername()}" /> </h1>
	</div>
	
	<!-- Tab navigation for dashboard content -->
	
	<div>
		<div class="dashboard-nav">
			<ul class="nav nav-tabs">
				<li class="active"><a data-toggle="tab" href="#profile"><%=profile %></a></li>
				<li><a data-toggle="tab" href="#active-errands"><%=activeErrands %></a></li>
				<li><a data-toggle="tab" href="#past-errands"><%=pastErrands %></a></li>
				<li><a data-toggle="tab" href="#ratings"><%=ratings %></a></li>
			</ul>
		</div>
		
		<!-- This section holds dashboard content for the selected tab -->
		<div class="tab-content dashboard-content">
			
			<!-- Profile info, displayed by default -->
			<div id="profile" class="tab-pane fade in active table-responsive">
				<h3 class="table-title"><span class="glyphicon glyphicon-user tab-icon"></span>
					<%=basicInfo %>
				</h3>
				<table class="table">
					<tr>
						<th><%=username %>:</th>
						<td>${viewUser.getUsername()}
					<tr>
						<th><%=gophRating %>:</th>
						<td><c:forEach begin="1" end="${gopherRatingAvg}">
							<img class="img-circle" src="assets/img/rating.png" >
						</c:forEach></td>
					</tr>
					<tr>
						<th><%=custRating %>:</th>
						<td><c:forEach begin="1" end="${customerRatingAvg}">
							<img class="img-circle" src="assets/img/rating.png" >
						</c:forEach></td>
					</tr>
				</table>
			</div>
			 
			<!-- User's current errands - requesting or to-do -->
			<div id="active-errands" class="tab-pane fade table-responsive">
				<h3 class="table-title"><span class="glyphicon glyphicon-exclamation-sign tab-icon"></span>
					${viewUser.getUsername()}'s <%=toGopher %>
				</h3>
				<table class="table">					
						<tr>
							<th><%=errand %></th>
							<th><%=reward %></th>
							<th><%=deadline %></th>
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
					${viewUser.getUsername()}'s <%=needGopher %>
				</h3>
				<table class="table">
					<tr>
						<th><%=errand %></th>
						<th><%=reward %></th>
						<th><%=reqDate %></th>
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
					${viewUser.getUsername()}'s <%=gopheredErrands %>
				</h3>
				<table class="table">
					<tr>
						<th><%=errand %></th>
						<th><%=reward %></th>
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
					${viewUser.getUsername()}'s <%=reqErrand %>
				</h3>
				<table class="table">
					<tr>
						<th><%=errand %></th>
						<th><%=reward %></th>
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
					${viewUser.getUsername()}'s <%=ratingsAsCust %>:
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
					${viewUser.getUsername()}'s <%=ratingsAsGopher %>:
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