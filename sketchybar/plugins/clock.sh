#!/bin/sh

# The $NAME variable is passed from sketchybar and holds the name of
# the item invoking this script:

#sketchybar --set "$NAME" label="$(date '+%d/%m %H:%M')"
sketchybar --set "$NAME" label="$(date '+%m月%d日 %H:%M')"

