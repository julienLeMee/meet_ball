import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="playground"
export default class extends Controller {
  static targets = ["location"]
  static values = {
    latitude: Number,
    longitude: Number
  }

  connect() {
    const latitude = this.latitudeValue;
    const longitude = this.longitudeValue;

    navigator.geolocation.getCurrentPosition(
      function(position) {
        // var latLngA = new google.maps.LatLng(position.coords.latitude,position.coords.longitude);
        // var latLngB = new google.maps.LatLng(latitude, longitude);

        const origin = [position.coords.latitude, ,position.coords.longitude];
        const destination = [latitude, longitude];


        const url = `https://maps.googleapis.com/maps/api/distancematrix/json?destinations=${destination[0]},${destination[1]}&origins=${origin[0]},${origin[2]}&key=AIzaSyAJmqLvSNaQn_bhVPmN_gR82I8s5TyN8r0`;

        // console.log(url);

        const headers = {'Content-Type':'application/json',
                    'Access-Control-Allow-Origin':'http://localhost:3000/',
                    'Access-Control-Allow-Methods':'GET'};

        fetch(url,
          {
            method: 'GET',
            mode: 'no-cors',
            headers: headers
          }
          )
        .then((response) => {
          console.log(response);
          response.json()
        })
        .then((data) => {
          // console.log(data);
          // console.log(data.rows.elements.distance.text);
          this.locationTarget.innerText = data.rows.elements.distance.text;
        });

        // this.#MatrixAPI(origin, destination);

          // var distance = google.maps.geometry.encoding.computeDistanceBetween(latLngA, latLngB);
          // console.log(distance);
          // alert(distance);//In metres
          // this.locationTarget.innerText = distance;
      },
      function() {
          alert("geolocation not supported!!");
      }
    );
  }

  #MatrixAPI(origin, destination) {
    // const service = new google.maps.DistanceMatrixService(); // instantiate Distance Matrix service

    //   const matrixOptions = {
    //     origins: origin, // technician locations
    //     destinations: destination, // customer address
    //     unitSystem: google.maps.UnitSystem.IMPERIAL
    //   };
    //   // Call Distance Matrix service
    //   service.getDistanceMatrix(matrixOptions, callback);

    //   // Callback function used to process Distance Matrix response
    //   function callback(response, status) {
    //     if (status !== "OK") {
    //       alert("Error with distance matrix");
    //       return;
    //     }
    //     console.log(response);
    //   }

  }
}
