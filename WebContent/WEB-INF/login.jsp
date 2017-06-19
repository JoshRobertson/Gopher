<%-- <%@page import="utils.Login"%>
<%@page import="models.User"%> --%>
<%-- <%@page import="servlets.LoginServlet" %> --%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib  prefix = "c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.io.*, java.net.*,java.util.*"%>

<%-- Language Declaration and Resource Bundle --%>
<% 
  String lang = request.getParameter( "lang" );
  if ( lang == null){ lang = "en";}
  ResourceBundle RB = ResourceBundle.getBundle("com.lang.i18n.text", new Locale(lang));
%> 

<%-- Variable Declarations --%>
<%! String signin, email, password, password_ph; %>

<%-- Variable Initializations --%>
<% 
  signin = RB.getString("signin"); 
  email = RB.getString("email"); 
  password = RB.getString("password"); 
  password_ph = RB.getString("password_ph"); 
%>

<style>	
	#login-form{
		padding: 20px 0px;
		margin: 0 auto;
		text-align: center;
	}
	
	#login-form h2 {
		margin: 20px;	
	}
	
	#login-form input{
		margin:20px auto;
		margin-top:0px;
		height:40px;
		width:350px;
	}	
</style>

<jsp:include page="header.jsp"/>
		<div class="bg-teal jumbotron pad-nav-bar">
			<img class="img-responsive" style="margin:auto;padding:20px 0px;" src="assets/img/cute_gopher.png"></img>
		</div>
		<div class="bg-white">
	    	<form class="block-display" id="login-form" action="login" method="post">
				<h2 class="monty-font"><%=signin%></h2>
			 	<input class="block-display form-control" type="text" placeholder=<%=email%> name="email"  value="${email}"/>
			 	<c:remove var="email"/>
			 	<input class="block-display form-control" type="password" placeholder=<%=password_ph%> name="password" />
			 	<button class="btn btn-default bg-grey" type="submit"><%=signin%></button>
			 	<c:if test="${error != null}">
			 		<div class="block-display bg-teal" style="margin-top: 20px;"><p class="block-display">${error}</p></div>
			 		<c:remove var="error"/>
			 	</c:if>
			</form>
		</div>
<jsp:include page="footer.jsp"/>