import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["menu"]

  connect() {
    this.boundClose = this.closeOnOutsideClick.bind(this)
  }

  toggle() {
    const isHidden = this.menuTarget.classList.contains("hidden")
    this.closeAllDropdowns()
    if (isHidden) {
      this.menuTarget.classList.remove("hidden")
      document.addEventListener("click", this.boundClose)
    }
  }

  close() {
    this.menuTarget.classList.add("hidden")
    document.removeEventListener("click", this.boundClose)
  }

  closeOnOutsideClick(event) {
    if (!this.element.contains(event.target)) {
      this.close()
    }
  }

  closeAllDropdowns() {
    document.querySelectorAll("[data-controller~='dropdown']").forEach(el => {
      if (el !== this.element) {
        const menu = el.querySelector("[data-dropdown-target='menu']")
        if (menu) menu.classList.add("hidden")
      }
    })
  }

  disconnect() {
    document.removeEventListener("click", this.boundClose)
  }
}
