#!/bin/sh

# Use full path to defaults command
INPUT_SOURCES="$(/usr/bin/defaults read ~/Library/Preferences/com.apple.HIToolbox.plist AppleSelectedInputSources 2>&1)"

# Check if Japanese input method is active
if echo "$INPUT_SOURCES" | grep -q "Kotoeri"; then
  INDICATOR="日本語"
else
  INDICATOR="英語"
fi

# Update the sketchybar item
sketchybar --set "$NAME" label="$INDICATOR"
