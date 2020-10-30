(conky | while read LINE; do xsetroot -name "$LINE"; done) &
guake &
nitrogen --restore &
exec dwm