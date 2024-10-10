# Goal

In this exercice, you'll have to configure Rsyslog to:

1. Use the ruleset defined to handle the logs received from the input file
2. Use an Rsyslog module to parse each line as a json object
3. Output the json keys parsed from the log, using an output module, in a /logs/output.log (using the 'json_object' template)
4. Handle parsing errors (will there be errors?), and send them raw (using 'raw_message' template) in a /logs/failure.log

# Caveats

**Be careful**: Rsyslog keeps a state file for each file read, so when starting your project multiple times using docker compose, make sure to delete previous containers using `docker compose down -v` to avoid those state files to be kept between runs and not having the input logs read again!