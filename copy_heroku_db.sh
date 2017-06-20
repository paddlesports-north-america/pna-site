#!/bin/bash
# Stupid little script so I don't have to remember arcane command lines

if [ $# -ne 1 ]
then
  echo "Usage `basename $0` <destination_app>"
  exit 1
fi
heroku pg:backups:restore `heroku pg:backups public-url --app pna-prod` --app $1
