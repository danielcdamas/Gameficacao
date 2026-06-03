import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["difficulty", "difficultyBtn", "difficultyLabel"]

  selectDifficulty(event) {
    const btn = event.currentTarget
    const difficulty = btn.dataset.difficulty
    const label = btn.dataset.label

    this.difficultyTarget.value = difficulty
    if (this.hasDifficultyLabelTarget) {
      this.difficultyLabelTarget.textContent = label
    }
  }
}
