<script src="//code.jquery.com/jquery-1.10.2.js" type="text/javascript"></script>
<script src="//code.jquery.com/ui/1.11.4/jquery-ui.js" type="text/javascript"></script>
<%@page import="entities.User" %>
<%@ taglib  prefix = "c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page import="java.io.*, java.net.*,java.util.*"%>

<%-- Language Declaration and Resource Bundle --%>
<% 
String lang = request.getParameter( "lang" );
if ( lang == null){ lang = "en";}
  ResourceBundle RB = ResourceBundle.getBundle("com.lang.i18n.text", new Locale(lang));
%> 

<%-- Variable Declarations --%>
<%! String settings, alerts, endorsements, messages; %>

<%-- Variable Initializations --%>
<% 
settings = RB.getString("settings"); 
alerts = RB.getString("alerts"); 
endorsements = RB.getString("endorsements"); 
messages = RB.getString("messages"); 
%>

<script type="text/javascript">
	$(function() {
		$(".draggable").draggable();
	});
</script>

<div id="profile-widget" class="text-center draggable">
	
	<!-- Hack for demo to show profile pic for Skye only -->
	<c:if test="${userObject.getId() == 102}">
    	<img class="img-circle profile-img" src="assets/img/profile_img.jpg"
		height="100" width="100" alt="">
    </c:if>
    <c:if test="${userObject.getId() != 102}">
    	<img class="img-circle profile-img" src="assets/img/cute_gopher.png"
		height="100" width="100" alt="">
    </c:if>	
    
	<div class="btn-group" id="profile-wdiget-button-container"
		role="group">
		<button type="button" class="btn btn-default btn-xs"
			aria-label="Settings">
			<span class="glyphicon glyphicon-cog" data-toggle="tooltip"
				title=<%=settings %>></span>
		</button>
		<button type="button" class="btn btn-default btn-xs"
			aria-label="Notifications">
			<span class="glyphicon glyphicon-bell" data-toggle="tooltip"
				title=<%=alerts %>></span>
		</button>
		<button type="button" class="btn btn-default btn-xs"
			aria-label="Notifications">
			<span class="glyphicon glyphicon-heart" data-toggle="tooltip"
				title=<%=endorsements %>></span>
		</button>
		<button type="button" class="btn btn-default btn-xs"
			aria-label="Notifications">
			<span class="glyphicon glyphicon-inbox" data-toggle="tooltip"
				title=<%=messages %>></span>
		</button>
	</div>
</div>