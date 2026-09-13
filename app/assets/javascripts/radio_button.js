document.addEventListener("turbolinks:load", function() {
  let selected_radio_button = {}
  const affiliationCompany = document.getElementById("affiliation_company");
  const affiliationNameField = document.getElementById("affiliation_name");

  Array.from(document.getElementsByClassName("profile_radio_button")).forEach((e) => {
    e.addEventListener("click", (e) => {
      if (selected_radio_button[e.target.name] == e.target) {
        if (affiliationCompany && affiliationCompany.checked) {
          affiliationNameField.value = "";
          affiliationNameField.style.display = "none";
        }
        e.target.checked = false;
        selected_radio_button[e.target.name] = null
      } else {
        selected_radio_button[e.target.name] = e.target
      }
    })
  })
});