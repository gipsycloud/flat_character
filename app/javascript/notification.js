const socket = io('http://localhost:3001');

const userId = document.body.dataset.userId;
socket.emit('join', userId );
socket.on('notification', (message) => {
  console.log('Notification received:', message);
  showToastNotification(message);
});

function showToastNotification(message) {
  const toast = document.createElement('div');
  toast.className = 'toast';
  toast.textContent = message;
  document.body.appendChild(toast);

  setTimeout(() => {
    toast.classList.add('show');
  }, 100);

  setTimeout(() => {
    toast.classList.remove('show');
    setTimeout(() => {
      document.body.removeChild(toast);
    }, 300);
  }, 3000);
}