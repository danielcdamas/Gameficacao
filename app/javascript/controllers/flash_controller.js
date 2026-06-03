import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.timeout = setTimeout(() => this.dismiss(), 4000)
  }

  dismiss() {
    this.element.style.transition = "opacity 0.3s, transform 0.3s"
    this.element.style.opacity = "0"
    this.element.style.transform = "translateX(1rem)"
    setTimeout(() => this.element.remove(), 300)
  }

  disconnect() {
    clearTimeout(this.timeout)
  }
}
