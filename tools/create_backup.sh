#!/bin/bash

ORO_DB_URL=$(grep -Po '(?<=ORO_DB_URL=).+' .env-app.local)

db_user=$(echo "$ORO_DB_URL" | sed -e 's|.*://\(.*\):.*@\S*|\1|')
db_pass=$(echo "$ORO_DB_URL" | sed -e 's|.*://.*:\(.*\)@\S*|\1|')
db_name=$(echo "$ORO_DB_URL" | sed -e 's|.*/\(.*\)?.*|\1|')
db_host=$(echo "$ORO_DB_URL" | sed -e 's|.*@\(.*\):.*|\1|')

backup_dir="./backup"

print_green() {
    echo -e "\e[32m$1\e[0m"
}
print_red() {
   echo -e "\e[31m$1\e[0m"
}

if [ ! -d "$backup_dir" ]; then
    mkdir "$backup_dir"
fi

current_datetime=$(date +"%Y%m%d_%H%M%S")

backup_string="${current_datetime}_${db_name}.sql"

ask_filename() {
    read -p "Please enter file name (${backup_string}): " filename
    echo "$filename"
}

new_filename=$(ask_filename)

if [ -n "$new_filename" ]; then
    backup_string="${new_filename}.sql"
fi

dbname="--dbname=postgresql://${db_user}:${db_pass}@${db_host}/${db_name}"
pg_dump "$dbname" > $backup_dir/$backup_string

print_green "DONE $backup_dir/$backup_string"
