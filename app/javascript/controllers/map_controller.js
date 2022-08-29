import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="map"
export default class extends Controller {
  connect() {
    window.initMap = this.#initMap();
  }

  // Initialize and add the map
  #initMap() {
    // The location of Uluru
    const montreal = { lat: 45.5050700377646, lng: -73.57248431277986 };
    // The map, centered at Montreal
    const map = new google.maps.Map(this.element, {
      zoom: 10,
      center: montreal,
    });
    // The marker, positioned at Uluru
    const marker = new google.maps.Marker({
      position: montreal,
      map: map,
    });
  }
}
