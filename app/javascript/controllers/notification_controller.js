import { Controller } from "@hotwired/stimulus"
import io from "socket.io-client"

export default class extends Controller {
  connect() {
    this.userId = document.querySelector("meta[name='user-id']").getAttribute("content");
    if(!this.userId) {
      console.warn("User ID not found, notifications will not be enabled.");
      return;
    }
    this.socket = io('http://localhost:3001', {
      transports: ['websocket'],
      query: { userId: this.userId }
    });
    this.socket.on('connect', () => {
      console.log('Connected to notification server');
    });
    this.socket.emit('join', this.userId);
    this.socket.on('notification', (data) => {
      this.displayNotification(data);
    });
    this.socket.on('disconnect', () => {
      console.log('Disconnected from notification server');
    });

    showNotification = (message) => {
      const notification = document.createElement('div');
      notification.className = 'notification';
      notification.innerText = message;
      document.body.appendChild(notification);
      setTimeout(() => {
        notification.remove();
      }, 5000);
    }
  }
}