create-links:

	-sudo ln -s `pwd`/backup.service /etc/systemd/system/backup.service
	-sudo ln -s `pwd`/backup.timer /etc/systemd/system/backup.timer
	sudo systemctl daemon-reload
	sudo systemctl enable backup.timer
	sudo systemctl start backup.timer