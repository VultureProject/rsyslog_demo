# Goal

In this exercice, you'll have to configure Rsyslog to:

1. Define a workflow to handle logs coming from the 514 port (8514 from host), as TCP, in the first rsyslog-1 container
2. Those logs should then be sent as UDP to the rsyslog-receiver container, on port 515
3. If the action fails (and **only** then), the logs should be sent to the rsyslog-backup container
4. If the second action also fails, logs should be kept in the rsyslog-1 container, using a Disk-assisted queue
5. NO LOGS should be lost! if rsyslog-receiver and/or rsyslog-backup stop during one moment, logs should be either kept in rsyslog-1 or sent to rsyslog-backup


# Caveats

**Be careful**: Rsyslog keeps a state file for each file read, so when starting your project multiple times using docker compose, make sure to delete previous containers using `docker compose down -v` to avoid those state files to be kept between runs and not having the input logs read again!