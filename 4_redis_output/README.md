# Goal

In this exercice, you'll have to configure Rsyslog to:

1. Use the ruleset defined to handle the logs received from the input file, in the rsyslog-1 container
2. Send these logs to the redis instance created for the exercice, using an output redis module
    - in a Redis channel (pub/sub), called 'channel:logs'
    - hostname = 'redis'
    - port = 6379
3. In the rsyslog-2 container, subscribe to the Redis channel 'channel:logs', get the logs sent by the first rsyslog instance, and send them in a compressed log file /logs/compressed.log


# Caveats

**Be careful**: Rsyslog keeps a state file for each file read, so when starting your project multiple times using docker compose, make sure to delete previous containers using `docker compose down -v` to avoid those state files to be kept between runs and not having the input logs read again!