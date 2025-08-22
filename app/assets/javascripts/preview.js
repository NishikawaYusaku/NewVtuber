document.addEventListener('DOMContentLoaded', function(){
  const createForm = document.getElementById('content_setting');
  if (!createForm) return null;
  
  const fileField = document.querySelector('input[type="file"][name="vtuber[image]"]');
  
  fileField.addEventListener('change', function(e){
    const currentImage = document.getElementById('current_image');
    if (currentImage) currentImage.remove();

    const alreadyPreview = document.querySelector('.preview');
    if (alreadyPreview) alreadyPreview.remove();
    
    const previewImage = document.createElement('img');
    previewImage.setAttribute('class', 'preview mt-3 rounded-circle border border-dark');
    previewImage.setAttribute('width', '250');
    previewImage.setAttribute('height', '250');
    previewImage.setAttribute('src', window.URL.createObjectURL(e.target.files[0]));

    const previewList = document.getElementById('previews');
    previewList.appendChild(previewImage);
  });
});