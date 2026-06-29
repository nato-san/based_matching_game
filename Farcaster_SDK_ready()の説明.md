# Farcaster SDK ready()の説明

## 📍 現在の実装場所

`ready()`関数は、**`init()`関数の中**で呼ばれています。

**場所：** `index.html`の約1973行目

```javascript
async function init() {
  initConfig();
  initAssets();
  setupEventListeners();

  // Show start screen first
  showStartScreen();

  // Wait for Farcaster SDK to be available and call ready()
  const sdkAvailable = await waitForFarcasterSDK();
  if (sdkAvailable) {
    try {
      await window.farcaster.sdk.actions.ready();  // ← ここで呼ばれています
      console.log("Farcaster SDK ready() called successfully");
    } catch (e) {
      console.warn("Farcaster SDK initialization error:", e);
    }
  } else {
    console.warn("Farcaster SDK not available after waiting");
  }

  // Ensure start screen is still visible after ready()
  showStartScreen();
  // Render initial gallery
  renderGallery();
}
```

---

## 🔍 ドキュメントとの違い

### ドキュメントの形式（ESM import）

```javascript
import { sdk } from '@farcaster/miniapp-sdk'

// After your app is fully loaded and ready to display
await sdk.actions.ready()
```

### 現在の実装（CDN経由）

```javascript
// CDN経由で読み込んでいるため、window.farcaster.sdkを使う
await window.farcaster.sdk.actions.ready();
```

---

## ✅ 現在の実装は正しい

現在の実装は正しく動作しています。理由：

1. **CDN経由で読み込んでいる**
   - `<script src="https://cdn.jsdelivr.net/npm/@farcaster/miniapp-sdk/dist/index.min.js"></script>`
   - この場合、`window.farcaster.sdk`として利用可能

2. **適切なタイミングで呼ばれている**
   - アプリが完全に読み込まれた後
   - `init()`関数内で呼ばれている

3. **エラーハンドリングがある**
   - SDKが利用可能か確認してから呼んでいる

---

## 🔄 ドキュメントの形式に合わせる場合（オプション）

もしESM形式のimportを使いたい場合：

### ステップ1: CDNリンクを変更

```html
<!-- 元のCDNリンクを削除 -->
<!-- <script src="https://cdn.jsdelivr.net/npm/@farcaster/miniapp-sdk/dist/index.min.js"></script> -->

<!-- ESM形式で読み込む -->
<script type="module">
  import { sdk } from 'https://esm.sh/@farcaster/miniapp-sdk'
  
  // グローバル変数として保存
  window.farcasterSDK = sdk;
</script>
```

### ステップ2: ready()の呼び出しを変更

```javascript
async function init() {
  initConfig();
  initAssets();
  setupEventListeners();

  // Show start screen first
  showStartScreen();

  // Wait for Farcaster SDK to be available and call ready()
  if (window.farcasterSDK) {
    try {
      await window.farcasterSDK.actions.ready();  // ← 変更
      console.log("Farcaster SDK ready() called successfully");
    } catch (e) {
      console.warn("Farcaster SDK initialization error:", e);
    }
  } else {
    console.warn("Farcaster SDK not available");
  }

  // Ensure start screen is still visible after ready()
  showStartScreen();
  // Render initial gallery
  renderGallery();
}
```

---

## 🎯 まとめ

### 現在の実装

- ✅ **正しく動作している**
- ✅ **適切な場所で呼ばれている**（`init()`関数内）
- ✅ **エラーハンドリングがある**

### ドキュメントの形式との違い

- ドキュメント: ESM形式のimport（`import { sdk } from '@farcaster/miniapp-sdk'`）
- 現在の実装: CDN経由（`window.farcaster.sdk`）

**どちらも正しく動作します！**

---

## 💡 重要なポイント

1. **`ready()`は必ず呼ぶ必要がある**
   - 呼ばないと、ユーザーは無限のローディング画面を見ることになります

2. **アプリが完全に読み込まれた後に呼ぶ**
   - 現在の実装は`init()`関数内で呼ばれているので、適切です

3. **エラーハンドリングが重要**
   - SDKが利用可能か確認してから呼ぶ必要があります

---

現在の実装は正しく動作しているので、変更する必要はありません。

もしESM形式に変更したい場合は、上記の手順に従ってください。
