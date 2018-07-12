export default class Modal {
  constructor(el) {
    this.el = el
    this.setVars()
    this.setUpListeners()
  }

  setVars() {
    this.bodyMain = document.querySelector('.body__main')
    this.allTargets = Array.from(document.querySelectorAll('.form'))
    this.targetModal = document.querySelector(`.${this.el.dataset.modal}`)
  }

  setUpListeners() {
    this.el.addEventListener('click', this.toggleModal.bind(this))
  }

  toggleModal() {
    if (this.targetModal.hidden) {
      console.log('trying to show')
      this.showModal()
      this.fadeBackground()
    } else {
      console.log('trying to hide')
      this.hideModal()
      this.unfadeBackground()
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
}
