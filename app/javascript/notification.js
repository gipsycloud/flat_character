// import { Controller } from "@hotwired/stimulus"
import io from "socket.io-client"

  const userId = document.querySelector("meta[name='user-id']").getAttribute("content");
  const socket = io('http://localhost:3001', {
    transports: ['websocket'],
    query: { userId: userId },
    method: 'POST'
  });
  socket.on('connect', () => {
      console.log('Connected to notification service');
  });
  socket.on('notification', (data) => {
    setTimeout(() => {
      notification.remove();
    }, 5000);
  });
  socket.on('disconnect', () => {
    console.log('Disconnected from notification server');
  });