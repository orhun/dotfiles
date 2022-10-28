#!/usr/bin/env bash

alias docker-ls-restart="docker container ls -q | xargs docker container inspect --format '{{ .Name }}: {{.HostConfig.RestartPolicy.Name}}'"
alias docker-stop-all="docker ps -q | xargs docker stop"
alias docker-compose-restart="docker compose up --force-recreate --build -d"
