export default class Upload {
  constructor(el) {
    this.el = el
    this.setVars()
    this.setUpListeners()
  }

  setVars() {
    this.el.filename = 'no file chosen'
    this.el.target = document.querySelector('#' + this.el.id + '_filename')
  }

  setUpListeners() {
    this.el.addEventListener('change', this.displayFilename.bind(this))
  }

  displayFilename() {
    this.el.filename = this.el.value.substring(12)
    this.el.target.innerHTML = this.el.filename
  }
}
