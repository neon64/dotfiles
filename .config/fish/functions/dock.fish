function dock
    cd laradock
    sudo docker-compose exec --user=laradock  workspace bash
	cd ..
end