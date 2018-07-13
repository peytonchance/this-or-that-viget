export default class Modal {
  constructor(el) {
    this.el = el
    this.setVars()
    this.setUpListeners()
  }

  setVars() {
    this.bodyMain = document.querySelector('.body__main')
    this.allTargets = Array.from(document.querySelectorAll('.form'))
    this.targetModal = document.getElementById(this.el.getAttribute('aria-controls'))
  }

  setUpListeners() {
    this.el.addEventListener('click', this.toggleModal.bind(this))
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
