function toggleForm(formType) {
  document.querySelector('.tab.active').classList.remove('active');
  document.querySelector(`.tab[onclick*="${formType}"]`).classList.add('active');

  document.getElementById('loginForm').classList.toggle('hidden', formType !== 'login');
  document.getElementById('registerForm').classList.toggle('hidden', formType !== 'register');
}

// Manejo de formularios
document.getElementById('login').addEventListener('submit', async (e) => {
  e.preventDefault();
  const form = e.target;
  const res = await fetch('/api/login', {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({
      email: form.email.value,
      password: form.password.value
    })
  });
  const data = await res.json();
  document.getElementById('loginMsg').textContent = data.message;
});

document.getElementById('register').addEventListener('submit', async (e) => {
  e.preventDefault();
  const form = e.target;
  const res = await fetch('/api/register', {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({
      name: form.name.value,
      email: form.email.value,
      password: form.password.value
    })
  });
  const data = await res.json();
  document.getElementById('registerMsg').textContent = data.message;
});
