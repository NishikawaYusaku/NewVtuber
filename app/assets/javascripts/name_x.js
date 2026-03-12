document.addEventListener("turbolinks:load", function() {
  const name_x = document.getElementById("name_x");
  if(!name_x) return;

  name_x.addEventListener("change", function() {
    name_x.value = name_x.value.replaceAll(/[@＠]/g, "")
  });
});