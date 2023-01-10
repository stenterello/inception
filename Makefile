NAME=inception

all:
	echo "ddelladi.42.fr	localhost" | sudo tee -a /etc/hosts
	sudo docker-compose -f srcs/docker-compose.yaml up --build

stop:
	sudo docker-compose -f srcs/docker-compose.yaml down

clean:
	sudo docker-compose -f srcs/docker-compose.yaml down --volumes

prune:
	sudo docker system prune -f

re: prune all

.PHONY: all stop clean prune re
