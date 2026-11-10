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
        <img src="${src}" class="mt-3 setting-vtuber-icon">
        <div class="mt-3">
          <button type="button" class="btn btn-delete" data-bs-toggle="modal" data-bs-target="#delete_vicon">アイコン削除</button>
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