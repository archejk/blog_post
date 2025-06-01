import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    console.log("Feedback form controller connected")
  }

  submit(event) {
    const button = event.target.querySelector('input[type="submit"]');
    if (!button) return;

    const originalText = button.value;
    button.value = "Sending...";
    button.disabled = true;
  }
}