<!DOCTYPE html>
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
<%! String join, gopher, today, username, email, password, confirmpass, signmeup; %>

<%-- Variable Initializations --%>
<% 
  join = RB.getString("join"); 
  gopher = RB.getString("gopher"); 
  today = RB.getString("today"); 
  username = RB.getString("username"); 
  email = RB.getString("email"); 
  password = RB.getString("password");
  confirmpass = RB.getString("confirmpass"); 
  signmeup = RB.getString("signmeup");
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
	<div class="bg-teal pad-nav-bar jumbotron">
		<form class="block-display" id="login-form" method="post" action="register">
			 <h2><%=join%> <span class="monty-font"><%=gopher%></span> <%=today%>.</h2>
			 <label><%=username%></label>
			 <input class="block-display form-control" type="text" name="username" value="${username}">
			 <c:remove var="username"/>
			 <label><%=email%></label>
			 <input class="block-display form-control" type="email" name="email" value="${email}"/>
			 <c:remove var="email"/>
			 <label><%=password%></label>
			 <input class="block-display form-control" type="password" name="password"/>
			 <label><%=confirmpass%></label>
			 <input class="block-display form-control" type="password" name="passwordConfirm"/>
			 <button class="btn btn-default"><%=signmeup%></button>
		</form>
	</div>
	
	<c:if test="${errorList != null}">
		<div class="block-display bg-teal" style="margin-top: 20px;">
			<ul class="block-display">
			<c:forEach items="${errorList}" var="error">
				<li>${error}</li>
			</c:forEach>
			</ul>
		</div>
 		<c:remove var="errorList"/>
	</c:if>
	
	<div class="bg-white fill">
		<div style="width:200px;text-align:center;margin:0 auto;padding-top:20px">
			<img width="200px" src="/assets/img/logo.gif" />
		</div>
	</div>
<jsp:include page="footer.jsp"/>