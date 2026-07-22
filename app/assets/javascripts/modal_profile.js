// Vプロフィール設定モーダルを開いた瞬間にテキストボックスをアクティブにするための処理を実施
document.addEventListener("turbolinks:load", () => {
  const modal = document.getElementById("exampleModal");
  const input = document.getElementById("name-setting");

  if (!modal || !input) return;

  modal.addEventListener("shown.bs.modal", () => {
    input.focus();
  });
});