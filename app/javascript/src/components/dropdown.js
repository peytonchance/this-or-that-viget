export default class Dropdown {
  constructor(el) {
    this.el = el
    this.getDropdown()
    this.setUpListeners()
  }

  getDropdown() {
    this.headerDropdown = document.querySelector(this.el.getAttribute('aria-controls'))
  }

  setUpListeners() {
    this.el.addEventListener('click', this.toggleDropdown.bind(this))
  }

  toggleDropdown() {
    if (this.headerDropdown.classList.contains('header__dropdown--expanded')) {
      this.headerDropdown.classList.remove('header__dropdown--expanded')
    } else {
      this.headerDropdown.classList.add('header__dropdown--expanded')
    }
  }
}

