# used for Laravel applications + Docker
function work
	cd laradock
	sudo docker-compose exec --user=laradock  workspace bash
	cd ..
end