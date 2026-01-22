import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "suggestions", "skillId", "submitBtn"]

  async search() {
    const query = this.inputTarget.value.trim()

    if (query.length < 2) {
      this.hideSuggestions()
      return
    }

    try {
      const response = await fetch(`/skills/autocomplete?q=${encodeURIComponent(query)}`)
      const skills = await response.json()

      this.renderSuggestions(skills, query)
    } catch (error) {
      console.error("Skill search failed:", error)
    }
  }

  renderSuggestions(skills, query) {
    const exactMatch = skills.find(s => s.name.toLowerCase() === query.toLowerCase())

    let html = ''

    if (skills.length > 0) {
      html += skills.map(skill => `
        <button type="button" class="list-group-item list-group-item-action" data-action="click->skill-search#selectSkill" data-skill-id="${skill.id}" data-skill-name="${skill.name}">
          ${skill.name}
        </button>
      `).join('')
    }

    if (!exactMatch) {
      html += `
        <button type="button" class="list-group-item list-group-item-action text-primary" data-action="click->skill-search#createAndSelect" data-skill-name="${query}">
          <strong>+</strong> 新しいスキル「${query}」を作成して追加
        </button>
      `
    }

    this.suggestionsTarget.innerHTML = html
    this.suggestionsTarget.style.display = 'block'
  }

  selectSkill(event) {
    const skillId = event.currentTarget.dataset.skillId
    const skillName = event.currentTarget.dataset.skillName

    this.skillIdTarget.value = skillId
    this.inputTarget.value = skillName
    this.submitBtnTarget.disabled = false
    this.hideSuggestions()
  }

  async createAndSelect(event) {
    const skillName = event.currentTarget.dataset.skillName

    try {
      const response = await fetch("/skills", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').content
        },
        body: JSON.stringify({
          skill: {
            name: skillName,
            category: "other"
          }
        })
      })

      const skill = await response.json()

      this.skillIdTarget.value = skill.id
      this.inputTarget.value = skill.name
      this.submitBtnTarget.disabled = false
      this.hideSuggestions()
    } catch (error) {
      console.error("Failed to create skill:", error)
      alert("スキルの作成に失敗しました")
    }
  }

  hideSuggestions() {
    this.suggestionsTarget.innerHTML = ""
    this.suggestionsTarget.style.display = 'none'
  }
}
