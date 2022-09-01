import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="game-form"
export default class extends Controller {
  static targets = ["game-mode"];

  connect() {
    console.log("test");

    const gameModes = document.querySelectorAll('.game-mode-select');
    const teamSizes = document.querySelectorAll('.team-size-select');

    gameModes.forEach((gameMode) => {
      gameMode.addEventListener('change', (event) => {
        gameModes.forEach((gameMode) => {
          gameMode.parentNode.classList.remove('active');
        });
        event.target.parentNode.classList.add('active');
      })
    });

    teamSizes.forEach((teamSize) => {
      teamSize.addEventListener('change', (event) => {
        teamSizes.forEach((teamSize) => {
          console.dir(teamSize);
          teamSize.nextElementSibling.classList.remove('active');
        });
        event.target.nextElementSibling.classList.add('active');
      })
    });
  }
}
