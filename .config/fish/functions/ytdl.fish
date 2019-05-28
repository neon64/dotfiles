function ytdl
    mkdir -p "~/Music/YouTube"
    youtube-dl -o "~/Music/YouTube/%(title)s.%(ext)s" --extract-audio --metadata-from-title "%(artist)s - %(title)s" --add-metadata --audio-format m4a "$argv"
end
