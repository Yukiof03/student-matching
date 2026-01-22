# Student Matching Platform

学生向けプロジェクトマッチングプラットフォーム - 「やりたいことがある学生（プロジェクトオーナー）」と「スキルを活かしたい学生（スキルホルダー）」をつなぐWebアプリケーション

## 概要

このアプリケーションは、プロジェクトを立ち上げたい学生と、自分のスキルを活かしてプロジェクトに参加したい学生をマッチングするプラットフォームです。双方向のマッチング機能（スカウト・応募）により、効率的なチームビルディングを支援します。

## 主な機能

- **デュアルプロフィールシステム**: 各ユーザーがプロジェクトオーナーとスキルホルダーの両方のプロフィールを持ち、モード切り替えが可能
- **動的スキルタグシステム**: ユーザーが新しいスキルを自由に追加でき、全ユーザー間で共有
- **双方向マッチング**: スカウト機能と応募機能の両方をサポート
- **SNS連携**: マッチング成立時に相手のSNS連絡先（Twitter、Instagram、Discord、LINE等）を表示
- **検索機能**: スキル、カテゴリ、キーワードによる柔軟な検索
- **レコメンド機能**: ユーザーのスキルに基づいたプロジェクト提案

## 開発手法

本アプリケーションの開発では、初期段階においては自身で設計および基本的な機能実装、エラー修正を行った。その後、機能が増えロジックが複雑化した段階では、設計方針やデータ構造を自ら定めた上で、Claude Code を実装支援ツールとして活用し、コード作成を効率化した。生成されたコードについては内容を確認・調整しながら統合しており、設計判断や動作検証は一貫して自身で行っている。

## 技術スタック

- **Ruby**: 3.3.x
- **Rails**: 8.1.1
- **Database**: PostgreSQL
- **Authentication**: Devise
- **Frontend**: Bootstrap 5.3, ERB templates, Stimulus
- **Deployment**: Render

## セットアップ

### 前提条件

- Ruby 3.3.x
- PostgreSQL
- Node.js (for importmap)

### インストール手順

```bash
# リポジトリをクローン
git clone <repository-url>
cd student_matching

# 依存関係をインストール
bundle install

# データベースをセットアップ
rails db:create
rails db:migrate
rails db:seed

# サーバーを起動
rails server
```

アプリケーションは http://localhost:3000 でアクセスできます。

### 開発用デモアカウント

開発環境では以下のデモアカウントが利用可能です：

- Email: `demo@example.com`
- Password: `password123`

## データベース設計

### 主要モデル

- **User**: ユーザーアカウント（Devise）
- **ProjectOwnerProfile**: プロジェクトオーナー用プロフィール
- **SkillHolderProfile**: スキルホルダー用プロフィール
- **Project**: プロジェクト情報
- **Skill**: スキルタグ（動的に追加可能）
- **Scout**: スカウト機能
- **Application**: プロジェクトへの応募
- **Match**: マッチング情報（双方向）
- **SnsLink**: SNS連絡先情報

### 主要な関連付け

- ユーザーは両方のプロフィール（ProjectOwnerProfile、SkillHolderProfile）を持つ
- プロジェクトはスキル、スカウト、応募、マッチと関連付けられる
- マッチは、スカウトまたは応募のいずれか（または両方）から作成される

## デプロイ

このアプリケーションはRenderにデプロイされています。

```bash
# 変更をプッシュすると自動デプロイ
git push origin main
```

## ライセンス

このプロジェクトは学習目的で作成されています。

## クレジット

### 使用ツール
- Claude Code (Anthropic) - 実装支援ツール

### サードパーティライブラリ
- Bootstrap 5.3 (MIT License) - https://getbootstrap.com
- Bootstrap Icons (MIT License) - https://icons.getbootstrap.com
- Devise (MIT License) - https://github.com/heartcombo/devise
- Kaminari (MIT License) - https://github.com/kaminari/kaminari
