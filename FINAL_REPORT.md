# Student Matching Social Network - 最終レポート

## 目次
1. [アプリケーション概要](#1-アプリケーション概要)
2. [使い方の説明](#2-使い方の説明)
3. [内部構造の説明](#3-内部構造の説明)

---

## 1. アプリケーション概要

### 1.1 プロジェクト名
**Student Matching Social Network**

### 1.2 目的
「やりたいことがある学生（プロジェクトオーナー）」と「スキルを活かしたい学生（スキルホルダー）」をマッチングするソーシャルネットワークシステム

### 1.3 主な機能
- デュアルプロフィールシステム（1ユーザーが2つの役割を持つ）
- モード切り替え機能（プロジェクトオーナー⇄スキルホルダー）
- 動的スキルタグシステム（ユーザーが新規スキルを作成可能）
- プロジェクト投稿・検索・管理
- 双方向マッチングシステム（スカウト + 応募 = マッチング成立）
- マッチング成立時のSNS連絡先開示
- レコメンデーション機能
- ポートフォリオ画像アップロード

### 1.4 技術スタック
- **フレームワーク**: Ruby on Rails 8.1.1
- **データベース**: PostgreSQL 16
- **認証**: Devise
- **UI**: Bootstrap 5.3（カスタムパステルカラーテーマ）
- **JavaScript**: Stimulus
- **CSS**: Sass/SCSS with PostCSS
- **ストレージ**: Active Storage
- **デプロイ**: Render (https://render.com)
- **バージョン管理**: Git/GitHub

---

## 2. 使い方の説明

### 2.1 ユーザー登録とログイン

#### 新規登録
1. トップページの「新規登録」をクリック
2. 以下の情報を入力：
   - 名前
   - メールアドレス
   - パスワード（6文字以上）
   - パスワード確認
3. 「Sign up」ボタンをクリック
4. 登録完了後、自動的にログインされホーム画面に遷移

#### ログイン
1. トップページの「ログイン」をクリック
2. メールアドレスとパスワードを入力
3. 「Log in」ボタンをクリック

### 2.2 プロフィール設定

#### プロジェクトオーナープロフィール
1. ホーム画面の「プロジェクトオーナープロフィール」カードの「プロフィールを編集」をクリック
2. 以下の情報を入力：
   - **自己紹介**: あなたの活動内容や目指していること
   - **目標**: プロジェクトを通じて達成したいこと
   - **過去のプロジェクト**: 今までの実績や経験
3. 「更新する」をクリック

#### スキルホルダープロフィール
1. ホーム画面の「スキルホルダープロフィール」カードの「プロフィールを編集」をクリック
2. 以下の情報を入力：
   - **自己紹介**: あなたのスキルや経験
   - **過去の制作物**: これまでの実績
   - **実績・受賞歴**: アピールポイント
   - **稼働可能時間**: 週に何時間活動できるか
3. 「更新する」をクリック

#### SNS連絡先の登録（重要！）
マッチング成立時に相手に開示される連絡先を登録します。

1. ホーム画面の「SNSを編集」をクリック
2. 「SNSリンクを追加」セクションで以下を入力：
   - **プラットフォーム**: Twitter/Instagram/Facebook/Discord/Slack/LINE/Email/その他
   - **URL/ID**: 実際の連絡先（TwitterのURL、LINE IDなど）
   - **マッチング後に公開**: チェックを入れる（必須）
3. 「追加」をクリック
4. 複数の連絡先を登録可能（推奨：Twitter、LINE、Discord等）

**注意**: マッチング成立時に相手に表示されるため、正確な情報を登録してください。

#### スキルの登録
1. ホーム画面の「あなたのスキル」カードの「編集」ボタンをクリック
2. 検索ボックスにスキル名を入力（例: Python, Figma, 動画編集）
3. 候補から選択するか、「新しいスキル『○○』を作成して追加」をクリック
4. 「追加」をクリック
5. 不要なスキルは×ボタンで削除可能

### 2.3 モード切り替え

#### モードの概念
- **プロジェクトオーナーモード**: プロジェクトを投稿し、スキルホルダーを探す
- **スキルホルダーモード**: プロジェクトを探し、応募する

#### 切り替え方法
1. 画面右上のユーザー名をクリック
2. ドロップダウンメニューから切り替えたいモードを選択
3. 現在のモードは画面右上に表示（例: 「現在: プロジェクトオーナーモード」）

### 2.4 プロジェクトオーナーの使い方

#### 2.4.1 プロジェクトの投稿
1. **プロジェクトオーナーモード**に切り替え
2. ナビゲーションバーの「プロジェクト一覧」→「新規プロジェクト」をクリック
3. 以下の情報を入力：
   - **タイトル**: プロジェクト名（例: 学生向けフリマアプリ開発）
   - **目的**: なぜこのプロジェクトをやるのか
   - **詳細説明**: 具体的な内容、期待される成果物
   - **カテゴリ**: web/mobile/design/video/music/business/other
   - **必要人数**: 何人募集するか
   - **想定期間**: プロジェクトの期間（例: 3ヶ月）
   - **必要なスキル**: 検索して追加（複数選択可能）
4. 「作成する」をクリック（下書き状態で保存）
5. プロジェクト詳細ページで「プロジェクトを公開」をクリック

#### 2.4.2 スキルホルダーの検索
1. ナビゲーションバーの「検索」をクリック
2. 検索条件を入力：
   - **キーワード**: 名前、自己紹介など
   - **スキルで絞り込み**: 必要なスキルを選択
3. 「検索」をクリック
4. 検索結果から候補者を確認

#### 2.4.3 スカウトの送信
1. スキルホルダー検索結果から「スカウトする」ボタンをクリック
2. モーダルウィンドウで以下を入力：
   - **プロジェクトを選択**: どのプロジェクトへのスカウトか
   - **スカウトメッセージ**: なぜこの人をスカウトするのか
3. 「スカウトする」をクリック

#### 2.4.4 応募の管理
1. ナビゲーションバーの「プロジェクト一覧」から自分のプロジェクトを選択
2. 「応募者一覧」セクションに応募が表示される
3. 各応募者の情報を確認：
   - スキル一覧
   - 応募メッセージ
   - 自己紹介
4. 「承認する」または「却下する」をクリック

### 2.5 スキルホルダーの使い方

#### 2.5.1 プロジェクトの検索
1. **スキルホルダーモード**に切り替え
2. ナビゲーションバーの「検索」をクリック
3. 検索条件を入力：
   - **キーワード**: プロジェクト名、目的など
   - **カテゴリ**: web/mobile/design等
   - **スキルで絞り込み**: 自分が持っているスキル
4. 「検索」をクリック

#### 2.5.2 プロジェクトへの応募
1. 検索結果から興味のあるプロジェクトをクリック
2. プロジェクト詳細を確認
3. 「応募メッセージ」を入力：
   - 自分のスキルをアピール
   - プロジェクトへの意気込み
4. 「応募する」をクリック

#### 2.5.3 スカウトへの対応
1. ナビゲーションバーの「スカウト」をクリック
2. 「受信したスカウト」タブで確認
3. プロジェクト内容とスカウトメッセージを確認
4. 「承認する」または「辞退する」をクリック

### 2.6 マッチングの成立

#### 双方向マッチングの仕組み
マッチングは以下の条件が**両方とも満たされた時**に成立します：
1. プロジェクトオーナーがスキルホルダーにスカウトを送信 **AND**
2. スキルホルダーが同じプロジェクトに応募

または

1. スキルホルダーがプロジェクトに応募 **AND**
2. プロジェクトオーナーがその応募を承認

#### マッチング成立時の流れ
1. **マッチング成立の通知**
   - 「マッチングが成立しました！」のメッセージが表示
   - 自動的にモーダルウィンドウがポップアップ

2. **SNS連絡先の開示**
   - モーダルに相手の登録済みSNS連絡先が表示される
   - プラットフォーム別にアイコン付きで表示
   - リンクをクリックすると新しいタブで開く

3. **連絡を取る**
   - 表示された連絡先（Twitter、LINE、Discord等）からメッセージを送信
   - プロジェクトの詳細を話し合う

4. **マッチング一覧で確認**
   - ナビゲーションバーの「マッチング」から過去のマッチングを確認可能
   - いつでも相手の連絡先を確認できる

### 2.7 レコメンデーション機能

#### ホーム画面のおすすめ
ホーム画面に自動的に表示されます：

**プロジェクトオーナーモード時**:
- あなたのプロジェクトに必要なスキルを持つスキルホルダーを推薦

**スキルホルダーモード時**:
- あなたのスキルを必要としているプロジェクトを推薦

### 2.8 ポートフォリオ管理（スキルホルダー）

#### ポートフォリオ画像のアップロード
1. スキルホルダープロフィール編集画面から「ポートフォリオ」セクションへ
2. 「新しいポートフォリオアイテムを追加」をクリック
3. 以下の情報を入力：
   - **タイトル**: 作品名
   - **説明**: 作品の概要
   - **画像**: ファイルを選択してアップロード
   - **URL**: 外部リンク（任意）
   - **完成日**: いつ完成したか
4. 「保存」をクリック

---

## 3. 内部構造の説明

### 3.1 アーキテクチャ概要

#### MVC（Model-View-Controller）パターン
Rails標準のMVCアーキテクチャを採用し、関心の分離を実現しています。

```
student_matching/
├── app/
│   ├── models/          # ビジネスロジック・データモデル
│   ├── controllers/     # リクエスト処理・フロー制御
│   ├── views/          # UI・プレゼンテーション層
│   ├── services/       # 複雑なビジネスロジックの抽出
│   └── javascript/     # フロントエンドロジック（Stimulus）
├── db/                 # データベース設計
│   ├── migrate/        # マイグレーションファイル
│   ├── schema.rb       # データベーススキーマ
│   └── seeds.rb        # 初期データ
└── config/             # 設定ファイル
    ├── routes.rb       # ルーティング定義
    └── database.yml    # DB接続設定
```

### 3.2 データベース設計

#### ER図（Entity-Relationship Diagram）

```
┌─────────────────┐
│     User        │
├─────────────────┤
│ id              │PK
│ email           │
│ name            │
│ encrypted_password│
│ created_at      │
│ updated_at      │
└─────────────────┘
        │
        ├──────────────────────────┐
        │                          │
        ▼                          ▼
┌─────────────────┐      ┌─────────────────┐
│ProjectOwner     │      │SkillHolder      │
│Profile          │      │Profile          │
├─────────────────┤      ├─────────────────┤
│ id              │PK    │ id              │PK
│ user_id         │FK    │ user_id         │FK
│ introduction    │      │ introduction    │
│ goals           │      │ past_work       │
│ past_projects   │      │ achievements    │
│                 │      │ availability    │
└─────────────────┘      └─────────────────┘
        │
        │
        ▼
┌─────────────────┐
│   SnsLink       │
├─────────────────┤
│ id              │PK
│ user_id         │FK
│ platform        │ (Twitter, LINE, etc.)
│ url             │
│ visible_after_  │
│   match         │
└─────────────────┘

┌─────────────────┐      ┌─────────────────┐
│    Skill        │◄────►│   UserSkill     │
├─────────────────┤      ├─────────────────┤
│ id              │PK    │ id              │PK
│ name            │      │ user_id         │FK
│ category        │      │ skill_id        │FK
│ usage_count     │      │ proficiency_level│
└─────────────────┘      │ years_experience│
        ▲                └─────────────────┘
        │
        │
┌─────────────────┐
│  ProjectSkill   │
├─────────────────┤
│ id              │PK
│ project_id      │FK
│ skill_id        │FK
│ required_level  │
│ is_primary      │
└─────────────────┘
        │
        ▼
┌─────────────────┐
│    Project      │
├─────────────────┤
│ id              │PK
│ owner_id        │FK (User)
│ title           │
│ purpose         │
│ description     │
│ people_needed   │
│ estimated_period│
│ category        │
│ status          │ (draft/active/closed)
│ published_at    │
└─────────────────┘
        │
        ├──────────────┬──────────────┐
        ▼              ▼              ▼
┌─────────────┐  ┌──────────┐  ┌──────────┐
│   Scout     │  │Application│ │  Match   │
├─────────────┤  ├──────────┤  ├──────────┤
│ id          │PK│ id       │PK│ id       │PK
│ project_id  │FK│ project_id│FK│ user_id  │FK
│ scout_user_id│FK│ applicant_id│FK│ partner_id│FK
│ scouted_user_id│FK│ message│  │ project_id│FK
│ message     │  │ status   │  │ scout_id │FK
│ status      │  └──────────┘  │ application_id│FK
└─────────────┘                │ matched_at│
                               └──────────┘
```

#### 主要テーブル説明

**Users（ユーザー）**
- Deviseによる認証機能
- 1ユーザーが2つのプロフィールを持つ（ProjectOwnerProfile、SkillHolderProfile）

**ProjectOwnerProfile（プロジェクトオーナープロフィール）**
- Userと1:1の関係
- プロジェクトを立ち上げる側の情報

**SkillHolderProfile（スキルホルダープロフィール）**
- Userと1:1の関係
- スキルを提供する側の情報

**SnsLinks（SNS連絡先）**
- Userと1:多の関係
- マッチング後に開示される連絡先情報
- `visible_after_match`フラグでマッチング後の公開を制御

**Skills（スキル）**
- 動的に作成可能なタグシステム
- グローバルに共有（全ユーザーが同じスキルマスタを使用）
- `usage_count`で人気スキルをトラッキング

**UserSkills（ユーザー-スキル中間テーブル）**
- 多対多の関係を実現
- 熟練度レベル、経験年数を保存

**Projects（プロジェクト）**
- `owner_id`でUserと紐づけ
- `status`: draft（下書き）/active（公開中）/closed（終了）
- `published_at`で公開日時を記録

**ProjectSkills（プロジェクト-スキル中間テーブル）**
- プロジェクトに必要なスキルを管理
- `required_level`で必要レベルを指定
- `is_primary`で主要スキルをマーク

**Scouts（スカウト）**
- プロジェクトオーナーからスキルホルダーへの誘い
- `status`: pending/accepted/rejected
- `scout_user_id`: スカウトを送った人
- `scouted_user_id`: スカウトを受けた人

**Applications（応募）**
- スキルホルダーからプロジェクトへの応募
- `status`: pending/accepted/rejected
- `applicant_id`: 応募した人

**Matches（マッチング）**
- Scout + Application = Match の双方向マッチング
- 各マッチングにつき2つのレコードを作成（双方向）
- `scout_id`と`application_id`で元のレコードを参照

### 3.3 モデル層の実装

#### 主要モデルとその責務

**User（app/models/user.rb）**
```ruby
# 主な責務
- Deviseによる認証機能
- 2つのプロフィール（ProjectOwnerProfile、SkillHolderProfile）の管理
- スキル、プロジェクト、SNSリンクとのアソシエーション
- スカウト・応募・マッチングとの関連付け

# 重要なアソシエーション
has_one :project_owner_profile
has_one :skill_holder_profile
has_many :sns_links
has_many :user_skills
has_many :skills, through: :user_skills
has_many :projects, foreign_key: :owner_id
has_many :sent_scouts, foreign_key: :scout_user_id, class_name: 'Scout'
has_many :received_scouts, foreign_key: :scouted_user_id, class_name: 'Scout'
has_many :applications, foreign_key: :applicant_id
has_many :matches
```

**Project（app/models/project.rb）**
```ruby
# 主な責務
- プロジェクト情報の管理
- ステータス管理（draft/active/closed）
- 必要スキルとの関連付け
- スカウト・応募・マッチングの集約

# 重要なメソッド
scope :active, -> { where(status: 'active') }
scope :draft, -> { where(status: 'draft') }

def publish
  update(status: 'active', published_at: Time.current)
end

# カテゴリ定義
CATEGORIES = %w[web mobile design video music business other].freeze
```

**Match（app/models/match.rb）**
```ruby
# 主な責務
- 双方向マッチングの作成
- Scout + Application の組み合わせチェック
- 重複マッチングの防止

# 重要なクラスメソッド
def self.create_bidirectional_match(scout, application)
  transaction do
    scout.lock!
    application.lock!

    scout.update!(status: 'accepted')
    application.update!(status: 'accepted')

    # 2つのMatchレコードを作成（双方向）
    create!([
      {
        user_id: scout.scout_user_id,
        partner_id: scout.scouted_user_id,
        project_id: scout.project_id,
        scout_id: scout.id,
        application_id: application.id,
        matched_at: Time.current
      },
      {
        user_id: scout.scouted_user_id,
        partner_id: scout.scout_user_id,
        project_id: scout.project_id,
        scout_id: scout.id,
        application_id: application.id,
        matched_at: Time.current
      }
    ])
  end
rescue ActiveRecord::RecordNotUnique
  # 既にマッチング済み
end
```

**Scout（app/models/scout.rb）**
```ruby
# 主な責務
- スカウト情報の管理
- after_createコールバックでマッチングチェック

# 重要なメソッド
after_create :check_and_create_match

def check_and_create_match
  application = Application.find_by(
    project: project,
    applicant: scouted_user,
    status: 'pending'
  )

  if application
    Match.create_bidirectional_match(self, application)
  end
end
```

**Application（app/models/application.rb）**
```ruby
# 主な責務
- 応募情報の管理
- after_createコールバックでマッチングチェック

# Scoutモデルと対称的な実装
after_create :check_and_create_match

def check_and_create_match
  scout = Scout.find_by(
    project: project,
    scouted_user: applicant,
    status: 'pending'
  )

  if scout
    Match.create_bidirectional_match(scout, self)
  end
end
```

**Skill（app/models/skill.rb）**
```ruby
# 主な責務
- スキルマスタの管理
- 動的なスキル作成
- 使用回数のトラッキング

# 重要なメソッド
validates :name, presence: true, uniqueness: { case_sensitive: false }

before_save :normalize_name

def normalize_name
  self.name = name.strip.titleize
end

# 使用回数を増やす
def increment_usage
  increment!(:usage_count)
end
```

### 3.4 コントローラ層の実装

#### ApplicationController（app/controllers/application_controller.rb）
```ruby
# 主な責務
- 全コントローラの基底クラス
- モード切り替え機能の実装
- マッチングSNS通知の管理

# 重要なメソッド
before_action :set_current_mode
before_action :check_match_sns_notification

helper_method :current_mode, :project_owner_mode?, :skill_holder_mode?

def set_current_mode
  session[:current_mode] ||= 'project_owner'
end

def check_match_sns_notification
  if session[:show_match_sns].present?
    @match_sns_data = {
      partner: User.find_by(id: session[:show_match_sns]['partner_id']),
      project: Project.find_by(id: session[:show_match_sns]['project_id'])
    }
    session.delete(:show_match_sns)
  end
end
```

#### HomeController（app/controllers/home_controller.rb）
```ruby
# 主な責務
- ダッシュボード表示
- レコメンデーション機能
- モード切り替え

def index
  if project_owner_mode?
    # プロジェクトオーナー向けレコメンド
    @recommended_skill_holders = RecommendationService.recommended_skill_holders(current_user)
  else
    # スキルホルダー向けレコメンド
    @recommended_projects = RecommendationService.recommended_projects(current_user)
  end
end

def switch_mode
  session[:current_mode] = params[:mode]
  redirect_to root_path
end
```

#### ProjectsController（app/controllers/projects_controller.rb）
```ruby
# 主な責務
- プロジェクトのCRUD操作
- 公開/非公開の管理
- 応募者一覧の表示

# 重要なアクション
def create
  @project = current_user.projects.build(project_params)
  @project.status = 'draft'
  # ...
end

def publish
  @project.update(status: 'active', published_at: Time.current)
  redirect_to @project, notice: 'プロジェクトを公開しました'
end
```

#### ScoutsController（app/controllers/scouts_controller.rb）**
```ruby
# 主な責務
- スカウトの作成・管理
- スカウト承認・却下
- マッチング成立時のSNS情報セット

def create
  @scout = Scout.new(
    project: @project,
    scout_user: current_user,
    scouted_user: @user,
    message: params[:message],
    status: 'pending'
  )
  @scout.save
end

def accept
  match_created = false
  ActiveRecord::Base.transaction do
    @scout.update!(status: 'accepted')
    match = @scout.check_and_create_match
    match_created = match.present?
  end

  if match_created
    session[:show_match_sns] = {
      partner_id: @scout.scout_user.id,
      project_id: @scout.project.id
    }
  end
end
```

#### SearchController（app/controllers/search_controller.rb）**
```ruby
# 主な責務
- プロジェクト/スキルホルダーの検索
- モード別の検索ロジック

def index
  if project_owner_mode?
    # スキルホルダーを検索
    @users = User.joins(:skills)
                 .where(skills: { id: @skill_ids })
                 .distinct
                 .page(params[:page])
  else
    # プロジェクトを検索
    @projects = Project.active
                       .where('title LIKE ? OR purpose LIKE ?', "%#{@query}%", "%#{@query}%")
                       .page(params[:page])
  end
end
```

### 3.5 サービス層の実装

#### RecommendationService（app/services/recommendation_service.rb）
```ruby
# 主な責務
- スキルベースのレコメンデーション
- タグマッチングアルゴリズム

class RecommendationService
  # スキルホルダー向け：スキルにマッチするプロジェクトを推薦
  def self.recommended_projects(user)
    Project.active
           .joins(:project_skills)
           .where(project_skills: { skill_id: user.skill_ids })
           .group('projects.id')
           .order('COUNT(project_skills.id) DESC')
           .limit(10)
  end

  # プロジェクトオーナー向け：プロジェクトに必要なスキルを持つ人を推薦
  def self.recommended_skill_holders(user)
    project = user.projects.active.first
    return [] unless project

    User.joins(:user_skills)
        .where(user_skills: { skill_id: project.skill_ids })
        .where.not(id: user.id)
        .group('users.id')
        .order('COUNT(user_skills.id) DESC')
        .limit(10)
  end
end
```

### 3.6 ビュー層の実装

#### レイアウト構造
```
app/views/
├── layouts/
│   └── application.html.erb    # 共通レイアウト
│       ├── ナビゲーションバー
│       ├── フラッシュメッセージ
│       ├── マッチング成立モーダル
│       └── yieldでコンテンツ挿入
├── home/
│   └── index.html.erb          # ダッシュボード
│       ├── プロフィールカード
│       ├── スキル管理
│       ├── レコメンデーション
│       └── 統計情報
├── projects/
│   ├── index.html.erb          # プロジェクト一覧
│   ├── show.html.erb           # プロジェクト詳細
│   │   ├── 応募者一覧（オーナーのみ）
│   │   ├── 応募フォーム（ホルダー）
│   │   └── 公開ボタン（下書きの場合）
│   ├── new.html.erb            # 新規作成
│   └── edit.html.erb           # 編集
├── search/
│   └── index.html.erb          # 検索画面
│       ├── スキルホルダー検索
│       │   └── スカウトモーダル
│       └── プロジェクト検索
├── matches/
│   ├── index.html.erb          # マッチング一覧
│   └── show.html.erb           # マッチング詳細
└── profiles/
    ├── project_owner_profiles/
    │   └── edit.html.erb
    └── skill_holder_profiles/
        └── edit.html.erb
```

#### Stimulusコントローラ（JavaScript）

**skill_tags_controller.js**
```javascript
// 主な責務
// - スキルタグの検索・追加・削除
// - オートコンプリート機能
// - 新規スキルの作成

export default class extends Controller {
  static targets = ["input", "hiddenInput", "suggestions", "tagContainer"]
  static values = { selected: { type: Array, default: [] } }

  async search(event) {
    const query = event.target.value.trim()
    if (query.length < 2) return

    const response = await fetch(`/skills/autocomplete?q=${encodeURIComponent(query)}`)
    const skills = await response.json()
    this.renderSuggestions(skills, query)
  }

  selectSkill(event) {
    const skillId = parseInt(event.currentTarget.dataset.skillId)
    const skillName = event.currentTarget.dataset.skillName

    // 重複チェック
    if (this.selectedValue.some(s => s.id === skillId)) return

    // 選択済みリストに追加
    this.selectedValue = [...this.selectedValue, { id: skillId, name: skillName }]
    this.renderTags()
    this.updateHiddenInput()
  }

  async createNewSkill(event) {
    const skillName = event.currentTarget.dataset.skillName

    const response = await fetch("/skills", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').content
      },
      body: JSON.stringify({ skill: { name: skillName, category: "other" } })
    })

    const skill = await response.json()
    this.selectedValue = [...this.selectedValue, { id: skill.id, name: skill.name }]
    this.renderTags()
  }
}
```

**skill_search_controller.js**
```javascript
// 主な責務
// - シンプルなスキル検索（ホーム画面用）
// - 選択したスキルの追加

export default class extends Controller {
  static targets = ["input", "suggestions", "skillId", "submitBtn"]

  async search() {
    const query = this.inputTarget.value.trim()
    const response = await fetch(`/skills/autocomplete?q=${encodeURIComponent(query)}`)
    const skills = await response.json()
    this.renderSuggestions(skills, query)
  }
}
```

### 3.7 ルーティング設計

```ruby
# config/routes.rb

Rails.application.routes.draw do
  # Devise（認証）
  devise_for :users

  # ルート
  root 'home#index'

  # モード切り替え
  post 'switch_mode', to: 'home#switch_mode'

  # プロフィール管理（名前空間）
  namespace :profiles do
    resource :project_owner_profile, only: [:edit, :update]
    resource :skill_holder_profile, only: [:edit, :update] do
      resources :portfolio_items
    end
  end

  # SNSリンク管理
  resources :sns_links, only: [:index, :create, :destroy]

  # プロジェクト（ネストされたスカウト・応募）
  resources :projects do
    member do
      post 'publish'  # 公開アクション
    end
    resources :scouts, only: [:create]
    resources :applications, only: [:create]
  end

  # スキル
  resources :skills, only: [:index, :create] do
    get 'autocomplete', on: :collection  # オートコンプリートAPI
  end

  # ユーザースキル
  resources :user_skills, only: [:create, :destroy]

  # スカウト管理
  resources :scouts, only: [:index, :show] do
    member do
      post 'accept'
      post 'reject'
    end
  end

  # 応募管理
  resources :applications, only: [:index, :show] do
    member do
      post 'accept'
      post 'reject'
    end
  end

  # マッチング
  resources :matches, only: [:index, :show]

  # 検索
  get 'search', to: 'search#index'
end
```

### 3.8 データフロー

#### スカウト→応募→マッチング成立の流れ

```
1. プロジェクトオーナーがスキルホルダーをスカウト
   ↓
   POST /projects/:project_id/scouts
   ↓
   ScoutsController#create
   ↓
   Scout.create(status: 'pending')
   ↓
   after_create :check_and_create_match
   ↓
   既存のApplicationをチェック
   ├─ なし → 何もしない
   └─ あり → Match.create_bidirectional_match(scout, application)

2. スキルホルダーがプロジェクトに応募
   ↓
   POST /projects/:project_id/applications
   ↓
   ApplicationsController#create
   ↓
   Application.create(status: 'pending')
   ↓
   after_create :check_and_create_match
   ↓
   既存のScoutをチェック
   ├─ なし → 何もしない
   └─ あり → Match.create_bidirectional_match(scout, application)

3. マッチング成立
   ↓
   Match.create_bidirectional_match
   ↓
   transaction do
     scout.update!(status: 'accepted')
     application.update!(status: 'accepted')
     Match.create!(user_id: A, partner_id: B, ...)
     Match.create!(user_id: B, partner_id: A, ...)
   end
   ↓
   session[:show_match_sns] = { partner_id, project_id }
   ↓
   リダイレクト
   ↓
   ApplicationController#check_match_sns_notification
   ↓
   @match_sns_data設定
   ↓
   layouts/application.html.erb
   ↓
   マッチングモーダル表示（相手のSNS連絡先を表示）
```

### 3.9 セキュリティ実装

#### 認証・認可
- **Devise**: ユーザー認証（セッション管理、パスワード暗号化）
- **before_action :authenticate_user!**: 全アクションで認証チェック
- **権限チェック**:
  - スカウト送信: プロジェクトオーナーのみ
  - 応募承認: プロジェクトオーナーのみ
  - スカウト承認: スカウト対象者のみ

#### CSRF対策
- Rails標準のCSRF保護（`csrf_meta_tags`）
- JavaScript（Stimulus）からのPOSTリクエストにCSRFトークン付与

#### SQL Injection対策
- ActiveRecordのパラメータバインディング使用
- 直接SQL文は使用せず、ORMを経由

#### XSS対策
- ERBの自動エスケープ
- `simple_format`などのヘルパー使用

### 3.10 デプロイ構成（Render）

#### インフラストラクチャ
```
┌─────────────────────────────────────────┐
│         Render (PaaS)                   │
├─────────────────────────────────────────┤
│                                         │
│  ┌───────────────────────────────────┐  │
│  │  Web Service (Free Tier)          │  │
│  │  - Ruby 3.3                       │  │
│  │  - Puma (2 workers)               │  │
│  │  - Rails 8.1.1                    │  │
│  │  - Stimulus                       │  │
│  │  - Bootstrap 5.3                  │  │
│  └───────────────┬───────────────────┘  │
│                  │                       │
│                  ▼                       │
│  ┌───────────────────────────────────┐  │
│  │  PostgreSQL 16 (Free Tier)        │  │
│  │  - Primary Database               │  │
│  │  - Cache Database                 │  │
│  │  - Queue Database                 │  │
│  │  - Cable Database                 │  │
│  └───────────────────────────────────┘  │
│                                         │
│  ┌───────────────────────────────────┐  │
│  │  File Storage                     │  │
│  │  - Active Storage (Local)         │  │
│  │  - Portfolio Images               │  │
│  └───────────────────────────────────┘  │
└─────────────────────────────────────────┘
```

#### ビルドプロセス（bin/render-build.sh）
```bash
#!/usr/bin/env bash
set -o errexit

# 1. Gemのインストール
bundle install

# 2. アセットのプリコンパイル
bundle exec rake assets:precompile
bundle exec rake assets:clean

# 3. CSSのビルド
npm install
npm run build:css

# 4. データベースマイグレーション
bundle exec rake db:migrate

# 5. シードデータの投入
bundle exec rake db:seed
```

#### 環境変数
```
RAILS_ENV=production
RAILS_MASTER_KEY=567e8c128d4e5bd6f8e8716e3b5252fa
DATABASE_URL=postgresql://...（Renderが自動設定）
BUNDLE_WITHOUT=development:test
WEB_CONCURRENCY=2
RAILS_LOG_TO_STDOUT=true
```

### 3.11 パフォーマンス最適化

#### データベースクエリ最適化
```ruby
# N+1問題の解消
@projects = Project.includes(:owner, :skills, :project_skills)
@applications = Application.includes(:applicant, applicant: :skills)

# ページネーション
@users = User.page(params[:page]).per(20)

# インデックス
add_index :scouts, [:project_id, :scouted_user_id], unique: true
add_index :applications, [:project_id, :applicant_id], unique: true
add_index :user_skills, [:user_id, :skill_id], unique: true
```

#### アセット最適化
```scss
// CSS変数の活用
:root {
  --pastel-blue: #a8d5e2;
  --soft-black: #2d3436;
}

// トランジション最適化
.card {
  transition: all 0.3s ease;
}
```

#### キャッシュ戦略
```ruby
# database.ymlで複数DB構成
production:
  primary: ...  # メインDB
  cache: ...    # キャッシュ用DB（Solid Cache）
  queue: ...    # ジョブキュー用DB（Solid Queue）
```

### 3.12 テスト戦略

#### テストファイル構成
```
test/
├── models/                 # モデルテスト
│   ├── user_test.rb
│   ├── project_test.rb
│   ├── match_test.rb
│   └── ...
├── controllers/            # コントローラテスト
│   ├── projects_controller_test.rb
│   ├── scouts_controller_test.rb
│   └── ...
├── system/                 # システムテスト（E2E）
└── fixtures/              # テストデータ
```

#### テストすべき重要ポイント
```ruby
# 双方向マッチングのロジック
test "scout + application creates bidirectional match" do
  scout = scouts(:one)
  application = applications(:one)

  match_count = Match.count
  Match.create_bidirectional_match(scout, application)

  assert_equal match_count + 2, Match.count
  assert_equal 'accepted', scout.reload.status
  assert_equal 'accepted', application.reload.status
end

# 重複マッチングの防止
test "prevents duplicate match creation" do
  # ...
end
```

---

## 4. 開発・運用情報

### 4.1 環境構築手順

#### ローカル開発環境
```bash
# リポジトリクローン
git clone https://github.com/Yukiof03/student-matching.git
cd student-matching

# 依存関係インストール
bundle install
npm install

# データベース作成・マイグレーション
rails db:create
rails db:migrate
rails db:seed

# CSSビルド
npm run build:css

# サーバー起動
rails server
```

### 4.2 GitHubリポジトリ
**URL**: https://github.com/Yukiof03/student-matching

### 4.3 デプロイ済みURL
**Render**: https://student-matching.onrender.com（設定後に更新）

### 4.4 今後の拡張可能性

#### 追加可能な機能
1. **リアルタイム通知**
   - Action CableによるWebSocket通信
   - スカウト・応募・マッチング時の即時通知

2. **レビュー・評価システム**
   - プロジェクト完了後の相互評価
   - 信頼スコアの導入

3. **チャット機能**
   - マッチング成立後の簡易チャット
   - 外部SNSに移行する前の初期コミュニケーション

4. **プロジェクト進捗管理**
   - タスク管理機能
   - マイルストーン設定

5. **分析ダッシュボード**
   - マッチング成功率
   - 人気スキルの統計
   - ユーザー行動分析

6. **外部API連携**
   - GitHub連携（ポートフォリオ自動取得）
   - Twitter API（プロフィール同期）

---

## 5. まとめ

### 5.1 実現できたこと
- ✅ デュアルプロフィールによる柔軟な役割切り替え
- ✅ 動的スキルタグシステムによる拡張性
- ✅ 双方向マッチングによる確実なマッチング成立
- ✅ SNS連絡先開示によるスムーズな連絡開始
- ✅ スキルベースのレコメンデーション
- ✅ 直感的なUI（パステルカラーテーマ）
- ✅ 本番環境へのデプロイ（Render）

### 5.2 技術的な学び
- Rails 8.1.1の最新機能（Solid Cache、Solid Queue）
- Stimulusによるモダンなフロントエンド開発
- PostgreSQLの複数データベース構成
- Render PaaSでのデプロイ手法
- 双方向マッチングアルゴリズムの実装

### 5.3 改善点・今後の課題
- パフォーマンステスト（大量データでの検証）
- セキュリティ監査（脆弱性診断）
- UXテスト（実際のユーザーからのフィードバック収集）
- モバイル対応の強化（PWA化）
- 国際化対応（i18n）

---

**作成日**: 2026年1月22日
**作成者**: Yukiof03
**プロジェクト**: Student Matching Social Network
**バージョン**: 1.0.0
