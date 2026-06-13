#!/bin/bash
OUTPUT_DIR="/tmp/clipboard-images"
mkdir -p "$OUTPUT_DIR"

TIMESTAMP=$(date +%Y%m%d-%H%M%S)
TIFF="$OUTPUT_DIR/$TIMESTAMP.tiff"
PNG="$OUTPUT_DIR/$TIMESTAMP.png"

osascript -e "
set imgData to (the clipboard as «class TIFF»)
set f to open for access POSIX file \"$TIFF\" with write permission
write imgData to f
close access f
" 2>/dev/null || {
  osascript -e 'display notification "No image in clipboard" with title "Clipboard"'
  exit 1
}

sips -s format png "$TIFF" --out "$PNG" >/dev/null 2>&1
rm "$TIFF"

echo -n "$PNG" | pbcopy
sleep 0.15
osascript -e 'tell application "System Events" to keystroke "v" using command down'
