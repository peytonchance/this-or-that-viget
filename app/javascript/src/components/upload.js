export default class Upload {
  constructor(el) {
    this.el = el
    this.setInitialFilename()
    this.setUpListeners()
  }

  setInitialFilename() {
    this.el.filename = 'no file chosen'
    this.defineTarget()
  }

  defineTarget () {
    this.el.targetString = document.querySelector(this.el.dataset.targetstring)
  }

  setUpListeners() {
    this.el.addEventListener('change', this.displayFilename.bind(this))
  }

  displayFilename() {
    this.el.filename = this.el.value.substring(12)
    this.el.targetString.innerHTML = this.el.filename
  }
}
