module ProjectsHelper
  def category_label(category)
    labels = {
      'web' => 'Web',
      'mobile' => 'モバイル',
      'ai' => 'AI',
      'design' => 'デザイン',
      'video' => '動画',
      'music' => '音楽',
      'business' => 'ビジネス',
      'education' => '教育',
      'other' => 'その他'
    }
    labels[category] || category
  end
end
