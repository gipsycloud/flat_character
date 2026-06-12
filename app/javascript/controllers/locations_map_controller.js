import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = {
    url: String
  }

  async connect() {
    this.disconnected = false

    try {
      await this.loadLeaflet()
      if (this.disconnected) return

      this.setupMap()
      await this.loadLocations()
    } catch (error) {
      this.showMessage("Unable to load map locations.")
    }
  }

  disconnect() {
    this.disconnected = true
    this.map?.remove()
  }

  loadLeaflet() {
    if (window.L) return Promise.resolve()
    if (window.leafletLoading) return window.leafletLoading

    this.addLeafletStylesheet()

    window.leafletLoading = new Promise((resolve, reject) => {
      const script = document.createElement("script")
      script.src = "https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"
      script.async = true
      script.onload = resolve
      script.onerror = reject
      document.head.appendChild(script)
    })

    return window.leafletLoading
  }

  addLeafletStylesheet() {
    if (document.querySelector("link[data-leaflet-stylesheet]")) return

    const link = document.createElement("link")
    link.rel = "stylesheet"
    link.href = "https://unpkg.com/leaflet@1.9.4/dist/leaflet.css"
    link.dataset.leafletStylesheet = "true"
    document.head.appendChild(link)
  }

  setupMap() {
    this.map = window.L.map(this.element).setView([16.8661, 96.1951], 11)

    window.L.tileLayer("https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png", {
      attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
    }).addTo(this.map)
  }

  async loadLocations() {
    const response = await fetch(this.urlValue)
    if (!response.ok) throw new Error("Unable to fetch room locations")

    const rooms = await response.json()
    const bounds = []

    rooms.forEach((room) => {
      const latitude = parseFloat(room.latitude)
      const longitude = parseFloat(room.longitude)

      if (!Number.isFinite(latitude) || !Number.isFinite(longitude)) return

      const marker = window.L.marker([latitude, longitude]).addTo(this.map)
      marker.bindPopup(this.popupContent(room))
      bounds.push([latitude, longitude])
    })

    if (bounds.length > 0) {
      this.map.fitBounds(bounds, { padding: [40, 40], maxZoom: 14 })
    } else {
      this.showMessage("No room locations found.")
    }
  }

  popupContent(room) {
    if (room.tooltip) return room.tooltip

    return `
      <div>
        <strong>${room.label || "Room"}</strong><br>
        ${room.address || ""}
      </div>
    `
  }

  showMessage(message) {
    this.element.innerHTML = `<div class="flex h-full items-center justify-center text-sm text-gray-500">${message}</div>`
  }
}
