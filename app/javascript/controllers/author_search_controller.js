import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["searchInput", "dropdown", "hiddenField", "clearButton"]

  connect() {
    console.log("Author search controller connected")

    this.originalOptions = Array.from(this.dropdownTarget.querySelectorAll("button[data-author-id]"))
    this.hideDropdown()
    this.updateClearButton()

    document.addEventListener("click", this.handleOutsideClick.bind(this))
  }

  disconnect() {
    document.removeEventListener("click", this.handleOutsideClick.bind(this))
  }

  handleOutsideClick(event) {
    if (!this.element.contains(event.target)) {
      this.hideDropdown()
    }
  }

  search(event) {
    const searchTerm = event.target.value.toLowerCase().trim()
    const options = this.dropdownTarget.querySelectorAll("button[data-author-id]")

    let hasVisibleOptions = false
    
    options.forEach(option => {
      const authorName = option.dataset.authorName.toLowerCase()
      const shouldShow = authorName.includes(searchTerm) || option.dataset.authorId === ""
      
      if (shouldShow) {
        option.style.display = "block"
        hasVisibleOptions = true
      } else {
        option.style.display = "none"
      }
    })

    if (hasVisibleOptions && searchTerm.length > 0) {
      this.showDropdown()
    } else if (searchTerm.length === 0) {
      this.showDropdown()
    } else {
      this.hideDropdown()
    }

    this.updateClearButton()
  }

  showDropdown() {
    this.dropdownTarget.classList.remove("hidden")
  }

  hideDropdown() {
    this.dropdownTarget.classList.add("hidden")
  }

  selectAuthor(event) {
    const button = event.target
    const authorId = button.dataset.authorId
    const authorName = button.dataset.authorName

    // update the search input
    this.searchInputTarget.value = authorName === "All Authors" ? "" : authorName
    this.hiddenFieldTarget.value = authorId
    this.hideDropdown()
    this.updateClearButton()
    this.resetDropdownOptions()
  }

  clear() {
    this.searchInputTarget.value = ""
    this.hiddenFieldTarget.value = ""
    this.hideDropdown()
    this.updateClearButton()
    this.resetDropdownOptions()
  }

  updateClearButton() {
    if (this.searchInputTarget.value.trim().length > 0) {
      this.clearButtonTarget.style.display = "flex"
    } else {
      this.clearButtonTarget.style.display = "none"
    }
  }

  resetDropdownOptions() {
    const options = this.dropdownTarget.querySelectorAll("button[data-author-id]")
    options.forEach(option => {
      option.style.display = "block"
    })
  }
}