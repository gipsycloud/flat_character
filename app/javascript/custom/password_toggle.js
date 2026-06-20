document.addEventListener("turbo:load", () => {
  document.querySelectorAll("[data-password-toggle-button]").forEach((button) => {
    const targetId = button.dataset.passwordToggleTarget
    const input = targetId ? document.getElementById(targetId) : null
    const eye = button.querySelector("[data-password-toggle-eye]")
    const eyeOff = button.querySelector("[data-password-toggle-eye-off]")

    if (!input || !eye || !eyeOff) return

    button.addEventListener("click", () => {
      const show = input.type === "password"
      input.type = show ? "text" : "password"
      eye.classList.toggle("hidden", !show)
      eyeOff.classList.toggle("hidden", show)
      button.setAttribute("aria-label", show ? "Hide password" : "Show password")
    })
  })
})
