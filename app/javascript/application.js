// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

document.getElementById("color_reset_1").addEventListener("click", function() {
    confirm("Вы точно хотите сбросить цвет?");
    let color_element = document.getElementById("color_field_1");

    color_element.value = color_element.getAttribute("data-default-value");
  });
