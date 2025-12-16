# 🚀 最も簡単なデプロイ方法

## 方法1: Netlifyを使う（おすすめ！ドラッグ&ドロップで簡単）

### ステップ1: Netlifyにアクセス
1. ブラウザで https://www.netlify.com を開く
2. 「Sign up」をクリック（無料で登録できます）

### ステップ2: フォルダをアップロード
1. ログインしたら、画面の真ん中に「Sites」というページが開きます
2. 画面の下の方に「Want to deploy a new site without connecting to Git?」という文字があります
3. その下に「Drag and drop your site output folder here」という四角い枠があります
4. **`based_matching_game`フォルダ全体**をその枠にドラッグ&ドロップします

### ステップ3: 完了！
1. 少し待つと、自動的にデプロイが始まります
2. 完了すると、URLが表示されます
   - 例: `https://random-name-12345.netlify.app`
3. このURLをコピーしてください

### ステップ4: 設定ファイルを更新
1. `.well-known/farcaster.json`を開く
2. `https://your-domain.com` を3箇所すべて、Netlifyで取得したURLに変更
3. 保存

### ステップ5: 再アップロード
1. Netlifyのサイトページに戻る
2. 同じように、更新したフォルダを再度ドラッグ&ドロップ
3. 完了！

---

## 方法2: Vercelを使う（GitHubが必要）

Vercelで直接アップロードするには、GitHubを使う必要があります。

### ステップ1: GitHubにアップロード
1. https://github.com にアクセス
2. アカウントを作成（なければ）
3. 「New repository」をクリック
4. リポジトリ名を入力（例: `based-matching-game`）
5. 「Create repository」をクリック
6. 画面に表示される手順に従って、フォルダをアップロード

### ステップ2: Vercelで接続
1. https://vercel.com にアクセス
2. 「Add New...」→「Project」をクリック
3. 「Import Git Repository」を選ぶ
4. 作ったGitHubリポジトリを選ぶ
5. 「Deploy」をクリック

---

## 🎯 おすすめ

**Netlifyを使う方が簡単です！**
- ドラッグ&ドロップするだけ
- GitHubアカウント不要
- すぐにデプロイできる
