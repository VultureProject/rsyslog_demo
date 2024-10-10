# Goal

In this exercice, you'll have to configure Rsyslog to:

1. Use the ruleset defined to handle the logs received from the input file
2. Use RainerScript, an MMDB lookup module and lookup tables, to
    2.1. Get the month digits, from the month representation parsed as 'month_str'
    2.2. Concatenate all the date/time fields to generate a new 'timestamp' field, formatted as a valid RFC3339 timestamp field
    2.3. Enrich the log with a new 'mmdb_ret' field, using the ip_enrich.mmdb DB (and the MMDB lookup module), and the 'src_ip' field
    2.4. (bonus) Notice some enrichments are json-valid, parse them when necessary and add them as a valid json (rather thatn a string) in the 'mmdb_str' field

# Caveats

**Be careful**: Rsyslog keeps a state file for each file read, so when starting your project multiple times using docker compose, make sure to delete previous containers using `docker compose down -v` to avoid those state files to be kept between runs and not having the input logs read again!