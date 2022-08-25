import { Controller } from "@hotwired/stimulus"
import TomSelect from "tom-select";

// Connects to data-controller="game-form"
export default class extends Controller {
  connect() {
    const select = new TomSelect(this.element, {});
    select.settings.placeholder = "Search or select a playground";
    select.inputState();
  }
}
