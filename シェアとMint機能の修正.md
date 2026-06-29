# シェアボタンとNFT Mint機能の修正

## 🔍 問題

1. **シェアボタンの問題**
   - PCでは機能しない
   - スマホではFarcasterアプリが落ちる

2. **NFTのmintの問題**
   - PCではmintボタンを押しても反応がない
   - スマホでは「Ethers.js library is not loaded」エラー

## ✅ 修正内容

### 1. Ethers.jsの読み込みを改善

**変更点：**
- CDNリンクをより信頼性の高いものに変更
- 読み込み確認機能を追加
- スマホで読み込みが遅い場合に備えて、最大5秒待機

**修正前：**
```html
<script src="https://cdn.ethers.io/lib/ethers-5.7.2.umd.min.js"></script>
```

**修正後：**
```html
<script src="https://cdn.jsdelivr.net/npm/ethers@5.7.2/dist/ethers.umd.min.js"></script>
<script>
  // Verify ethers.js is loaded
  (function() {
    let attempts = 0;
    const maxAttempts = 100;
    function checkEthers() {
      attempts++;
      if (typeof ethers !== "undefined") {
        console.log("✅ Ethers.js loaded successfully");
        return;
      }
      if (attempts < maxAttempts) {
        setTimeout(checkEthers, 100);
      } else {
        console.error("❌ Ethers.js failed to load after", maxAttempts, "attempts");
      }
    }
    setTimeout(checkEthers, 100);
  })();
</script>
```

### 2. Mint機能の改善

**変更点：**
- Ethers.jsが読み込まれるまで最大5秒待機
- より明確なエラーメッセージを表示

**修正内容：**
```javascript
// Check if ethers is loaded - wait a bit if not immediately available
if (typeof ethers === "undefined") {
  // Wait a bit for ethers to load (especially on mobile)
  let ethersLoaded = false;
  for (let i = 0; i < 50; i++) {
    if (typeof ethers !== "undefined") {
      ethersLoaded = true;
      break;
    }
    await new Promise(resolve => setTimeout(resolve, 100));
  }
  
  if (!ethersLoaded) {
    alert("Ethers.js library is not loaded. Please refresh the page and try again.\n\nIf the problem persists, check your internet connection.");
    console.error("ethers is not defined after waiting");
    return;
  }
}
```

### 3. シェア機能の改善

**変更点：**
- ESM形式で読み込んだSDK（`window.farcasterSDK`）もチェック
- エラーハンドリングを改善
- 複数のフォールバック方法を実装
- `async/await`を使用して非同期処理を改善

**修正内容：**
```javascript
async function shareToFarcaster() {
  try {
    // Check ESM imported SDK first (preferred)
    if (window.farcasterSDK && window.farcasterSDK.actions && typeof window.farcasterSDK.actions.composeCast === 'function') {
      try {
        await window.farcasterSDK.actions.composeCast({
          text: shareText,
          embeds: [window.location.href]
        });
        return;
      } catch (e) {
        console.warn("⚠️ ESM SDK composeCast error:", e);
      }
    }
    
    // Check CDN loaded SDK
    if (window.farcaster && window.farcaster.sdk && window.farcaster.sdk.actions) {
      if (typeof window.farcaster.sdk.actions.composeCast === 'function') {
        try {
          await window.farcaster.sdk.actions.composeCast({
            text: shareText,
            embeds: [window.location.href]
          });
          return;
        } catch (e) {
          console.warn("⚠️ CDN SDK composeCast error:", e);
        }
      }
    }
    
    // Fallback: Web Share API or clipboard
    if (navigator.share) {
      try {
        await navigator.share({
          title: "Based Matching Game",
          text: shareText,
          url: window.location.href
        });
        return;
      } catch (err) {
        console.warn("⚠️ Web Share API failed:", err);
      }
    }
    
    // Final fallback: Copy to clipboard
    copyToClipboard(shareText);
    alert("Share text copied to clipboard! Paste it in Farcaster.");
    
  } catch (e) {
    console.error("❌ Share function error:", e);
    alert("Failed to share. Please try again.");
  }
}
```

## 🔄 修正後の動作

### シェア機能

1. **ESM形式のSDKをチェック** → `composeCast`を呼ぶ
2. **CDN形式のSDKをチェック** → `composeCast`を呼ぶ
3. **Web Share APIを試す**（モバイル）
4. **クリップボードにコピー**（フォールバック）

### Mint機能

1. **Ethers.jsが読み込まれるまで待機**（最大5秒）
2. **読み込まれない場合はエラーメッセージを表示**
3. **読み込まれたら通常通りmint処理を実行**

## 📝 確認方法

### シェア機能

1. ゲームをクリア
2. 「Share on Farcaster」ボタンをクリック
3. シェアが成功するか確認

### Mint機能

1. ギャラリーを開く
2. 獲得した画像をクリック
3. 「Mint NFT」ボタンをクリック
4. エラーが出ないか確認

## 🎯 次のステップ

1. **修正したコードをデプロイ**
2. **PCとスマホの両方でテスト**
3. **シェア機能とMint機能が動作するか確認**

## ⚠️ まだ問題がある場合

### シェア機能

- Farcasterクライアント内で開いているか確認
- ネットワーク接続を確認
- コンソールでエラーメッセージを確認

### Mint機能

- インターネット接続を確認
- Ethers.jsが読み込まれているか確認（コンソールで`typeof ethers`を確認）
- ネットワークタブでethers.jsファイルが読み込まれているか確認

---

修正が完了しました。デプロイして、PCとスマホの両方でテストしてください。

まだ問題がある場合は、具体的な症状を教えてください。
