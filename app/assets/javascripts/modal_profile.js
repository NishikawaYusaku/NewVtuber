// Vプロフィール設定モーダルを開いた瞬間にテキストボックスをアクティブにするための処理を実施
document.addEventListener("turbolinks:load", () => {
  const modal = document.getElementById("exampleModal");
  const input = document.getElementById("name-setting");
  const vtuber_profile = document.getElementById('vtuber_profile');

  if (!modal || !input) return;

  modal.addEventListener("shown.bs.modal", () => {
    input.focus();
  });

  modal.addEventListener("hidden.bs.modal", () => {
    if (!vtuber_profile) input.value = '';
  });
});