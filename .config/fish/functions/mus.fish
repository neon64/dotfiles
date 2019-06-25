# starts the music player daemon and client
function mus
	switch (uname)
        case Linux
			if systemctl -q is-active --user mpd
				echo (set_color green)"Mpd already running" (set_color normal)
			else
				echo (set_color yellow)"Starting user service mpd" (set_color normal)
				systemctl --user start mpd
			end
			set current_song (mpc current)
			if test "$current_song" = ""
				echo "No song playing"
				read -P "YouTube search: " term 
				mpsyt /$term
			else
				ncmpcpp
			end
        case Darwin
            brew services run mpd
        case '*'
            echo "Unknown OS"
    end
end
