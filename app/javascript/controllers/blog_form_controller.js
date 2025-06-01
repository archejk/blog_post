import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    console.log("Blog form controller connected")
    this.autoSave()
  }

  autoSave() {
    // simple auto-save to localStorage for draft functionality
    const titleField = this.element.querySelector('input[name*="title"]')
    const contentField = this.element.querySelector('textarea[name*="content"]')
    
    if (titleField && contentField) {
      // load saved draft
      titleField.value = localStorage.getItem('blog_draft_title') || titleField.value
      contentField.value = localStorage.getItem('blog_draft_content') || contentField.value
      
      // save on input
      titleField.addEventListener('input', () => {
        localStorage.setItem('blog_draft_title', titleField.value)
      })
      
      contentField.addEventListener('input', () => {
        localStorage.setItem('blog_draft_content', contentField.value)
      })
    }
  }

  clearDraft() {
    localStorage.removeItem('blog_draft_title')
    localStorage.removeItem('blog_draft_content')
  }
}