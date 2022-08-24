import { Controller } from "@hotwired/stimulus"
import TomSelect from "tom-select";

// Connects to data-controller="game-form"
export default class extends Controller {
  connect() {
    new TomSelect(this.element, {});
  }
}
