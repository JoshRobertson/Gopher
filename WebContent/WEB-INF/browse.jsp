<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="entities.Errand"%>
<%@page import="daos.ErrandDao"%>
<%@page import="entities.Task"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ page import="java.io.*, java.net.*,java.util.*"%>

<%-- Language Declaration and Resource Bundle --%>
<% 
  String lang = request.getParameter( "lang" );
  if ( lang == null){ lang = "en";}
  ResourceBundle RB = ResourceBundle.getBundle("com.lang.i18n.text", new Locale(lang));
%>

<%-- Variable Declarations --%>
<%! String reviews; %>

<%-- Variable Initializations --%>
<% 
  reviews = RB.getString("reviews"); 
%>

<jsp:include page="header.jsp" />

<style>
.pad-me-please {
	padding: 50px;
}

.product-tombstone {
	min-height: 300px;
	max-height: 300px;
	margin: 25px 0 0 0;
}

.product-thumbnail {
	max-height: 300px;
	min-height: 300px;
}

#product-wrapper {
	min-height: 250px;
	max-height: 250px;
}

.pull-bottom {
	position: relative;
}

.jumbotron p {
	font-size: 16px;
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

.tab-pane {
	overflow: hidden !important;
}
</style>
<!-- 		<div class="bg-teal pad-nav-bar">
		</div> -->
<div class="bg-white">
	<div id="product-wrapper " class="row bg-teal jumbotron pad-me-please">
		<div class="dashboard-nav">
			<ul class="nav nav-tabs">
				<li class="active"><a data-toggle="tab" href="#top-errands">Latest Errands</a></li>
				<li><a data-toggle="tab" href="#all-errands">All Errands</a></li>
				<li><a data-toggle="tab" href="#important-errands">High Priority Errands</a>
			</ul>
		</div>
		<div class="tab-content dashboard-content">
			<div id="top-errands" class="tab-pane fade in active table-responsive">
				<c:forEach items="${errandList}" var="errand">
					<div class="col-sm-4 col-lg-4 col-md-4 product-tombstone">
						<div class="thumbnail product-thumbnail">
							<img src="assets/img/gopher_small.png" alt="">
							<div class="caption" id="errand${errand.getId()}">
								<h4 class="pull-right">$
									${errand.getRewardId().getRewardValue()}</h4>
								<h4>
									<a href="/errand?id=${errand.getId() }" style="color: black;">${errand.getName()}</a>
								</h4>
								<p>${errand.getDateCreated() }</p>
							</div>
							<div class="ratings pull-bottom">
								<p class="pull-right">
									15 <!--TODO FIX THIS  -->
									<%=reviews%></p>
								<p>
									<span class="glyphicon glyphicon-star"></span> <span
										class="glyphicon glyphicon-star"></span> <span
										class="glyphicon glyphicon-star"></span> <span
										class="glyphicon glyphicon-star"></span> <span
										class="glyphicon glyphicon-star"></span>
								</p>
							</div>
						</div>
					</div>
				</c:forEach>
			</div>
			<div id="important-errands" class="tab-pane fade table-responsive">
				<c:forEach items="${importandErrands}" var="errand">
					<div class="col-sm-4 col-lg-4 col-md-4 product-tombstone">
						<div class="thumbnail product-thumbnail">
							<img src="assets/img/gopher_small.png" alt="">
							<div class="caption" id="errand${errand.getId()}">
								<h4 class="pull-right">$
									${errand.getRewardId().getRewardValue()}</h4>
								<h4>
									<a href="/errand?id=${errand.getId() }" style="color: black;">${errand.getName()}</a>
								</h4>
								<p>${errand.getDateCreated() }</p>
							</div>
							<div class="ratings pull-bottom">
								<p class="pull-right">
									15
									<%=reviews%></p>
								<p>
									<span class="glyphicon glyphicon-star"></span> <span
										class="glyphicon glyphicon-star"></span> <span
										class="glyphicon glyphicon-star"></span> <span
										class="glyphicon glyphicon-star"></span> <span
										class="glyphicon glyphicon-star"></span>
								</p>
							</div>
						</div>
					</div>
				</c:forEach>
			</div>
			<div id="all-errands" class="tab-pane fade table-responsive">
				<c:forEach items="${allErrands}" var="errand">
					<div class="col-sm-4 col-lg-4 col-md-4 product-tombstone">
						<div class="thumbnail product-thumbnail">
							<img src="assets/img/gopher_small.png" alt="">
							<div class="caption" id="errand${errand.getId()}">
								<h4 class="pull-right">$
									${errand.getRewardId().getRewardValue()}</h4>
								<h4>
									<a href="/errand?id=${errand.getId() }" style="color: black;">${errand.getName()}</a>
								</h4>
								<p>${errand.getDateCreated() }</p>
							</div>
							<div class="ratings pull-bottom">
								<p class="pull-right">
									15
									<%=reviews%></p>
								<p>
									<span class="glyphicon glyphicon-star"></span> <span
										class="glyphicon glyphicon-star"></span> <span
										class="glyphicon glyphicon-star"></span> <span
										class="glyphicon glyphicon-star"></span> <span
										class="glyphicon glyphicon-star"></span>
								</p>
							</div>
						</div>
					</div>
				</c:forEach>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript" src="assets/js/jquery-2.2.0.min.js"></script>
<script type="text/javascript"
	src="assets/bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$('.carousel').carousel({
			interval : 3000
		})
	});
</script>

<jsp:include page="footer.jsp" />