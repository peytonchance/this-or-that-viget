export default class Modal {
  constructor(el) {
    this.el = el
    this.setVars()
    this.setUpListeners()
  }

  setVars() {
    this.bodyMain = document.querySelector('.body__main')
    this.allTargets = Array.from(document.querySelectorAll('.modal'))
    this.targetModal = document.getElementById(this.el.getAttribute('aria-controls'))
  }

  setUpListeners() {
    if (this.targetModal.classList.contains('header__dropdown')) {
      this.el.addEventListener('click', this.toggleDropdown.bind(this))
    } else {
      this.el.addEventListener('click', this.toggleModal.bind(this))
    }
  }

  showModal() {
    this.allTargets.forEach((target) => {
      target.setAttribute('hidden', '')
    })
    this.targetModal.removeAttribute('hidden')
  }

  hideModal() {
    this.targetModal.setAttribute('hidden', '')
    this.targetModal.classList.add('form--no-blur')
  }

  fadeBackground() {
    this.bodyMain.classList.add('body__main--muted')
  }

  unfadeBackground() {
    this.bodyMain.classList.remove('body__main--muted')
  }

  toggleDropdown() {
    if (this.targetModal.hidden) {
      this.targetModal.removeAttribute('hidden')
    } else {
      this.hideModal()
    }
  }

  toggleModal() {
    if (this.targetModal.hidden) {
      this.showModal()
      this.fadeBackground()
    } else {
      this.hideModal()
      this.unfadeBackground()
    }
  }
}
