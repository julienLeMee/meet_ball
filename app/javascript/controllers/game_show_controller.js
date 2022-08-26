import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="game-show"
export default class extends Controller {
  connect() {
    console.log("test");
  }
}
