upserver:
	hugo server -D
deploy:
	hugo && rsync -avz --delete public/ root@linode_1:/var/www/eduardoalencar.website/html
