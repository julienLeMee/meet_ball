import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="map"
export default class extends Controller {
  static values = {
    playgrounds: Array
  }

  connect() {
    window.initMap = this.#initMap();
  }

  // Initialize and add the map
  #initMap() {
    const playgrounds = JSON.parse(this.data.get("value"));

    const montreal = { lat: 45.5050700377646, lng: -73.57248431277986 };
    const map = new google.maps.Map(this.element, {
      zoom: 10,
      center: montreal,
      disableDefaultUI: true
    });

    playgrounds.forEach((playground) => {
      const playgroundLocation = { lat: playground.latitude, lng: playground.longitude };
      new google.maps.Marker({
        position: playgroundLocation,
        map: map,
      });
    })
  }
}
