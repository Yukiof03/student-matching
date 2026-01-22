# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

puts "Creating initial skills..."

skills_data = {
  'programming' => [
    'Python', 'JavaScript', 'TypeScript', 'Ruby', 'Java', 'C++', 'Go', 'Rust', 'PHP', 'Swift',
    'React', 'Vue.js', 'Angular', 'Next.js', 'Node.js', 'Ruby on Rails',
    'Django', 'Flask', 'Spring Boot', 'Laravel', 'Express.js',
    'HTML', 'CSS', 'Sass', 'Tailwind CSS', 'Bootstrap'
  ],
  'design' => [
    'Adobe Photoshop', 'Adobe Illustrator', 'Figma', 'Sketch', 'Adobe XD',
    'UI Design', 'UX Design', 'Graphic Design', 'Web Design', 'Logo Design',
    'Branding', 'Typography', 'Canva', 'InDesign'
  ],
  'video' => [
    'Adobe Premiere Pro', 'Final Cut Pro', 'After Effects', 'DaVinci Resolve',
    'Video Editing', '3D Animation', 'Motion Graphics', 'Color Grading',
    'iMovie', 'Filmora'
  ],
  'business' => [
    'Project Management', 'Marketing', 'Content Writing', 'SEO', 'Data Analysis',
    'Business Planning', 'Market Research', 'Social Media Management',
    'Excel', 'PowerPoint', 'Google Analytics'
  ],
  'music' => [
    'Music Production', 'Audio Editing', 'Sound Design', 'Logic Pro', 'Ableton Live',
    'FL Studio', 'GarageBand', 'Mixing', 'Mastering'
  ],
  'other' => [
    'Translation', 'Writing', 'Photography', 'Illustration',
    'Voice Acting', 'Public Speaking', 'Teaching'
  ]
}

skills_data.each do |category, skill_names|
  skill_names.each do |name|
    Skill.find_or_create_by!(name: name) do |skill|
      skill.category = category
      skill.usage_count = 0
    end
  end
end

puts "Created #{Skill.count} skills"

# Create a demo user for testing (optional)
if Rails.env.development?
  demo_user = User.find_or_create_by!(email: 'demo@example.com') do |user|
    user.name = 'デモユーザー'
    user.password = 'password123'
    user.password_confirmation = 'password123'
  end

  # Add some skills to demo user
  %w[Python React Figma].each do |skill_name|
    skill = Skill.find_by(name: skill_name)
    demo_user.user_skills.find_or_create_by!(skill: skill) if skill
  end

  puts "Created demo user: demo@example.com (password: password123)"
end

puts "Seed data loaded successfully!"
