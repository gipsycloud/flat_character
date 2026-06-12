import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [
    "searchInput",
    "suggestionsDropdown",
    "mapContainer",
    "latitudeField",
    "longitudeField",
    "addressField"
  ]

  async connect() {
    this.accessToken = document.querySelector("meta[name='mapbox-access-token']")?.content
    this.disconnected = false

    if (!this.accessToken) {
      this.showMessage("Mapbox access token is missing.")
      return
    }

    try {
      await this.loadMapbox()
    } catch (error) {
      this.showMessage("Unable to load Mapbox.")
      return
    }

    if (this.disconnected) return

    window.mapboxgl.accessToken = this.accessToken
    this.searchTimeout = null
    this.defaultCenter = [96.1951, 16.8661]

    this.setupMap()
    this.searchInputTarget.addEventListener("input", this.search)
    this.searchInputTarget.addEventListener("keydown", this.selectFirstSuggestion)
    document.addEventListener("click", this.closeSuggestions)
  }

  disconnect() {
    this.disconnected = true
    clearTimeout(this.searchTimeout)
    this.searchInputTarget.removeEventListener("input", this.search)
    this.searchInputTarget.removeEventListener("keydown", this.selectFirstSuggestion)
    document.removeEventListener("click", this.closeSuggestions)
    this.map?.remove()
  }

  loadMapbox() {
    if (window.mapboxgl) return Promise.resolve()
    if (window.mapboxglLoading) return window.mapboxglLoading

    window.mapboxglLoading = new Promise((resolve, reject) => {
      const script = document.createElement("script")
      script.src = "https://api.mapbox.com/mapbox-gl-js/v2.15.0/mapbox-gl.js"
      script.async = true
      script.onload = resolve
      script.onerror = reject
      document.head.appendChild(script)
    })

    return window.mapboxglLoading
  }

  search = () => {
    clearTimeout(this.searchTimeout)

    this.searchTimeout = setTimeout(() => {
      const query = this.searchInputTarget.value.trim()

      if (query.length < 3) {
        this.clearSuggestions()
        return
      }

      this.fetchSuggestions(query)
    }, 300)
  }

  selectFirstSuggestion = (event) => {
    if (event.key !== "Enter") return

    const firstSuggestion = this.suggestionsDropdownTarget.querySelector("button")
    if (!firstSuggestion) return

    event.preventDefault()
    firstSuggestion.click()
  }

  closeSuggestions = (event) => {
    if (this.element.contains(event.target)) return

    this.clearSuggestions()
  }

  setupMap() {
    const latitude = parseFloat(this.latitudeFieldTarget.value)
    const longitude = parseFloat(this.longitudeFieldTarget.value)
    const hasCoordinates = Number.isFinite(latitude) && Number.isFinite(longitude)
    const center = hasCoordinates ? [longitude, latitude] : this.defaultCenter

    this.map = new window.mapboxgl.Map({
      container: this.mapContainerTarget,
      style: "mapbox://styles/mapbox/streets-v12",
      center,
      zoom: hasCoordinates ? 14 : 11
    })

    this.map.addControl(new window.mapboxgl.NavigationControl(), "top-right")

    this.marker = new window.mapboxgl.Marker({ draggable: true })
      .setLngLat(center)
      .addTo(this.map)

    this.marker.on("dragend", () => {
      const { lng, lat } = this.marker.getLngLat()
      this.updateCoordinates(lng, lat)
      this.reverseGeocode(lng, lat)
    })

    this.map.on("click", (event) => {
      const { lng, lat } = event.lngLat
      this.setLocation(lng, lat)
      this.reverseGeocode(lng, lat)
    })

    if (!hasCoordinates) {
      this.latitudeFieldTarget.value = ""
      this.longitudeFieldTarget.value = ""
    }
  }

  async fetchSuggestions(query) {
    const url = new URL(`https://api.mapbox.com/geocoding/v5/mapbox.places/${encodeURIComponent(query)}.json`)
    url.searchParams.set("access_token", this.accessToken)
    url.searchParams.set("limit", "5")
    url.searchParams.set("types", "address,place,locality,neighborhood,poi")

    try {
      const response = await fetch(url)
      if (!response.ok) throw new Error("Unable to search address")

      const data = await response.json()
      this.renderSuggestions(data.features || [])
    } catch (error) {
      this.showMessage("Unable to search right now.")
    }
  }

  renderSuggestions(features) {
    this.suggestionsDropdownTarget.innerHTML = ""

    if (features.length === 0) {
      this.showMessage("No locations found.")
      return
    }

    features.forEach((feature) => {
      const button = document.createElement("button")
      button.type = "button"
      button.className = "block w-full px-3 py-2 text-left text-sm text-gray-900 hover:bg-gray-100 dark:text-white dark:hover:bg-gray-600"
      button.textContent = feature.place_name
      button.addEventListener("click", () => this.chooseSuggestion(feature))

      this.suggestionsDropdownTarget.appendChild(button)
    })

    this.suggestionsDropdownTarget.classList.remove("hidden")
  }

  chooseSuggestion(feature) {
    const [longitude, latitude] = feature.center

    this.searchInputTarget.value = feature.place_name
    this.addressFieldTarget.value = feature.place_name
    this.setLocation(longitude, latitude)
    this.clearSuggestions()
  }

  async reverseGeocode(longitude, latitude) {
    const url = new URL(`https://api.mapbox.com/geocoding/v5/mapbox.places/${longitude},${latitude}.json`)
    url.searchParams.set("access_token", this.accessToken)
    url.searchParams.set("limit", "1")

    try {
      const response = await fetch(url)
      if (!response.ok) throw new Error("Unable to find address")

      const data = await response.json()
      const placeName = data.features?.[0]?.place_name

      if (placeName) {
        this.searchInputTarget.value = placeName
        this.addressFieldTarget.value = placeName
      }
    } catch (error) {
      this.addressFieldTarget.value = `${latitude.toFixed(6)}, ${longitude.toFixed(6)}`
    }
  }

  setLocation(longitude, latitude) {
    this.updateCoordinates(longitude, latitude)
    this.marker.setLngLat([longitude, latitude])
    this.map.flyTo({ center: [longitude, latitude], zoom: 14 })
  }

  updateCoordinates(longitude, latitude) {
    this.longitudeFieldTarget.value = longitude
    this.latitudeFieldTarget.value = latitude
  }

  clearSuggestions() {
    this.suggestionsDropdownTarget.innerHTML = ""
    this.suggestionsDropdownTarget.classList.add("hidden")
  }

  showMessage(message) {
    this.suggestionsDropdownTarget.innerHTML = `<div class="px-3 py-2 text-sm text-gray-500 dark:text-gray-300">${message}</div>`
    this.suggestionsDropdownTarget.classList.remove("hidden")
  }
}
