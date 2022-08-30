  import { Controller } from "@hotwired/stimulus"

  // Connects to data-controller="map"
  export default class extends Controller {
    static values = {
      playgrounds: Array
    }

    connect() {
      window.initMap = this.#initMap();
    }

    #initMap() {
      const playgrounds = JSON.parse(this.data.get("value"));

      const montreal = { lat: 45.51353867361984, lng: -73.64760642998415 };
      const map = new google.maps.Map(this.element, {
        zoom: 11,
        center: montreal,
        disableDefaultUI: true
      });

      const image = 'https://cdn-icons-png.flaticon.com/32/1041/1041168.png';

      playgrounds.forEach((playground) => {
        const playgroundLocation = { lat: playground.latitude, lng: playground.longitude };
        const marker = new google.maps.Marker({
          position: playgroundLocation,
          map: map,
          icon: image,
          url: `/playgrounds/${playground["id"]}`
        });

        let infowindow = new google.maps.InfoWindow({
          content: `<div class="infowindow"><a href="${marker.url}">${playground.name}</a></div>`
        });

        google.maps.event.addListener(marker, 'click', function() {
          infowindow.open(map,marker);
        });
      })
    }
  }
