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


document.addEventListener("turbo:load", () => {

    const admissionsTab = document.getElementById("admissions-tab");
    const paymentsTab = document.getElementById("payments-tab");

    const admissionsContent = document.getElementById("admissions-content");
    const paymentsContent = document.getElementById("payments-content");

    if (!admissionsTab || !paymentsTab) return;

    admissionsTab.addEventListener("click", () => {

        admissionsTab.classList.add("active");
        paymentsTab.classList.remove("active");

        admissionsContent.style.display = "block";
        paymentsContent.style.display = "none";

    });

    paymentsTab.addEventListener("click", () => {

        paymentsTab.classList.add("active");
        admissionsTab.classList.remove("active");

        paymentsContent.style.display = "block";
        admissionsContent.style.display = "none";

    });

});


document.addEventListener("turbo:load", () => {

    const dateElement = document.getElementById("current-date");
    const timeElement = document.getElementById("current-time");

    if (!dateElement || !timeElement) return;

    function updateDateTime() {

        const now = new Date();

        dateElement.textContent = now.toLocaleDateString("en-GB", {
            day: "2-digit",
            month: "short",
            year: "numeric"
        });

        timeElement.textContent = now.toLocaleTimeString("en-US", {
            hour: "2-digit",
            minute: "2-digit",
            second: "2-digit",
            hour12: true
        });

    }

    updateDateTime();

    setInterval(updateDateTime, 1000);

});