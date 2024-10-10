# Goal

In this exercice, you'll have to configure Rsyslog to:

1. Read raw logs from the /logs/input.log file (mounted by docker-compose), using an input module
2. Assign a ruleset for the logs received from the file
3. in that ruleset, you'll have to define an output module to send the logs, using the provided template, to a /logs/output.log file

# Caveats

**Be careful**: Rsyslog keeps a state file for each file read, so when starting your project multiple times using docker compose, make sure to delete previous containers using `docker compose down -v` to avoid those state files to be kept between runs and not having the input logs read again!
