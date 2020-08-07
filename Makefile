dev:
	hugo server -D
deploy:
	hugo && rsync -avz --delete public/ ../static.eduardoalencar.com
