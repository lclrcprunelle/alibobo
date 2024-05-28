import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="booking-form"
export default class extends Controller {
  static targets = [
    "price",
    "start",
    "end",
    "day",
    "totalPrice",
    "totalPriceInput",
  ];

  connect() {
    this.price = parseInt(this.priceTarget.dataset.price);
    console.log(this.price);
  }

  compute(evt) {
    if (this.startTarget.value === "" || this.endTarget.value === "") {
      return false;
    }

    const totalDays =
      (new Date(this.endTarget.value) - new Date(this.startTarget.value)) /
      60000 /
      1440;

    const totalPrice = totalDays * this.price;

    this.dayTarget.innerText =
      totalDays > 1 ? "Total days: " + totalDays : "Total day: " + totalDays;

    this.totalPriceInputTarget.value = totalPrice;
    this.totalPriceTarget.innerText = "Price: $" + totalPrice;
  }
}
