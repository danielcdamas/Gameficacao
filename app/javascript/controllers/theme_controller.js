import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.applyTheme()
  }

  applyTheme() {
    const html = document.documentElement
    const theme = html.dataset.theme || "dark"
    const color = html.dataset.color || "purple"

    if (theme === "dark") {
      html.classList.add("dark")
    } else {
      html.classList.remove("dark")
    }
  }
}
