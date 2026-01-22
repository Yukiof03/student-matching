import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="skill-tags"
export default class extends Controller {
  static targets = ["input", "hiddenInput", "suggestions", "tagContainer"]
  static values = {
    selected: { type: Array, default: [] }
  }

  connect() {
    console.log('SkillTags controller connected')
    console.log('Initial selected skills:', this.selectedValue)
    this.renderTags()
  }

  async search(event) {
    const query = event.target.value.trim()
    console.log('Search triggered, query:', query)

    if (query.length < 2) {
      this.hideSuggestions()
      return
    }

    try {
      const response = await fetch(`/skills/autocomplete?q=${encodeURIComponent(query)}`)
      if (!response.ok) throw new Error('Network response was not ok')

      const skills = await response.json()
      console.log('Skills fetched:', skills)

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
        <button type="button" class="list-group-item list-group-item-action" data-action="click->skill-tags#selectSkill" data-skill-id="${skill.id}" data-skill-name="${skill.name}">
          ${skill.name}
          <small class="text-muted ms-2">${this.getCategoryLabel(skill.category)}</small>
        </button>
      `).join('')
    }

    if (!exactMatch) {
      html += `
        <button type="button" class="list-group-item list-group-item-action" data-action="click->skill-tags#createNewSkill" data-skill-name="${query}">
          <i class="bi bi-plus-circle me-2"></i>
          新しいスキル「${query}」を作成
        </button>
      `
    }

    if (html === '' && skills.length === 0) {
      html = `
        <button type="button" class="list-group-item list-group-item-action" data-action="click->skill-tags#createNewSkill" data-skill-name="${query}">
          <i class="bi bi-plus-circle me-2"></i>
          新しいスキル「${query}」を作成
        </button>
      `
    }

    this.suggestionsTarget.innerHTML = html
    this.suggestionsTarget.classList.remove("d-none")
  }

  selectSkill(event) {
    event.preventDefault()
    const skillId = parseInt(event.currentTarget.dataset.skillId)
    const skillName = event.currentTarget.dataset.skillName

    console.log('Selecting skill:', skillId, skillName)

    // Check if already selected
    if (this.selectedValue.some(s => s.id === skillId)) {
      console.log('Skill already selected')
      this.inputTarget.value = ""
      this.hideSuggestions()
      return
    }

    // Add to selected skills
    this.selectedValue = [...this.selectedValue, { id: skillId, name: skillName }]
    console.log('Updated selected skills:', this.selectedValue)

    this.renderTags()
    this.updateHiddenInput()

    // Clear input
    this.inputTarget.value = ""
    this.hideSuggestions()
  }

  async createNewSkill(event) {
    event.preventDefault()
    const skillName = event.currentTarget.dataset.skillName

    console.log('Creating new skill:', skillName)

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

      if (!response.ok) throw new Error('Failed to create skill')

      const skill = await response.json()
      console.log('Skill created:', skill)

      // Check if already selected
      if (!this.selectedValue.some(s => s.id === skill.id)) {
        this.selectedValue = [...this.selectedValue, { id: skill.id, name: skill.name }]
        this.renderTags()
        this.updateHiddenInput()
      }

      // Clear input
      this.inputTarget.value = ""
      this.hideSuggestions()
    } catch (error) {
      console.error("Failed to create skill:", error)
      alert("スキルの作成に失敗しました")
    }
  }

  removeTag(event) {
    event.preventDefault()
    const skillId = parseInt(event.currentTarget.dataset.skillId)
    console.log('Removing skill:', skillId)

    this.selectedValue = this.selectedValue.filter(s => s.id !== skillId)
    this.renderTags()
    this.updateHiddenInput()
  }

  renderTags() {
    console.log('Rendering tags for:', this.selectedValue)

    this.tagContainerTarget.innerHTML = this.selectedValue.map(skill => `
      <span class="badge bg-primary me-2 mb-2" style="font-size: 0.9rem;">
        ${skill.name}
        <button type="button" class="btn-close btn-close-white ms-2" style="font-size: 0.6rem;" data-action="click->skill-tags#removeTag" data-skill-id="${skill.id}" aria-label="削除"></button>
      </span>
    `).join("")
  }

  updateHiddenInput() {
    const skillIds = this.selectedValue.map(s => s.id)
    this.hiddenInputTarget.value = JSON.stringify(skillIds)
    console.log('Hidden input updated:', this.hiddenInputTarget.value)
  }

  hideSuggestions() {
    this.suggestionsTarget.innerHTML = ""
    this.suggestionsTarget.classList.add("d-none")
  }

  getCategoryLabel(category) {
    const labels = {
      'programming': 'プログラミング',
      'design': 'デザイン',
      'video': '動画編集',
      'business': 'ビジネス',
      'music': '音楽',
      'other': 'その他'
    }
    return labels[category] || category
  }
}
