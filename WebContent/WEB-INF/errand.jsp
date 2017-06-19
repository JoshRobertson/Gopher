<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="entities.Errand" %>
<%@page import="daos.ErrandDao" %>
<%@page import="entities.Task" %>
<%@page import="entities.Rating" %>
<%@ taglib  prefix = "c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page import="java.io.*, java.net.*,java.util.*"%>

<%-- Language Declaration and Resource Bundle --%>
<% 
String lang = request.getParameter( "lang" );
if ( lang == null){ lang = "en";}
  ResourceBundle RB = ResourceBundle.getBundle("com.lang.i18n.text", new Locale(lang));
%> 

<%-- Variable Declarations --%>
<%! String reviews, stars, leaveReview, anon, rating, tasksText, prevRating, taskName, taskDescription, startDate, completionDate, address; %>

<%-- Variable Initializations --%>
<% 
  reviews = RB.getString("reviews"); 
  stars = RB.getString("stars"); 
  leaveReview = RB.getString("leaveReview"); 
  anon = RB.getString("anon"); 
  rating = RB.getString("rating"); 
  tasksText = RB.getString("tasks");
  prevRating = RB.getString("prevRating");
  taskName = RB.getString("taskName");
  taskDescription = RB.getString("taskDescription");
  startDate = RB.getString("startDate");
  completionDate = RB.getString("completionDate");
  address = RB.getString("addressText");
%>

<jsp:include page="header.jsp"/>

<style>
	.jumbotron p {
  		font-size: 14px;
	}
	.task h5{
		font-weight:bolder;
	}
	
	.task-group{
		margin:20px;
		display:inline;
	}
	.task-item{
	}
	.errandStatus{
		font-weight: bolder;
		font-size: 14px;
	}
</style>

<!-- Page Content -->
<!-- <div class="pad-nav-bar pad-me-please"></div> -->
<div class="row bg-teal jumbotron">
    <div class="col-md-8 col-md-offset-2">
        <div class="thumbnail ">
            <img src="assets/img/gopher_small.png" alt="Slide 1"/>
            <div class="caption-full">
                <h4 class="pull-right">$ ${errand.getRewardId().getRewardValue()}</h4>
                <h4><a href="#"style="color: black;">${errand.getName() }</a>
                </h4>
                <p>${errand.getDescription()}</p>
            </div>
            <div class="ratings">
                <p class="pull-right">${ratingsList.size()} <%=reviews %></p>
                <p>
                	<a href="/profile?id=${errand.getUserIdCustomer().getId()}">${errand.getUserIdCustomer().getUsername()}</a>'s <%=rating %>:
                    <c:forEach begin="1" end="${customerAverage}">
                	<span class="glyphicon glyphicon-star"></span>
                	</c:forEach>
                    <c:forEach begin="1" end="${5-customerAverage}">
                	<span class="glyphicon glyphicon-star-empty"></span>
                	</c:forEach>
                    ${customerAverage} <%=stars %>
                </p>
                <c:choose>
					<%-- Not started --%>                
                	<c:when test="${errand.status.index == 2}">
                		<c:choose>
	                		<c:when test="${currentUserIsCustomer}">
								<div class="row">
			                		<div class="col-md-8 errandStatus">Errand Status: No Gopher has accepted your errand yet</div>
			                	</div>
	                		</c:when>
	                		<c:when test="${!currentUserIsGopher}">
                			    <form id="complete-form" action="errand?id=${errand.id}" method="post">
				                	<div class="row">
				                		<button type="submit" class="col-md-4 col-md-offset-4 btn btn-lg btn-success">Accept Errand</button>
				                	</div>
				                </form>
	                		</c:when>
                		</c:choose>
                	</c:when>
                	<c:when test="${errand.status.index == 3}">
                		<c:choose>
	                		<c:when test="${currentUserIsGopher}">
	                			<form id="accept-form" action="errand?id=${errand.id}" method="post">
				                	<div class="row">
				                		<button type="submit" class="col-md-4 col-md-offset-4 btn btn-lg btn-warning">Complete Errand</button>
				                	</div>
				                </form>
	                		</c:when>
	                		<c:when test="${!currentUserIsGopher}">
	                			<div class="row">
	                				<div class="col-md-8 errandStatus">
	                					Errand Status: Errand is in progress by 
	                					<a href="/profile?id=${errand.getUserIdGopher().getId()}">${errand.getUserIdGopher().getUsername()}</a>
	                				</div>
                				</div>
	                		</c:when>
                		</c:choose>
                	</c:when>
                	<c:when test="${errand.status.index == 1}">
                		<div class="row">
                			<div class="col-md-8 errandStatus">
                				Errand Status: This errand has been completed by 
                				<a href="/profile?id=${errand.getUserIdGopher().getId()}">${errand.getUserIdGopher().getUsername()}</a>
                			</div>
               			</div>
                	</c:when>
                </c:choose>            	
            </div>
        </div>
		
        <div class="well bg-white">
            <div>
            	<h4><%=prevRating %></h4>
            </div>
            <hr />
            <c:forEach items="${ratingsList}" var="rating">
            <hr>
            <div class="row">
                <div class="col-md-12">
                	<c:forEach begin="1" end="${rating.ratingValue}">
                	<span class="glyphicon glyphicon-star"></span>
                	</c:forEach>
                    <c:forEach begin="1" end="${5-rating.ratingValue}">
                	<span class="glyphicon glyphicon-star-empty"></span>
                	</c:forEach>
                    <%=anon %>
                    <span class="pull-right">${rating.creationDate}</span>
					<p><c:out value="${rating.comments}"/></p>
                </div>
            </div>
            </c:forEach>
        </div>
        
        <div class="well well-lg bg-white">
            <div class="">
                <h4><%=tasksText%></h4>
            </div>
            <c:forEach items="${errand.tasks}" var="task">
            <hr>
            <div class="row task">
                <div class="col-md-12">
               		<div class="col-md-6">
               			<h5><%=taskName%></h5>
						<p><c:out value="${task.name}"/></p>
					</div>
					<div class="col-md-6">
						<h5><%=taskDescription%></h5>
						<p><c:out value="${task.description}" /></p>
					</div>
<%-- 					<div class="col-md-6">
						<h5><%=startDate%></h5>
						<c:out value="${task.startDate}" />
					</div>
					<div class="col-md-6">
						<h5><%=completionDate%></h5>
						<c:out value="${task.completionDate}" />
					</div> --%>
					<div class="col-md-6">
						<h5><%=address%></h5>
						<c:out value="${task.address_id}" />
					</div>
                </div>
            </div>
            </c:forEach>
        </div>
    </div>
</div>
<!-- /.container -->


<!-- jQuery -->
<script type="text/javascript" src="assets/js/jquery-2.2.0.min.js"></script>
<script type="text/javascript" src="assets/bootstrap/js/bootstrap.min.js"></script>
<jsp:include page="footer.jsp"/>
