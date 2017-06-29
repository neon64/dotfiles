# starts the music player daemon and client
function mus
	systemctl --user start mopidy
	ncmpcpp
end