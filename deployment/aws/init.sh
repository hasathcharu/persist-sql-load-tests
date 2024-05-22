#!/bin/bash
# Ensure a command-line argument is provided
if [ -z "$1" ]; then
  echo "Usage: $0 {persist|mysql|persistnnative|spring}"
  exit 1
fi

cd ./envs || exit

docker stop $(docker ps -q)
docker rm $(docker ps -a -q)

# Execute the appropriate Docker command based on the argument
case $1 in
  persist)
    docker run -p 9090:9090 -d --name persist -e  "BAL_CONFIG_DATA=$(cat Config.toml)" hasathcharu/balpersist_load_tests:persist_v2
    ;;
  mysql)
    docker run -p 9090:9090 -d --name mysql -e  "BAL_CONFIG_DATA=$(cat MySql.toml)" hasathcharu/balpersist_load_tests:mysql_v2
    ;;
  persistnnative)
    docker run -p 9090:9090 -d --name persistnnative -e  "BAL_CONFIG_DATA=$(cat Config.toml)" hasathcharu/balpersist_load_tests:persist_nnative_v2
    ;;
  spring)
    docker run -p 9090:9092 -d --name spring -e  "SQL_URL=jdbc:mysql://persist-db.czyqygwyas3p.ap-south-1.rds.amazonaws.com:3306/spring_hospital" hasathcharu/balpersist_load_tests:springboot_v2
    ;;
  *)
    echo "Invalid argument: $1"
    echo "Usage: $0 {persist|mysql|persistnnative|spring}"
    exit 1
    ;;
esac

echo "Docker container for $1 started successfully."
