# 支援 Apple Silicon (/opt/homebrew) 與 Intel Mac (/usr/local)
GS_CMD="/opt/homebrew/bin/gs"
if [[ ! -x "$GS_CMD" ]]; then
    GS_CMD="/usr/local/bin/gs"
fi
if [[ ! -x "$GS_CMD" ]]; then
    print -u2 '找不到 Ghostscript，請先安裝。'
    exit 1
fi

failed=0
for selected in "$@"; do
    pdf=${selected:a}
    if [[ ! -f "$pdf" || ${pdf:e:l} != pdf ]]; then
        print -ru2 -- "略過非 PDF 檔案：$selected"
        failed=1
        continue
    fi

    # 每次在同一資料夾建立獨立目錄，保留既有檔案。
    output_dir=$(mktemp -d "${pdf:h}/${pdf:t:r}_png.XXXXXX") || {
        failed=1
        continue
    }

    if (
        cd -- "$output_dir" &&
        "$GS_CMD" -dSAFER -dNOPAUSE -dBATCH -dPDFSTOPONERROR -sDEVICE=png16m -r200 \
            -dTextAlphaBits=4 -dGraphicsAlphaBits=4 \
            -sOutputFile='page-%03d.png' -f "$pdf"
    ); then
        print -r -- "完成：$output_dir"
    else
        print -ru2 -- "轉換失敗，請檢查部分輸出：$output_dir"
        failed=1
    fi
done
exit "$failed"
