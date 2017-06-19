<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@ page import="java.io.*, java.net.*,java.util.*"%>

<%-- Language Declaration and Resource Bundle --%>
<% 
String lang = request.getParameter( "lang" );
if ( lang == null){ lang = "en";}
  ResourceBundle RB = ResourceBundle.getBundle("com.lang.i18n.text", new Locale(lang));
%> 

<%-- Variable Declarations --%>
<%! String gopher, blurb1, signin, signmeup, whatIs, blurb2, blurb3; %>

<%-- Variable Initializations --%>
<% 
gopher = RB.getString("gopher"); 
blurb1 = RB.getString("blurb1"); 
signin = RB.getString("signin"); 
signmeup = RB.getString("signmeup"); 
whatIs = RB.getString("whatIs"); 
blurb2 = RB.getString("blurb2"); 
blurb3 = RB.getString("blurb3"); 
%>

<jsp:include page="header.jsp"/>

<style>
	.what-is-gopher{
		border-top:1px solid gray;
		padding-top:40px;
	}
	.btn{
		border: 2px solid #FFFFFF;
		color: #989898;
		background-color:rgba(255,255,255,0.6); 		
	}
	.blacktext{
		color:black;
	}"WebContent/assets/css/main-style.css"
</style>	
		<div class="jumbotron text-center bg-teal">
			<div class="gopher homespacer">	
				<img src="assets/img/cute_gopher.png">		
				<div id="title-text" class="vert-align">			
	   				<div class="monty-font" ><strong><%=gopher %></strong></div> 
					<p><%=blurb1 %></p> 
					<form class="form-inline">
	   					<a href="/login"><button type="button" class="btn btn-outline btn-lg spacer"><%=signin %></button></a>
	   					<a href="/register"><button type="button" class="btn btn-outline btn-lg"><%=signmeup %></button></a>
	 				</form> 
	 			</div> 
	 		</div>  				
	   	</div>
 	
   	<div id='what-is-gopher' class="block-text vert-align container-fluid bg-white block-size fill blacktext"> 
 		<h2 class="text-center blacktext"><%=whatIs %> <span class="monty-font blacktext" style="font-size:60px;"><%=gopher%>?</span></h2>
 		<p class ="text-center blacktext" style="width: 960px;"> 
 		<%=blurb2 %><br /><br />
 		<%=blurb3 %>
 		</p>
	</div>
<jsp:include page="footer.jsp"/>