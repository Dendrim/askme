import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = {
    default: String
  }
  static targets = [ "colorField" ]

  reset() {
    const element = this.colorFieldTarget;
    confirm("Вы точно хотите сбросить цвет?");
    element.value = this.defaultValue;
  }
}
