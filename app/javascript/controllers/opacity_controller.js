import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["number", "check"];

  connect() {
    console.log("hello");
  }

  change() {
    this.element.classList.toggle("transparent-card");
    this.numberTarget.classList.add("d-none");
    this.checkTarget.classList.remove("d-none");
    if (this.element.classList.contains("transparent-card")) {
      this.element.nextElementSibling.scrollIntoView({ behavior: "smooth" });
    }
  }

  hover() {
    if (!this.element.classList.contains("transparent-card")) {
      this.numberTarget.classList.toggle("d-none");
      this.checkTarget.classList.toggle("d-none");
    }
  }
}
