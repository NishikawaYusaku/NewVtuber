document.addEventListener("turbolinks:load", function() {
  const affiliationIndividual = document.getElementById("affiliation_individual");
  const affiliationCompany = document.getElementById("affiliation_company");
  const affiliationNameField = document.getElementById("affiliation_name");

  // 今いるページが作成/編集でない場合（affiliationNameFieldはテキストボックスが非表示でも存在する）
  if (!affiliationNameField) {
    return;
  }

  // テキストボックスが空の場合、「企業（グループなど）」が選択されていない状態にする
  if (affiliationNameField.value === "") {
    affiliationCompany.checked = false;
  }
  
  // 「企業（グループなど）」が選択されている場合、テキストボックスを表示
  if (affiliationCompany.checked) {
    affiliationNameField.style.display = "block";
  } else {
    affiliationNameField.style.display = "none";
  }

  // 「企業（グループなど）」を選択した場合、テキストボックスを表示
  affiliationCompany.addEventListener("change", function() {
    affiliationNameField.value = "";
    affiliationNameField.style.display = "block";
    affiliationNameField.focus();
  });

  // 「個人」を選択した場合、テキストボックスを非表示にして値に「個人」を指定
  affiliationIndividual.addEventListener("change", function() {
    affiliationNameField.style.display = "none";
    affiliationNameField.value = "個人";
  });
});