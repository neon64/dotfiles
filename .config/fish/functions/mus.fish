# starts the music player daemon and client
function mus
echo (set_color yellow) "Starting user service mopidy..." (set_color normal)
	switch (uname)
        case Linux
            systemctl --user start mopidy
        case Darwin
            brew services run mopidy
        case '*'
            echo "Unknown OS"
    end

	ncmpcpp
end