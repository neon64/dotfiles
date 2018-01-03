# used for Laravel applications + Docker
function dock_up
	cd laradock
	sudo systemctl start docker
	sudo docker-compose up -d mysql nginx workspace
	cd ..
end
