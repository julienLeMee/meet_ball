import { Controller } from "@hotwired/stimulus";
import flatpickr from 'flatpickr';
import 'flatpickr/dist/themes/dark.css';


export default class extends Controller {
  // initialize() {
  //   console.log("flatpickr")
  //   this.config = {
  //     enableTime: true,
  //     dateFormat: 'Y-m-d',
  //   }

  // }
  connect() {
    this.initFlatpickr();
    console.log("connected")
    console.log(this.element)
  }

  initFlatpickr() {
    console.log("from init")
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
