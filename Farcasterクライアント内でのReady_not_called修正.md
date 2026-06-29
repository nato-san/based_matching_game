# Farcasterクライアント内での「Ready not called」エラー修正

## 🔍 問題

Farcasterクライアント（旧Warpcast）内で開いているのに、「Ready not called」エラーが出る。

## ✅ 修正内容

### 1. SDKの読み込み方法を改善

- `defer`属性を削除して、同期的に読み込む
- エラーハンドリングを追加
- 複数の読み込み方法を試す

### 2. `ready()`の呼び出しを強化

- **即座に呼び出す機能を追加**
  - SDKが検出されたら、すぐに`ready()`を呼ぶ
  - `init()`を待たない

- **複数のタイミングで呼び出す**
  - ページ読み込み時
  - DOMContentLoaded時
  - window.load時
  - `init()`関数内

- **最大試行回数を増加**
  - 200回 → 300回（15秒）
  - 即座の呼び出しは500回（25秒）まで試行

### 3. エラーログを改善

- より詳細なエラーメッセージを表示
- どの段階で失敗したかがわかるように

## 🔄 修正後の動作

1. **ページ読み込み時**: すぐにSDKの検出を開始
2. **SDK検出後**: 即座に`ready()`を呼ぶ（`init()`を待たない）
3. **`init()`実行時**: 再度`ready()`を呼ぶ（念のため）

## 📝 確認方法

### Mini Appでコンソールが開けない場合

Farcasterクライアント内でコンソールが開けない場合、以下の方法で確認できます：

#### 方法1: デバッグ用のアラートを追加

コードに一時的にアラートを追加して、`ready()`が呼ばれているか確認：

```javascript
// 一時的に追加（確認後削除）
alert("Ready called: " + (readyCalled ? "Yes" : "No"));
```

#### 方法2: 外部のデバッグツールを使う

- Farcasterクライアントの開発者モードを有効にする
- または、一時的に通常のブラウザで開いて確認

#### 方法3: ネットワークタブで確認

- ネットワークリクエストを確認
- SDKが読み込まれているか確認

## 🎯 次のステップ

1. **修正したコードをデプロイ**
2. **Farcasterクライアントで再度開く**
3. **読み込み画面が消えるか確認**

## ⚠️ まだエラーが出る場合

### 確認事項

1. **SDKが正しく読み込まれているか**
   - ネットワークタブでSDKファイルが読み込まれているか確認

2. **Farcasterクライアントのバージョン**
   - 最新版に更新されているか確認

3. **Manifestの設定**
   - `.well-known/farcaster.json`が正しく設定されているか確認

### 追加のデバッグ

もし可能であれば、一時的に通常のブラウザで開いて、コンソールで以下を確認：

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

修正が完了しました。デプロイして、Farcasterクライアントで再度試してください。

読み込み画面が消えるか確認してください。まだ問題がある場合は、具体的な症状を教えてください。
