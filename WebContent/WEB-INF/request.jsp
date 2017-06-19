<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib  prefix = "c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page import="java.io.*, java.net.*, java.util.*" %>

<%-- Language Declaration and Resource Bundle --%>
<% 
String lang = request.getParameter( "lang" );
  if ( lang == null){ lang = "en";}
  ResourceBundle RB = ResourceBundle.getBundle("com.lang.i18n.text", new Locale(lang));
%> 

<%-- Variable Declarations --%>
<%! String task, titleOfYourErrand, titleOfYourTask, enterADescriptionOfYourTask, enterADescriptionOfYourErrand, nameOfTheReward, enterADescriptionOfTheReward, estimateTheValueOfTheReward, requestAnErrand, enterErrandInformation, description, title, deadline, importance, veryLow, low, normal, high, veryHigh, enterRewardInformation, reward, rewardValue, enterTasksInformation, task1, addTask, removeLastTask, enterALocationForThisTask, addressLine1, addressLine2, city, province, country, postalCode, requestErrand;%>

<%-- Variable Initializations --%>
<%
	task=RB.getString("task");
	requestAnErrand=RB.getString("requestAnErrand");
	enterErrandInformation=RB.getString("enterErrandInformation");
	description=RB.getString("description");
	title=RB.getString("title");
	deadline=RB.getString("deadline");
	importance=RB.getString("importance");
	veryLow=RB.getString("veryLow");
	low=RB.getString("low");
	normal=RB.getString("normal");
	high=RB.getString("high");
	veryHigh=RB.getString("veryHigh");
	enterRewardInformation=RB.getString("enterRewardInformation");
	reward=RB.getString("reward");
	rewardValue=RB.getString("rewardValue");
	enterTasksInformation= RB.getString("enterTasksInformation");
	task1=RB.getString("task1");
	addTask=RB.getString("addTask");
	removeLastTask=RB.getString("removeLastTask");
	enterALocationForThisTask=RB.getString("enterALocationForThisTask");
	addressLine1=RB.getString("addressLine1");
	addressLine2=RB.getString("addressLine2");
	city=RB.getString("city");
	province=RB.getString("province");
	country=RB.getString("country");
	postalCode=RB.getString("postalCode");
	requestErrand=RB.getString("requestErrand");
	titleOfYourErrand=RB.getString("titleOfYourErrand");
	titleOfYourTask=RB.getString("titleOfYourTask");
	enterADescriptionOfYourTask=RB.getString("enterADescriptionOfYourTask");
	enterADescriptionOfYourErrand=RB.getString("enterADescriptionOfYourErrand");
	nameOfTheReward=RB.getString("nameOfTheReward");
	enterADescriptionOfTheReward=RB.getString("enterADescriptionOfTheReward");
	estimateTheValueOfTheReward=RB.getString("estimateTheValueOfTheReward");

%>

<style>
	.jumbotron h1 {
  		font-size: 36px !important;
	}
	
	.jumbotron  {
  		font-size: 14px !important;
  		margin-bottom: 0px !important;
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
	
	.request-nav a, a:hover {
		padding: 10px 15px;
		font-size: 16px;
		color: #555;
	}
		
	.request-nav {
		background-color:ghostwhite;
	}
	
	.request-content {
		border-style: solid;
		border-color: #ddd;
		border-width: 1px 1px 1px 1px;
		border-radius: 10px 10px 10px 10px;
		background-color: white;
		margin: 0px;
		padding: 20px;
		min-height: 400px;
	}
	
	.clearfix:after {
		visibility: hidden;
		display: block;
		font-size: 0;
		content: " ";
		clear: both;
		height: 0;
	}
	
	#tasks-container {
		padding: 10px;
	}
	
	#tasks-div {
		padding: 10px;
	}
	
	form h4 {
		margin-bottom: 20px;
		margin-top: 20px;
	}
	
	#tasks-div h5 {
		padding: 15px;
	}
	
	input, textarea {
		display: block;
		width: 50%;
		border: 2px solid #c7eaee;
		border-radius: 5px;
		margin: 8px 0 !important;
	}
	
	select {
		display: block;
		border: 2px solid #c7eaee;
		border-radius: 5px;
		margin: 8px 0 !important;
	}
	
	#subtasks button {
		background-color: white;
    	color: black;
    	border: 2px solid #c7eaee;
    	border-radius: 5px;
    	margin: 2px;
    	padding: 5px;
	}
	
	#subtasks button:hover {
    	background-color: #c7eaee;
    	color: white;
	}
	
	.map {
		height:300px;
		width:100%;
		margin: auto;
		padding: 20px;
	}
	
	.submitBtn {
		background-color: #c7eaee;
		width: 20%;
		padding: 10px;
		border: none;
		border-radius: 5px;
		margin-left: 35%;
    	margin-top: 20px;
	}
	

</style>
<head>
	<title>Request an Errand</title>
	<meta name="viewport" content="initial-scale=1.0">
</head>
<jsp:include page="header.jsp"/>
	
	<!-- Header -->
	<div class="container-fluid profile-header text-center jumbotron bg-teal">
	 	<div class="profile-header-img">
	 		<img class="img-circle" src="assets/img/cute_gopher.png" >		
		</div>
		<h1><%=requestAnErrand %></h1>
	</div>
	
	<!-- Begin form to add errand request -->
	<div class="request-content">
	
		<form id="addErrandForm" action="request" method="post">
			<h4><%=enterErrandInformation%>:</h4>
			<label class="col-md-3"><%=title%></label>
			<input type="text" name="errandName" placeholder="<%=titleOfYourErrand %>">
			<label class="col-md-3"><%=description %>:</label>
			<textarea rows="4" cols="50" name="errandDescription" placeholder="<%=enterADescriptionOfYourErrand %>"></textarea>
			<label class="col-md-3"><%=deadline %></label>
			<input type="datetime-local" name="deadline">
			<label class="col-md-3"><%=importance %>:</label>
			<select form="addErrandForm" name="importance">
  				<option value="1"><%=veryLow %></option>
  				<option value="2"><%=low %></option>
  				<option value="3" selected><%=normal %></option>
  				<option value="4"><%=high %></option>
  				<option value="5"><%=veryHigh %></option>
			</select>
			<h4><%=enterRewardInformation %></h4>
			<label class="col-md-3"><%=reward %></label>
			<input type="text" name="rewardName" placeholder="<%=nameOfTheReward%>">
			<label class="col-md-3"><%=description %></label>
			<textarea rows="4" cols="50" name="rewardDescription" placeholder="<%=enterADescriptionOfTheReward %>"></textarea>
			<label class="col-md-3"><%=rewardValue %></label>
			<input type="text" name="rewardValue" placeholder="<%=estimateTheValueOfTheReward%>">
			<input type="hidden" name="numTasks" value="1">			
		
			<!-- Section to add task(s) -->
			<h4><%=enterTasksInformation %></h4>
			<div id="tasks-container" class="clearfix">
				<div class="col-md-3">
					<ul class="nav nav-pills nav-stacked" id="tasks-list">
						<li class="active" id="task1li"><a data-toggle="tab" href="#task1div"><%=task1 %></a></li>
					</ul>
					<div id="subtasks">
				        <div><button type="button" id="add-task" onclick="addTaskTab()"><%=addTask %></button></div>
				        <div><button type="button" id="remove-task" onclick="removeTaskTab()"><%=removeLastTask %></button></div>	        	
				       </div>
				</div>
	        	<div class="col-md-9">
	        		<div id="tasks-div" class="tab-content">
		        		<div id="task1div" class="tab-pane fade in active table-responsive">
			        		<label class="col-md-3"><%=title %>:</label>
							<input type="text" name="taskName1" placeholder="<%=titleOfYourTask%>">
							<label class="col-md-3"><%=description %>:</label>
							<textarea rows="4" cols="50" name="taskDescription1" placeholder="<%=enterADescriptionOfYourTask%>"></textarea>
							<h5><%=enterALocationForThisTask %></h5>
							<label class="col-md-3"><%=addressLine1 %>:</label>
							<input type="text" name="addressLine1Task1">
							<label class="col-md-3"><%=addressLine2 %>:</label>
							<input type="text" name="addressLine2Task1">
							<label class="col-md-3"><%=city %>:</label>
							<input type="text" name="cityTask1">
							<label class="col-md-3"><%=province %>:</label>
							<input type="text" name="provinceTask1">
							<label class="col-md-3"><%=country %>:</label>
							<input type="text" name="countryTask1">
							<label class="col-md-3"><%=postalCode %>:</label>
							<input type="text" name="zipTask1">
							<input type="hidden" name="longitudeTask1">
							<input type="hidden" name="latitudeTask1">
							<div class="map" id="map1"></div>
						</div>
		        	</div>
		        </div>
	        </div>
	        
	        <button class="submitBtn" type="submit">Request Errand!</button>
	        
        </form>
	</div>
	
	
    
	<script src="https://maps.googleapis.com/maps/api/js?&callback=addMap&key=AIzaSyCpiQxT9pbyX3_zs4M1CTRCZFprNwOw7Gg" async defer></script>
	<script type="text/javascript">
	//Global Variables
	var numTasks = 1;
	var startPos = {coords: {latitude: 45.4165703, longitude: -75.7047006}};
	var mapArray = new Array(100);
	var markerArray = new Array(100);
	
	//Object creation function
	if(typeof Object.create !== 'function') {
		Object.create = function(o) {
			var F = function(o) {};
			F.prototype = o;
			return new F();
		};
	}
	
	var MapCanvas = {
		map: null,
		marker: null,
		name: null,
		
		setName: function(n) {
			this.name = n;
		},
		
		setMap: function(m) {
			this.map = m;
		}, 
		
		setMarkerLocation: function(position) {
			
			if(this.marker === null) {
				this.marker = new google.maps.Marker({
					position: position,
				    map: this.map,
				    draggable: false,
				});
			} else {
				this.marker.setPosition(position);
			}
			this.map.panTo(position);
		},
	};
	
	window.onload = function() {
		  
		  var geoSuccess = function(position) {
		    startPos = position;
		    addMap("map1");
		  };
		  
		  var geoFailure = function() {
			startPos = {coords: {latitude: 45.4165703, longitude: -75.7047006}};
			addMap("map1");
		  }
		  
		  navigator.geolocation.getCurrentPosition(geoSuccess, geoFailure);
	};
	
	function addTaskTab() {
		numTasks++;

	    $("#tasks-list").append('<li id="task'+ numTasks +'li"><a data-toggle="tab" href="#task' + numTasks + 'div"><%=task %> '+ numTasks+'</a></li>');     // Append new elements
		$("#tasks-div").append(
				'<div id="task' + numTasks + 'div" class="tab-pane fade table-responsive">' +
				'<label class="col-md-3"><%=title %>:</label>' +
				'<input type="text" name="taskName'+numTasks+'" placeholder="<%=titleOfYourTask%>">'+
				'<label class="col-md-3"><%=description %>:</label>'+
				'<textarea rows="4" cols="50" name="taskDescription'+numTasks+'" placeholder="<%=enterADescriptionOfYourTask %>."></textarea>'+
				'<h5><%=enterALocationForThisTask%>:</h5>'+
				'<label class="col-md-3"><%=addressLine1 %>:</label>'+
				'<input type="text" name="addressLine1Task'+numTasks+'">'+
				'<label class="col-md-3"><%=addressLine2 %>:</label>'+
				'<input type="text" name="addressLine2Task'+numTasks+'">'+
				'<label class="col-md-3"><%=city%>:</label>'+
				'<input type="text" name="cityTask'+numTasks+'">'+
				'<label class="col-md-3"><%=province%>:</label>'+
				'<input type="text" name="provinceTask'+numTasks+'">'+
				'<label class="col-md-3"><%=country %>:</label>'+
				'<input type="text" name="countryTask'+numTasks+'">'+
				'<label class="col-md-3"><%=postalCode%>:</label>'+
				'<input type="text" name="zipTask'+numTasks+'">'+
				'<input type="hidden" name="longitudeTask'+numTasks+'">'+
				'<input type="hidden" name="latitudeTask'+numTasks+'">'+
			'<div class="map" id="map' + numTasks +'"></div></div>');
	    
	    addMap("map"+numTasks);
	    
	    google.maps.event.trigger(mapArray['map'+numTasks].map, 'resize');
	    
	    $('a[href="#task'+numTasks+'div"]').on('shown.bs.tab', function(e) {
	        google.maps.event.trigger(mapArray['map'+numTasks].map, 'resize');
	    });
	    
	    $('a[href="#task'+numTasks+'div"]').tab('show');
	    
	    $('input[name="numTasks"]').val(numTasks);
	}
	
	function removeTaskTab() {
		if(numTasks > 1) {
			$("#task" + numTasks + "li").remove();
			$("#task" + numTasks + "div").remove();
			
			mapArray['map'+numTasks] = null;
			
			numTasks--;
			
			$('input[name="numTasks"]').val(numTasks);
		}
	}
	
	function addMap(mapElement) {
		
		var map = new google.maps.Map(document.getElementById(mapElement), {
			center: {lat: startPos.coords.latitude, lng: startPos.coords.longitude},
			zoom: 15,
		});
		
		map.name = mapElement;
					
		m = Object.create(MapCanvas);
		m.setName(mapElement);
		m.setMap(map);
		
		mapArray[mapElement] = m;
		
		map.addListener('click', function(e) {
			mapArray[this.name].setMarkerLocation(e.latLng);
			
			var geocoder = new google.maps.Geocoder;
			
			var that = this;
			
			geocoder.geocode({'location':e.latLng}, function(results, status) {
				if(status === google.maps.GeocoderStatus.OK) {
					if(results[0]) {
						
						//reset all form info to empty
						$('input[name="addressLine1Task' + that.name.substring(3, that.name.length) + '"]').val("");
						$('input[name="addressLine2Task' + that.name.substring(3, that.name.length) + '"]').val("");
						$('input[name="cityTask' + that.name.substring(3, that.name.length) + '"]').val("");
						$('input[name="provinceTask' + that.name.substring(3, that.name.length) + '"]').val("");
						$('input[name="countryTask' + that.name.substring(3, that.name.length) + '"]').val("");
						$('input[name="zipTask' + that.name.substring(3, that.name.length) + '"]').val("");
						
						for(i = 0; i < results[0]["address_components"].length; ++i) {
							
							switch(results[0]["address_components"][i]["types"][0]) {
								case "street_number":
									$('input[name="addressLine1Task' + that.name.substring(3, that.name.length) + '"]').val(results[0]["address_components"][i]["long_name"]);
									break;
								case "route":
									$('input[name="addressLine1Task' + that.name.substring(3, that.name.length) + '"]').val(
											$('input[name="addressLine1Task' + that.name.substring(3, that.name.length) + '"]').val() + " " +
											results[0]["address_components"][i]["long_name"]
											
									);
									break;
								case "locality":
									$('input[name="cityTask' + that.name.substring(3, that.name.length) + '"]').val(results[0]["address_components"][i]["long_name"]);
									break;
								case "administrative_area_level_1":
									$('input[name="provinceTask' + that.name.substring(3, that.name.length) + '"]').val(results[0]["address_components"][i]["long_name"]);
									break;
								case "country":
									$('input[name="countryTask' + that.name.substring(3, that.name.length) + '"]').val(results[0]["address_components"][i]["long_name"]);
									break;
								case "postal_code":
									$('input[name="zipTask' + that.name.substring(3, that.name.length) + '"]').val(results[0]["address_components"][i]["long_name"]);
									break;
							}
						}
					}
				}
			});
			
			$('input[name="latitudeTask' + that.name.substring(3, that.name.length) + '"]').val(e.latLng.lat);
			$('input[name="longitudeTask' + that.name.substring(3, that.name.length) + '"]').val(e.latLng.lng);
		});
		
	}
	
	</script>
	
<jsp:include page="footer.jsp"/>
