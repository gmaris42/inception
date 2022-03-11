# sudo service nginx stop 
# sudo rm -rf /home/gmaris/data/DB_WordPress
# sudo rm -rf /home/gmaris/data/Data_WordPress

YELLOW = \033[033m
GREEN = \033[032m
BLUE = \033[36m
RED = \033[031m
PURPLE = \033[35m
RESET = \033[0m


all: build 
		@echo "127.0.0.1 gmaris.42.fr" >> /etc/hosts

build:
		@echo "$(YELLOW)\tStarting Inception by gmaris $(RESET)"
		@mkdir -p /home/gmaris/data/DB_WordPress
		@mkdir -p /home/gmaris/data/Data_WordPress
		cd srcs && docker-compose -f docker-compose.yml up --build

stop:
		@echo "$(PURPLE)\tStoping Inception$(RESET)"
		cd srcs && docker-compose -f docker-compose.yml down
		@echo "$(GREEN)\tStoped$(RESET)"

prune: stop
		@cd srcs
		@echo "$(YELLOW)\tPrune docker$(RESET)"
		docker system prune -f
		docker volume prune -f
		@echo "$(GREEN)\tPruned$(RESET)"

doom: prune
		@echo "$(RED)\tDOOM$(RESET)"
		docker volume rm -f srcs_Data_WordPress
		docker volume rm -f srcs_DB_WordPress
		docker rmi -f $$(docker images -aq)
		@echo "$(RED)\tDOOMED PROJECT$(RESET)"

re: prune build
.PHONY: all perm stop clean prune
