document.addEventListener('turbolinks:load', function() {
  document.querySelectorAll('.password-container').forEach(container => {
    const password = container.querySelector('.password-field');
    const checkbox = container.querySelector('.password-show');
    checkbox.addEventListener('click', e => {
      password.type = e.target.checked ? 'text' : 'password';
    });
  });
});