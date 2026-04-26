DEFAULT_NAME="spotify"

PLAYING_COLOR=0xffffffff
PAUSED_COLOR=0xffa6da95

MAIN_PLAYING_ICON=♬
MAIN_PAUSED_ICON=

PLAYER_PLAYING_ICON=󰏤
PLAYER_PAUSED_ICON=

update_playpause_icon() {
  case "$PLAYER_STATE" in
    "playing"|"Playing")
      ICON=$PLAYER_PLAYING_ICON
      ;;
    *)
      ICON=$PLAYER_PAUSED_ICON
      ;;
  esac

  sketchybar --set "$DEFAULT_NAME.playpause" icon=$ICON
}

update_track() {
  # Spotify JSON / $INFO comes in malformed, line below sanitizes it
  SPOTIFY_JSON="$INFO"

  if [[ ! -z $SPOTIFY_JSON ]]; then
    PLAYER_STATE=$(echo "$SPOTIFY_JSON" | jq -r '.["Player State"]')
    update_playpause_icon

    if [ $PLAYER_STATE = "Playing" ]; then
      TRACK="$(echo "$SPOTIFY_JSON" | jq -r .Name)"
      ARTIST="$(echo "$SPOTIFY_JSON" | jq -r .Artist)"

      sketchybar --set $NAME \
        label="${ARTIST} - ${TRACK}" \
        icon=$MAIN_PLAYING_ICON icon.color=$PLAYING_COLOR
    else
      sketchybar --set $NAME \
        label="" \
        icon=$MAIN_PAUSED_ICON icon.color=$PAUSED_COLOR
    fi
  else
    sketchybar --set $NAME \
      label="" \
      icon=$MAIN_PAUSED_ICON icon.color=$PAUSED_COLOR
  fi
}

mouse_clicked() {
  case "$NAME" in
    "$DEFAULT_NAME")
      open -a Spotify
      ;;
    "$DEFAULT_NAME.next")
      osascript -e 'tell application "Spotify" to play next track'
      ;;
    "$DEFAULT_NAME.playpause")
      osascript -e 'tell application "Spotify" to playpause'

      PLAYER_STATE=$(osascript -e 'tell application "Spotify" to player state')
      update_playpause_icon
      ;;
    "$DEFAULT_NAME.back")
      osascript -e 'tell application "Spotify" to play previous track'
      ;;
  esac
}

init() {
  SPOTIFY_JSON=$(osascript -e '
    tell application "Spotify"
      if player state is playing then
        set t to current track
        return "{\"Player State\":\"Playing\",\"Name\":\"" & (name of t) & "\",\"Artist\":\"" & (artist of t) & "\"}"
      else
        return "{\"Player State\":\"Paused\"}"
      end if
    end tell
  ')
  INFO="$SPOTIFY_JSON"

  update_track
}

case "$SENDER" in
  "mouse.clicked") 
  mouse_clicked
  ;;
  "spotify_startup") 
  init
  ;;
  *)
    if [[ "$NAME" = "$DEFAULT_NAME" ]]; then
      update_track
    fi
    ;;
esac
