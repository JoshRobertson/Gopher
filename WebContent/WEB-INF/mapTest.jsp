<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title>Simple Map</title>
    <meta name="viewport" content="initial-scale=0.5">
    <meta charset="utf-8">
    <style>
      html, body {
        height: 100%;
        margin: 0;
        padding: 0;
      }
      #map {
        height: 100%;
      }
      
      #smaller {
      	height: 500px;
      	width:500px;
      }
      
      .map {
      	height:500px;
      	width:500px;
      }
      
    </style>
  </head>
<body>
	<button onclick="addMapDiv()">AddMap</button>
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCpiQxT9pbyX3_zs4M1CTRCZFprNwOw7Gg&callback=addMap" async defer></script>
    <script src="assets/js/jquery-2.2.0.min.js"></script>
    <script type="text/javascript">
	//Global Variables
	var numTasks = 0;
	var startPos;
	
	window.onload = function() {
		  startPos;
		  var geoSuccess = function(position) {
		    startPos = position;
		  };
		  
		  var geoFailure = function(position) {
			startPos = {coords: {latitude: 45.4165703, longitude:-75.7047006}};
		  }
		  navigator.geolocation.getCurrentPosition(geoSuccess, geoFailure);
	};
	
	function addMapDiv() {
		numTasks++;
		
		var body = document.getElementsByTagName("body")[0];
		var smallerDiv = document.createElement("div");
		var mapDiv = document.createElement("div");
		var span = document.createElement("span");
		span.setAttribute("value", "MapThing");
		
		smallerDiv.setAttribute("id", "smaller");
		mapDiv.setAttribute("id", "map" + numTasks);
		mapDiv.setAttribute("class", "map");
		smallerDiv.appendChild(span);
		smallerDiv.appendChild(mapDiv);
		body.appendChild(smallerDiv);
		
	    addMap('map'+numTasks);
	}
	
	function removeTaskTab() {
		if(numTasks > 1) {
			$("#task" + numTasks + "li").remove();
			$("#task" + numTasks + "div").remove();
			numTasks--;
		}
	}
	
	function addMap(mapElement) {
		//var geocoder = new google.maps.Geocoder();
		
		var map = new google.maps.Map(document.getElementById(mapElement), {
			center: {lat: 45.4165703, lng: -75.7047006},
			zoom: 15,
		});
		
		//mapsArray[numTasks] = map;
	}
	
	
	
	</script>
  </body>
</html>