// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//

//= require jquery3
//= require popper
//= require bootstrap-sprockets
//= require jquery-ui
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require preview
//= require comment
//= require affiliation
//= require filtering_search_youtube
//= require name_x
//= require modal_profile

$(document).on("turbolinks:load", function () {
  $("#name-setting").autocomplete({
    source: "/vtubers/autocomplete_names",
    minLength: 1,
  });

  $("#affiliation_name").autocomplete({
    source: "/vtubers/autocomplete_affiliations",
    minLength: 1,
  });

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

  document.querySelectorAll(".profile_setting_place").forEach((el) => {
    const selects = document.querySelectorAll('.profile_setting_place');

    selects.forEach(select => {
      const refreshStyle = () => {
        select.classList.remove('force-refresh');
        void select.offsetWidth;  // 再計算（再描画を強制）
        select.classList.add('force-refresh');
      };

      // イベント設定（同じ値を選んでも再発火）
      select.addEventListener('change', refreshStyle);
      select.addEventListener('click', refreshStyle);

      // 初回ロード時に強制リフレッシュを実行
      refreshStyle();
    });
  });
});