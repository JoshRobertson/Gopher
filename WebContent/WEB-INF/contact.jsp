<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib  prefix = "c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page import="java.io.*, java.net.*,java.util.*"%>

<%-- Language Declaration and Resource Bundle --%>
<% 
  String lang = request.getParameter( "lang" );
  if ( lang == null){ lang = "en";}
  ResourceBundle RB = ResourceBundle.getBundle("com.lang.i18n.text", new Locale(lang));
%> 

<%-- Variable Declarations --%>
<%! String contact, email, name, message, submit; %>

<%-- Variable Initializations --%>
<% 
  contact = RB.getString("contact"); 
  email = RB.getString("email"); 
  name =  RB.getString("name"); 
  message = RB.getString("message"); 
  submit = RB.getString("submit"); 
%>

<t:main>
	<jsp:body>
	<div class="row">
		<div class="col-md-4"></div>
		<div class="form-contact col-sm-4">
	        
		</div>
		<div class="col-md-4"></div>
    </div>
	<div class="row">
		<div class="col-md-4"></div>
		<div class="form-signin col-sm-4">
			<img class="img-responsive" style="margin:auto;" src="assets/img/cute_gopher.png"></img>
	        <form class="form-contact">
				<h2 class="form-signin-heading">Contact the Gopher Team</h2>
				<input type="text" id ="name" class="form-control" placeholder="name" required>
				<input type="text" id ="email" class="form-control" placeholder="Email" required>
				<textarea id="message"class="form-control" rows="8" placeholder="Message"></textarea>
				<br/>
				<button class="btn btn-lg btn-primary btn-block" type="submit">Submit</button>
			</form>
		</div>
		<div class="col-sm-4"></div>
    </div>
    </jsp:body>
</t:main>