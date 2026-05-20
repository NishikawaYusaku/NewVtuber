$(document).on("turbolinks:load", function () {
  $("#name-setting").autocomplete({
    source: "/vtubers/autocomplete_names",
    minLength: 1
  });

  $("#affiliation_name").autocomplete({
    source: "/vtubers/autocomplete_affiliations",
    minLength: 1,
    appendTo: "#affiliation_autocomplete"
  });
});