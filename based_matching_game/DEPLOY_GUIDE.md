# 🎮 Farcaster Mini App デプロイガイド

## 📚 小学生にもわかる説明

このゲームをFarcasterのmini appとして公開する方法を、1つずつ説明します！

---

## 🎯 ステップ1: 無料でWebサイトを公開する

### ゲームをインターネットに置く

ゲームをインターネットで遊べるようにするには、**Webサイト**として公開する必要があります。

### 方法1: Vercelを使う（おすすめ）

1. **Vercelにアクセス**
   - ブラウザで https://vercel.com を開く
   - 「Sign Up」をクリック
   - GitHubアカウントでログイン（なければ作る）

2. **プロジェクトを作る**
   - 「Add New...」→「Project」をクリック
   - 「Import Git Repository」を選ぶ
   - または「Upload」でフォルダをアップロード

3. **デプロイする**
   - 「Deploy」ボタンをクリック
   - 少し待つと、URLが表示されます
   - 例: `https://based-matching-game.vercel.app`

### 方法2: Netlifyを使う

1. **Netlifyにアクセス**
   - ブラウザで https://netlify.com を開く
   - 「Sign up」をクリック

2. **フォルダをアップロード**
   - 「Sites」→「Add new site」→「Deploy manually」
   - `based_matching_game`フォルダをドラッグ&ドロップ

3. **URLを確認**
   - デプロイが完了するとURLが表示されます
   - 例: `https://based-matching-game.netlify.app`

---

## 🎯 ステップ2: Farcasterの設定ファイルを更新する

### 設定ファイルを編集

1. **`.well-known/farcaster.json`ファイルを開く**
   - テキストエディタで開く

2. **URLを変更する**
   - `https://your-domain.com` の部分を
   - ステップ1で取得したURLに変更
   - 例: `https://based-matching-game.vercel.app`
   - 3箇所すべて変更してください

3. **保存する**

### ⚠️ 重要: accountAssociationを生成する

`accountAssociation`の部分は、後で生成する必要があります：

1. **Base Build Preview Toolを使う方法**
   - https://build.base.org にアクセス
   - ログインして「Preview」→「Account Association」を開く
   - あなたのドメインを入力
   - 生成された`header`、`payload`、`signature`をコピー
   - `farcaster.json`に貼り付け

2. **または、まずは空のままでもOK**
   - 後で設定できます

---

## 🎯 ステップ3: 更新したファイルを再アップロード

### 変更を反映する

1. **更新したファイルをアップロード**
   - VercelやNetlifyに、更新した`farcaster.json`を再アップロード

2. **確認する**
   - ブラウザで `https://あなたのURL/.well-known/farcaster.json` にアクセス
   - 設定ファイルが表示されればOK！

---

## 🎯 ステップ4: Farcasterでテストする

### Warpcastで試す

1. **Warpcastを開く**
   - スマホアプリまたはWebサイトでWarpcastを開く

2. **URLをシェア**
   - あなたのゲームのURLを投稿またはDMで送る

3. **リンクをクリック**
   - リンクをクリックすると、ゲームが開きます！

---

## 📝 まとめ

1. ✅ VercelまたはNetlifyでWebサイトを公開
2. ✅ `farcaster.json`のURLを更新
3. ✅ 再アップロード
4. ✅ Warpcastでテスト

これで、Farcasterのmini appとして遊べるようになります！

---

## ⚠️ 注意事項

- **NFTミント機能を使うには**、別途NFTコントラクトをBaseチェーンにデプロイする必要があります
- コントラクトアドレスを`index.html`に設定してください

