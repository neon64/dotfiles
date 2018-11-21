function dock
    cd laradock
    switch (uname)
        case Linux
            sudo docker-compose exec --user=laradock  workspace bash
        case Darwin
            docker-compose exec --user=laradock  workspace bash
        case '*'
            echo "Unknown OS"
    end
	cd ..
end