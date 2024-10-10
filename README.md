# Context
Hello and welcome to this Rsyslog practical exercices suite!

The repository is composed of a docker image (available on Docker Hub as **vultureworker/rsyslog_demo:latest**),
and a list of exercises to present different aspects of the Rsyslog functionnalities and capabilities.

In each folder, you'll find files with:

- input/raw logs
- rsyslog configuration files (at least, parts of it ;))
- a docker-compose.yml file to start up and test the exercice

For each exercice, you'll have to resolve a specific problem, by changing/adding Rsyslog configuration files, adjusting existing configuration, adding some details in rulebases...

In each folder, you'll also find specific informations on what to do.


# Useful resources

During those exercices, you'll find useful some resources online:

- The [Rsyslog documentation](https://www.rsyslog.com/doc/index.html#): for all things related to Rsyslog configuration
- The [Liblognorm documentation](https://www.liblognorm.com/files/manual/index.html): for all things related to Rsyslog/liblognorm rulebases' syntax

A basic understanding of docker, networking, linux/unix and python might be necessary for some steps.

Have fun!
