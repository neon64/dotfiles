function ytdl
    youtube-dl -o "~/Music/YouTube/%(title)s.%(ext)s" --extract-audio --metadata-from-title "%(artist)s - %(title)s" --add-metadata --audio-format mp3 "$argv"
end