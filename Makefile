dev:
	hugo server -D
deploy:
	hugo && rsync -avz --delete public/ eduardoalencar.com:/var/www/eduardoalencar.com/html
