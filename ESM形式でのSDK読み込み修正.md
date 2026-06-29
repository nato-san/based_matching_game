# ESM形式でのSDK読み込み修正

## 🔍 問題

Farcasterクライアント内で「Ready not called」エラーが続いている。

## ✅ 修正内容

### 1. ESM形式でSDKを読み込む（公式推奨方法）

公式ドキュメントによると、ESM形式でimportする方法が推奨されています。

**変更前：**
```html
<script src="https://cdn.jsdelivr.net/npm/@farcaster/miniapp-sdk/dist/index.min.js"></script>
```

**変更後：**
```html
<script type="module">
  import { sdk } from 'https://esm.sh/@farcaster/miniapp-sdk';
  window.farcasterSDK = sdk;
  
  // Call ready() as soon as SDK is loaded
  (async function() {
    try {
      await new Promise(resolve => setTimeout(resolve, 100));
      await sdk.actions.ready();
      console.log("✅ Farcaster SDK ready() called (ESM import)");
    } catch (e) {
      console.error("❌ Error calling ready() from ESM:", e);
    }
  })();
</script>
```

### 2. フォールバックとしてCDNも読み込む

ESM形式が動作しない場合に備えて、CDN経由の読み込みも残しています。

### 3. 複数のSDK検出方法を実装

- ESM形式で読み込んだSDK（`window.farcasterSDK`）
- CDN経由で読み込んだSDK（`window.farcaster.sdk`）

両方をチェックして、どちらかが利用可能になったら`ready()`を呼びます。

## 🔄 修正後の動作

1. **ページ読み込み時**: ESM形式でSDKを読み込む
2. **SDK読み込み後**: 即座に`ready()`を呼ぶ（100ms待機後）
3. **フォールバック**: CDN経由のSDKもチェック
4. **複数のタイミング**: 複数のタイミングで`ready()`を呼ぶ

## 📝 確認方法

### Mini Appでコンソールが開けない場合

Farcasterクライアント内でコンソールが開けない場合、以下の方法で確認できます：

#### 方法1: 一時的にアラートを追加

確認用に、一時的にアラートを追加できます（確認後は削除）：

```javascript
// 一時的に追加（確認後削除）
if (window.farcasterSDK) {
  alert("ESM SDK detected!");
} else if (window.farcaster && window.farcaster.sdk) {
  alert("CDN SDK detected!");
} else {
  alert("No SDK detected");
}
```

#### 方法2: ネットワークタブで確認

- ネットワークリクエストを確認
- `esm.sh`からのSDK読み込みを確認

## 🎯 次のステップ

1. **修正したコードをデプロイ**
2. **Farcasterクライアントで再度開く**
3. **読み込み画面が消えるか確認**

## ⚠️ まだエラーが出る場合

### 確認事項

1. **ESM形式の読み込みが動作しているか**
   - ネットワークタブで`esm.sh`からの読み込みを確認

2. **Farcasterクライアントのバージョン**
   - 最新版に更新されているか確認

3. **Manifestの設定**
   - `.well-known/farcaster.json`が正しく設定されているか確認

### 追加のデバッグ

もし可能であれば、一時的に通常のブラウザで開いて、コンソールで以下を確認：

```javascript
// SDKが読み込まれているか確認
console.log("window.farcasterSDK:", window.farcasterSDK);
console.log("window.farcaster:", window.farcaster);
console.log("window.farcaster.sdk:", window.farcaster?.sdk);
```

## 📚 参考

- [Farcaster Mini Apps Documentation](https://miniapps.farcaster.xyz/docs/getting-started#making-your-app-display)
- [SDK Actions Reference](https://miniapps.farcaster.xyz/docs/sdk/actions/ready)

---

修正が完了しました。デプロイして、Farcasterクライアントで再度試してください。

読み込み画面が消えるか確認してください。まだ問題がある場合は、具体的な症状を教えてください。
