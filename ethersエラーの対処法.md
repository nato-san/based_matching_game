# ethers is not defined エラーの対処法

## 🔍 エラーの原因

「ethers is not defined」エラーは、ethers.jsライブラリが正しく読み込まれていないことを意味します。

## ✅ 修正内容

1. **CDNリンクを変更**
   - 元: `https://cdn.ethers.io/lib/ethers-5.7.2.umd.min.js`
   - 新: `https://cdn.jsdelivr.net/npm/ethers@5.7.2/dist/ethers.umd.min.js`

2. **エラーチェックを追加**
   - mintNFT関数の最初で、ethers.jsが読み込まれているか確認

## 🔄 対処法

### 方法1: ページをリフレッシュ

1. ブラウザで `F5` キーを押す（または `Command + R`）
2. ページを再読み込み
3. もう一度「Mint NFT」を試す

### 方法2: キャッシュをクリア

1. ブラウザで `Ctrl + Shift + Delete`（Windows）または `Command + Shift + Delete`（Mac）
2. 「キャッシュされた画像とファイル」を選択
3. 「データを削除」をクリック
4. ページを再読み込み

### 方法3: ネットワーク接続を確認

1. インターネット接続を確認
2. CDNがブロックされていないか確認
3. ファイアウォールやプロキシの設定を確認

## 💡 確認方法

ブラウザのコンソール（開発者ツール）で確認：

1. `F12` キーを押す（開発者ツールを開く）
2. 「Console」タブを開く
3. 以下を入力：

```javascript
typeof ethers
```

**結果：**
- `"object"` と表示されれば → ethers.jsが読み込まれています ✅
- `"undefined"` と表示されれば → ethers.jsが読み込まれていません ❌

## 🎯 次のステップ

1. **ページをリフレッシュ**
2. **コンソールでethers.jsが読み込まれているか確認**
3. **もう一度「Mint NFT」を試す**

まだエラーが出る場合は、コンソールに表示されているエラーメッセージを教えてください。
