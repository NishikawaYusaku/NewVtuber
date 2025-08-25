document.addEventListener('DOMContentLoaded', function(){
  const profileForm = document.getElementById('content_setting');
  if (!profileForm) return null;
  
  const fileField = document.getElementById('vtuber_image');
  fileField.addEventListener('change', function(e){
    const src = window.URL.createObjectURL(e.target.files[0]);

    const previewImage = document.querySelector('.preview_image');
    if (previewImage) {
      previewImage.innerHTML = '';
      previewImage.insertAdjacentHTML("beforeend", `
        <img src="${src}" class="preview mt-3 rounded-circle border border-dark" width="250" height="250">
        <div class="ms-3 mt-2">
          <button type="button" class="btn btn-setting ms-5 remove_image_btn">アイコン削除</button>
        </div>
      `);
    }
    
    const removeImage = document.getElementById('remove_image');
    if (removeImage) removeImage.value = "";
  });

  document.addEventListener('click', function(e) {
    if (e.target.classList.contains('remove_image_btn')) {
      document.getElementById('vtuber_image').value = '';
      document.getElementById('remove_image').value = '1';
      document.querySelector('.preview_image').innerHTML = '';
    }
  });
});