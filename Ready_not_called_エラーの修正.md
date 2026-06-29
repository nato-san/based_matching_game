# "Ready not called" エラーの修正方法

## 🔍 エラーの原因

「Ready not called」エラーは、Farcaster Mini App SDKの`ready()`が呼ばれていないことを示しています。

**原因：**
1. SDKが読み込まれる前に`init()`が実行されている
2. SDKの検出に失敗している
3. `ready()`の呼び出しタイミングが遅い

## ✅ 修正内容

### 1. SDKの検出を改善

- 最大試行回数を100回 → 200回に増加
- 待機時間を100ms → 50msに短縮（より頻繁にチェック）
- 複数のSDKの場所をチェック

### 2. `ready()`の呼び出しを早期化

- `init()`関数の最初で`ready()`の呼び出しを開始
- 他の初期化処理をブロックしないように非同期で実行
- 5秒のタイムアウトを設定（永遠に待たない）

### 3. フォールバック機能を追加

- SDKが利用可能になったら、すぐに`ready()`を呼ぶ早期呼び出し機能
- `init()`が実行される前でも`ready()`を呼べるように

## 🔄 修正後の動作

1. **ページ読み込み時**: すぐにSDKの検出を開始
2. **SDK検出後**: 即座に`ready()`を呼ぶ
3. **`init()`実行時**: 再度`ready()`を呼ぶ（念のため）

## 📝 確認方法

### ブラウザのコンソールで確認

1. `F12` キーを押す（開発者ツールを開く）
2. 「Console」タブを開く
3. 以下のメッセージを確認：

**成功した場合：**
```
Farcaster SDK detected at attempt X
✅ Farcaster SDK ready() called successfully
```

または

```
✅ Farcaster SDK ready() called (early call)
```

**失敗した場合：**
```
Farcaster SDK not found after 200 attempts
```

## 🎯 次のステップ

1. **ページをリフレッシュ**（`F5` または `Command + R`）
2. **コンソールを確認**して、`ready()`が呼ばれているか確認
3. **読み込み画面が消えるか確認**

## ⚠️ まだエラーが出る場合

### 確認事項

1. **SDKが正しく読み込まれているか**
   - コンソールで `window.farcaster` を確認
   - `undefined` の場合は、SDKが読み込まれていません

2. **Farcasterクライアントで開いているか**
   - 通常のブラウザで開いている場合は、このエラーは表示されません
   - Farcasterクライアント（Warpcastなど）で開いている必要があります

3. **ネットワーク接続**
   - CDNからSDKが読み込めているか確認
   - ネットワークタブでSDKファイルの読み込みを確認

### 追加のデバッグ

コンソールで以下を実行：

```javascript
// SDKが読み込まれているか確認
console.log("window.farcaster:", window.farcaster);
console.log("window.farcaster.sdk:", window.farcaster?.sdk);
console.log("ready function:", window.farcaster?.sdk?.actions?.ready);
```

## 📚 参考

- [Farcaster Mini Apps Documentation](https://miniapps.farcaster.xyz/docs/getting-started#making-your-app-display)
- [SDK Actions Reference](https://miniapps.farcaster.xyz/docs/sdk/actions/ready)

---

修正が完了しました。ページをリフレッシュして、もう一度試してください。

まだエラーが出る場合は、コンソールに表示されているメッセージを教えてください。
