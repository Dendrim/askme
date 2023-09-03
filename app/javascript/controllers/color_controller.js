import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  static targets = [ "color_field" ]

  reset() {
    const element = this.color_fieldTarget;

    confirm("Вы точно хотите сбросить цвет?");
    element.value = element.getAttribute("data-default-value");
  }
}
