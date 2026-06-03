import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { leveledUp: Boolean }

  connect() {
    if (this.leveledUpValue) {
      this.element.classList.add("leveled-up")
    }
    this.timeout = setTimeout(() => this.dismiss(), 3000)
  }

  dismiss() {
    this.element.style.transition = "opacity 0.4s, transform 0.4s"
    this.element.style.opacity = "0"
    this.element.style.transform = "translateY(1rem)"
    setTimeout(() => {
      if (this.element && this.element.parentNode) {
        this.element.innerHTML = ""
      }
    }, 400)
  }

  disconnect() {
    clearTimeout(this.timeout)
  }
}
