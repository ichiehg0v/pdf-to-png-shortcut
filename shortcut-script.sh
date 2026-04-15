for pdf in "$@"; do
    dir=$(dirname "$pdf")
    base=$(basename "$pdf" .pdf)

    # 支援 Apple Silicon (/opt/homebrew) 與 Intel Mac (/usr/local)
    GS_CMD="/opt/homebrew/bin/gs"
    if [ ! -x "$GS_CMD" ]; then
        GS_CMD="/usr/local/bin/gs"
    fi

    $GS_CMD -dNOPAUSE -dBATCH -sDEVICE=png16m -r200 \
       -dTextAlphaBits=4 -dGraphicsAlphaBits=4 \
       -sOutputFile="${dir}/${base}_p%03d.png" "$pdf" 2>/dev/null
    echo "完成：$base"
done
