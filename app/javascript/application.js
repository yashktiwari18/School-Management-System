// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"


document.addEventListener("turbo:load", () => {
  const passwordField = document.getElementById("password-field");
  const togglePassword = document.getElementById("toggle-password");

  if (!passwordField || !togglePassword) return;

  togglePassword.addEventListener("click", () => {
    if (passwordField.type === "password") {
      passwordField.type = "text";
      icon.classList.remove("bi-eye-slash");
      icon.classList.add("bi-eye");
    } else {
      passwordField.type = "password";
      icon.classList.remove("bi-eye");
      icon.classList.add("bi-eye-slash");
    }
  });
});