import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="playground"
export default class extends Controller {
  static target = ["location"]

  connect() {
    console.log("test");

    navigator.geolocation.getCurrentPosition(
      function(position) {
          var latLngA = new google.maps.LatLng(position.coords.latitude,position.coords.longitude);
          var latLngB = new google.maps.LatLng(40.778721618334295, -73.96648406982422);
          var distance = google.maps.geometry.encoding.computeDistanceBetween(latLngA, latLngB);
          alert(distance);//In metres
      },
      function() {
          alert("geolocation not supported!!");
      }
    );
  }
}
