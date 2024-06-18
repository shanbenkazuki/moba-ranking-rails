import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="tabs"
export default class extends Controller {
  static targets = ['tab', 'content'];

  change(event) {
    event.preventDefault();
    const target = event.currentTarget.getAttribute('data-tab');

    this.tabTargets.forEach((tab) => tab.classList.toggle('tab-active', tab === event.currentTarget));
    this.contentTargets.forEach((content) => content.classList.toggle('hidden', content.id !== target));
  }
}