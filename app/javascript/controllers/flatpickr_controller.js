import { Controller } from "@hotwired/stimulus";
import flatpickr from 'flatpickr';

export default class extends Controller {
  connect() {
    this.initFlatpickr();
  }

  initFlatpickr() {
    const fp = flatpickr('#start_date', {
      minDate: 'today',
      altInput: true,
      altFormat: "F j, Y, H:i",
      enableTime: true,
      time_24hr: true,
      dateFormat: "Y-m-d H:i"
    });
  }
}
