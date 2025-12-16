# 📖 ステップバイステップガイド

## 🎯 まず最初にやること

### ステップ1: ゲームをWebサイトとして公開する

**目的**: ゲームをインターネットで誰でも遊べるようにする

#### 方法A: Vercelを使う（簡単！）

1. **準備**
   - ブラウザで https://vercel.com を開く
   - 「Sign Up」をクリック
   - GitHubアカウントでログイン（なければ作る）

2. **アップロード**
   - 「Add New...」→「Project」をクリック
   - 「Upload」を選ぶ
   - `based_matching_game`フォルダをドラッグ&ドロップ

3. **デプロイ**
   - 「Deploy」ボタンをクリック
   - 30秒くらい待つ
   - URLが表示されます！例: `https://based-game-abc123.vercel.app`

4. **確認**
   - 表示されたURLをクリック
   - ゲームが開けば成功！

#### 方法B: Netlifyを使う

1. **準備**
   - ブラウザで https://netlify.com を開く
   - 「Sign up」をクリック

2. **アップロード**
   - 「Sites」→「Add new site」→「Deploy manually」
   - `based_matching_game`フォルダをドラッグ&ドロップ

3. **確認**
   - URLが表示されます
   - クリックしてゲームが開けば成功！

---

### ステップ2: Farcasterの設定ファイルを更新

**目的**: Farcasterがこのゲームをmini appとして認識できるようにする

1. **ファイルを開く**
   - `.well-known/farcaster.json`をテキストエディタで開く

2. **URLを変更**
   - `https://your-domain.com` を3箇所すべて
   - ステップ1で取得したURLに変更
   - 例: `https://based-game-abc123.vercel.app`

3. **保存**

4. **再アップロード**
   - 更新したファイルをVercel/Netlifyに再アップロード

---

### ステップ3: Farcasterでテスト

**目的**: 実際にFarcasterで動くか確認する

1. **Warpcastを開く**
   - スマホアプリまたは https://warpcast.com

2. **URLをシェア**
   - あなたのゲームURLを投稿またはDMで送る

3. **リンクをクリック**
   - リンクをクリックしてゲームが開けば成功！

---

## ✅ これで完了！

これで、Farcasterのmini appとして遊べるようになりました！

---

## 🔧 もっと詳しく知りたい場合

- **NFTミント機能**: 別途NFTコントラクトが必要です
- **accountAssociation**: Base Build Preview Toolで生成できます

