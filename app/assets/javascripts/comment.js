$(function () {
  $(document).on("click", ".comment-cancel-button", function () {
    const commentId = $(this).data('cancel-id');
    const target = document.querySelector(`#comment_${commentId}`);
    target.innerHTML = target.dataset.originalHtml;
  });
});

function clearTextarea() {
	var textareaForm = document.getElementById("comment-clear");
  textareaForm.value = '';
}