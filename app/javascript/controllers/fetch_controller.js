import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["form"];

  perform(event) {
    event.preventDefault();

    fetch(this.formTarget.action, {
      method: this.formTarget.method,
      body: new FormData(this.formTarget),
    }).then((response) => {
      if (response.status === 200) {
        // If the response status is 200, follow the redirect
        window.location.href = response.url;
      } else if (response.status === 422) {
        // If the response status is 422, change the innerHTML
        return response.text().then((html) => {
          this.element.innerHTML = html;
        });
      } else {
        // Handle other statuses or errors if necessary
        console.error("Unexpected status code:", response.status);
      }
    });
  }
}
