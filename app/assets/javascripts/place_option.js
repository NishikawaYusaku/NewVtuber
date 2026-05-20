$(document).on("turbolinks:load", function () {
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