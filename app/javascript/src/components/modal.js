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
    if (this.targetModal.classList.contains('form--hidden')) {
      this.allTargets.forEach((target) => {
        target.classList.add('form--hidden')
      })
      this.bodyMain.classList.add('body__main--muted')
      this.targetModal.classList.remove('form--hidden')
    } else {
      this.targetModal.classList.add('form--hidden')
      this.targetModal.classList.add('form--no-blur')
      this.bodyMain.classList.remove('body__main--muted')
    }
  }
}
