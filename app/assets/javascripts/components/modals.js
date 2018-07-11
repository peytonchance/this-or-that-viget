var getAllModalToggles = () => {
  this.allModalToggles = document.querySelectorAll('[data-modal]')
  this.allTargets = document.querySelectorAll('.sign-up, .log-in')
  this.bodyMain = document.querySelector('.body__main')
  this.allModalToggles.forEach((modalToggle) => {
    setUpEventListener(modalToggle)
  })
}

var setUpEventListener = (modalToggle) => {
  modalToggle.addEventListener('click', () => {
    setTarget(modalToggle);
  })
}

var setTarget = (modalToggle) => {
  let target = modalToggle.getAttribute('data-modal')
  let currentTarget = "[data-modal='" + target + "']"
  let currentModal = document.querySelector("." + target)
  toggleModal(currentModal)
}

var toggleModal = (currentModal) => {
  if (currentModal.classList.contains('form--hidden')) {
    this.allTargets.forEach((target) => {
      target.classList.add('form--hidden')
      this.bodyMain.classList.add('body__main--muted')
    })
     currentModal.classList.remove('form--hidden')
     currentModal.classList.add('form--no-blur')
  } else {
    this.bodyMain.classList.remove('body__main--muted')
    currentModal.classList.add('form--hidden')
  }
}

getAllModalToggles();
