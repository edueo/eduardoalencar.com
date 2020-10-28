dev:
	hugo server -D
deploy:
	hugo && rsync -avz --delete public/ linode:/var/www/eduardoalencarcom
