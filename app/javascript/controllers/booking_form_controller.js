import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="booking-form"
export default class extends Controller {
  static targets = ["price", "start", "end"];

  connect() {
    console.log(parseInt(this.priceTarget.dataset.price));
    console.log(this.startTarget);
  }

  totalPrice() {}
}
