$(document).on("turbolinks:load", function () {
  const modal = document.getElementById("notify-modal");

  if (modal) {
    modal.addEventListener("hidden.bs.modal", function () {
      sendReadRequest();
    });

    modal.addEventListener("click", function (e) {
      const link = e.target.closest("a");
      if (link) {
        sendReadRequest();
      }
    });
  }

  function sendReadRequest() {
    fetch("/notifications/mark_as_read", {
      method: "POST",
      headers: {
        "X-CSRF-Token": document.querySelector("[name='csrf-token']").content,
        "Content-Type": "application/json"
      },
      body: JSON.stringify({})
    });
  }
});