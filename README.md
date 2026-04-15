# PDF 轉 PNG — macOS 快速動作

在 Finder 對任何 PDF 按右鍵，即可將每一頁轉換為獨立的 PNG 檔案，自動儲存在與 PDF 相同的資料夾。

## 示範

Finder 中對 PDF 按右鍵 → **快速動作 → PDF 2 PNG** → 完成。
輸出檔案命名為 `檔名_p001.png`、`檔名_p002.png`，依此類推。

## 系統需求

- macOS 12 Monterey 以上
- [Homebrew](https://brew.sh)
- Ghostscript（由 `install.sh` 自動安裝）

## 安裝

### 一行安裝

```bash
curl -fsSL https://raw.githubusercontent.com/ichiehg0v/pdf-to-png-shortcut/master/install.sh | bash
```

> 💡 **資安小提醒**：執行任何 `curl ... | bash` 指令前，建議先在瀏覽器開啟網址，確認腳本內容沒有問題再執行。本專案的 install.sh 內容可以[點這裡直接查看](https://github.com/ichiehg0v/pdf-to-png-shortcut/blob/master/install.sh)。

### 手動安裝

```bash
# 1. Clone 此 repo
git clone https://github.com/ichiehg0v/pdf-to-png-shortcut.git
cd pdf-to-png-shortcut

# 2. 執行安裝腳本
bash install.sh
```

執行完後，依照畫面指示在 Shortcuts.app 中加入快速動作（約 1 分鐘）。

## `install.sh` 做了什麼

1. 檢查 Homebrew，若未安裝則自動安裝
2. 透過 `brew install ghostscript` 安裝 Ghostscript
3. 印出需要貼入 Shortcuts.app 的腳本內容與設定步驟

## Shortcuts 設定（一次性，約 1 分鐘）

1. 開啟 **Shortcuts.app**
2. 點右上角 **+** 新增捷徑
3. 點 **ⓘ**（右上角）→ 在「作為快速動作」下勾選 **Finder**
4. 搜尋「**執行 Shell 工序指令**」並加入
5. Shell 設為 `zsh`，傳送輸入設為「**為引數**」
6. 將 `shortcut-script.sh` 的內容貼入腳本欄位
7. 將捷徑命名為 **PDF 2 PNG**，關閉視窗（自動儲存）

## 畫質設定

編輯 `shortcut-script.sh` 中的 `-r` 數值來調整解析度：

| DPI | 適用情境 | 檔案大小 |
|-----|----------|----------|
| `150` | 螢幕閱讀 / 網路分享 | 小 |
| `200` | 預設，平衡畫質與大小 | 中 |
| `300` | 列印品質 | 大 |
| `600` | 最高畫質 | 非常大 |

## 輸出範例

`報告.pdf`（共 3 頁）轉換後產生：

```
報告_p001.png
報告_p002.png
報告_p003.png
```

## 運作原理

使用 [Ghostscript](https://www.ghostscript.com/) 將每頁 PDF 渲染為 24-bit RGB PNG，並開啟抗鋸齒（`-dTextAlphaBits=4 -dGraphicsAlphaBits=4`），確保文字與圖形清晰銳利。

## 常見問題

**Q：Finder 右鍵沒有出現「PDF 2 PNG」？**
先確認 Shortcuts.app 中該捷徑的 ⓘ 設定裡有勾選「Finder」。若還是沒出現，重啟 Finder：按 `Command + Option + Esc`，選擇 Finder，點「重新啟動」。

**Q：執行後沒有產生任何檔案？**
在終端機測試 Ghostscript 是否正常：
```bash
/opt/homebrew/bin/gs --version
```
若找不到指令，重新執行 `brew install ghostscript`。

**Q：Ghostscript 安裝失敗？**
```bash
brew uninstall ghostscript
brew install ghostscript
```

**Q：圖片太模糊？**
把 `shortcut-script.sh` 裡的 `-r200` 改成 `-r300`，重新在 Shortcuts.app 貼上更新後的腳本內容。

**Q：PNG 檔案太大？**
把 `-r200` 改成 `-r150` 可以大幅減少檔案大小，螢幕閱讀已經夠用。

## 移除

```bash
brew uninstall ghostscript
```

再到 Shortcuts.app 刪除該捷徑即可。

## 授權

MIT
