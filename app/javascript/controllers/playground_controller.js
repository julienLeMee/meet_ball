import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="playground"
export default class extends Controller {
  static targets = ["location"]
  static values = {
    latitude: Number,
    longitude: Number
  }

  connect() {
    const location = this.locationTarget;
    const latitude = this.latitudeValue;
    const longitude = this.longitudeValue;

    navigator.geolocation.getCurrentPosition(
      function(position) {
        const origin = { 'lat': position.coords.latitude, 'lng': position.coords.longitude};
        const destination = { 'lat': latitude, 'lng': longitude};

        const request = {
          origins: [origin],
          destinations: [destination],
          travelMode: 'DRIVING'
        };

        const service = new google.maps.DistanceMatrixService();
        service.getDistanceMatrix(request)
          .then((data) => {
            location.innerText = `${data['rows'][0]['elements'][0]['distance']['text']} away`;
          }
        );
      }
    );
  }
}
