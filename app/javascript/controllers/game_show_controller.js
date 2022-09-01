import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="game-show"
export default class extends Controller {
  static targets = ["red", "blue"];

  connect() {
    const redTeamFull = (document.querySelector(".team-red").dataset.redFull) === 'true';
    const blueTeamFull = (document.querySelector(".team-blue").dataset.blueFull) === 'true';

    if (redTeamFull) this.redTarget.insertAdjacentHTML('beforeend', '<div class="btn-small team-full">Team Full</div>');
    if (blueTeamFull) this.blueTarget.innerHTML = '<div class="btn-small team-full">Team Full</div>';
  }
}
