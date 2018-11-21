# used for Laravel applications + Docker
function dock_up
	cd laradock
	switch (uname)
        case Linux
            sudo systemctl start docker
			sudo docker-compose up -d mysql nginx workspace
        case Darwin
			docker-compose up -d mysql nginx workspace
        case '*'
            echo "Unknown OS"
    end
	cd ..
end
