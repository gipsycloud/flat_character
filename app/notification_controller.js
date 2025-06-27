// import { Controller } from "@hotwired/stimulus"
import io from "socket.io-client"

document.addEventListener('DOMContentLoaded', () => {
  const userId = document.querySelector("meta[name='user-id']").getAttribute("content");
  if(!userId) return;
  const socket = io('http://localhost:3001', {
    transports: ['websocket'],
    query: { userId: this.userId }
  });
  socket.emit('join', userId);
  socket.on('notification', (message) => {
    const notification = document.createElement('div');
    console.log('Received notification:', message);
    
    notification.className = 'notification';
    notification.textContent = message;
    document.body.appendChild(notification);
    
    // Automatically remove the notification after 5 seconds
    setTimeout(() => {
      notification.remove();
    }, 5000);
  });
  socket.on('disconnect', () => {
    console.log('Disconnected from notification server');
  });
});