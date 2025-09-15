document.addEventListener("turbolinks:load", () => {
  const youtubeFields = document.getElementById("filtering_search_youtube");
  if (!youtubeFields) return;

  const radios = document.querySelectorAll('input[name="q[places_name_eq]"]');

  function toggleYoutubeFields() {
    const selected = document.querySelector('input[name="q[places_name_eq]"]:checked');
    if (selected && selected.value === "YouTube") {
      youtubeFields.style.display = "block";
    } else {
      youtubeFields.style.display = "none";
      youtubeFields.querySelectorAll("input").forEach(input => input.value = "");
    }
  }

  radios.forEach(radio => {
    radio.addEventListener("change", toggleYoutubeFields);
  });
  
  toggleYoutubeFields();
});