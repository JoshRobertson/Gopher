<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib  prefix = "c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.io.*, java.net.*,java.util.*"%>
<%-- Language Declaration and Resource Bundle --%>
<% 
  String lang = request.getParameter( "lang" );
  if(lang == null){ lang = "en";}
  ResourceBundle RB = ResourceBundle.getBundle("com.lang.i18n.text", new Locale(lang));
  String currentLang = lang.toUpperCase();
%> 

<%-- Variable Declarations --%>
<%! String welcome, login, browse, req, logout; %>

<%-- Variable Initializations --%>
<% 
  welcome = RB.getString("welcome"); 
  login = RB.getString("login"); 
  browse = RB.getString("browse"); 
  req = RB.getString("req"); 
  logout = RB.getString("logout"); 
%>

<!DOCTYPE html>
<html>
	<link href="assets/bootstrap/css/bootstrap.css" rel="stylesheet" type="text/css" >
	<script src="assets/js/jquery-2.2.0.min.js"></script>
	<script src="assets/bootstrap/js/bootstrap.js"></script>
	<link href="assets/css/main-style.css" rel="stylesheet" type="text/css">

	<body>
		
		<c:if test="loggedIn">
			<jsp:include page="widget.jsp"/>
		</c:if>
		
		<nav class="navbar navbar-default navbar-fixed-top nav-margin">
			<div class="container">
				<div class="navbar-header">
					<button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
			        	<span class="icon-bar"></span>
			        	<span class="icon-bar"></span>
			       	 	<span class="icon-bar"></span> 
      				</button>
      				<a class="navbar-brand" href="/?lang=<%=lang%>"><img class="img-align" src="/assets/img/blocklogo.png"></a>
    			</div>
    		
    			<div class="collapse navbar-collapse" id="myNavbar">	
					<ul class="nav navbar-nav navbar-right">
						<c:choose>
							<c:when test="${loggedIn}">
								<li><a href="/dashboard?lang=<%=lang%>"><%=welcome%>, ${userObject.getUsername()}</a></li>
							</c:when>
							<c:otherwise>
							<li><a href="/login?lang=<%=lang%>"><%=login%></a></li>
							</c:otherwise>
						</c:choose>
			            <li><a href="/browse?lang=<%=lang%>"><%=browse%></a></li>
			            <c:if test="${loggedIn}">
			            	<li><a href="/request?lang=<%=lang%>"><%=req%></a></li>
			            	<li><a href="/logout?lang=<%=lang%>"><%=logout%></a></li>
			            </c:if>
			            
			            <li><form class="navbar-form">
            				<select id="lang" name="lang" onchange="submit()">
            					<option><%=currentLang%></option>             				
                				<option value="en" ${language == 'en' ? 'selected' : ''}>English</option>
                				<option value="fr" ${language == 'fr' ? 'selected' : ''}>Français</option>
                				<option value="es" ${language == 'es' ? 'selected' : ''}>Español</option>
            				</select>
       				   </form></li>
			            
	        		</ul>
    			</div>
  			</div>
		</nav>
		<div class="container">