for pdf in "$@"; do
    dir=$(dirname "$pdf")
    base=$(basename "$pdf" .pdf)
    /opt/homebrew/bin/gs -dNOPAUSE -dBATCH -sDEVICE=png16m -r200 \
       -dTextAlphaBits=4 -dGraphicsAlphaBits=4 \
       -sOutputFile="${dir}/${base}_p%03d.png" "$pdf" 2>/dev/null
    echo "完成：$base"
done
