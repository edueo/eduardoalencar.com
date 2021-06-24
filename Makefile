dev:
	docker-compose up
deploy:
	hugo && rsync -avz --delete public/ linode:/var/www/eduardoalencarcom
