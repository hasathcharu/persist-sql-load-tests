# Comparison of `Bal Persist` load performance with Ballerina `mysql` connector and Spring Boot

## Test Configuration

### AWS EC2 (Single Instance)
Free tier configuration, ie, the `t2.micro` class (1 vCPU, 1GB RAM) in the `ap-south-1` region. 
Following docker images were used for each test.

- Bal Persist - `docker.io/hasathcharu/balpersist_load_tests:persist_v2`
- MySql - `docker.io/hasathcharu/balpersist_load_tests:mysql_v1`
- Spring Boot `docker.io/hasathcharu/balpersist_load_tests:springboot_v2`

An Nginx server was used as a reverse proxy to forward all port `80` requests to port `9090`, where the containers were listening to.

### AWS RDS

A MySql instance with a `db.t3.micro` (2 vCPU, 1GB RAM) class. This is a managed database service running the MySQL8 Community Edition.

## Average Response Time

![Average Response Time Chart](./results/comparisons/Average%20Response%20Time%20(60%20users_second).svg)

## Standard Deviation in Response Time

![Std. Deviation in Response Time Chart](./results/comparisons/Std.%20Deviation%20in%20Response%20Time%20(60%20users_second).svg)

## Throughput

![Throughput Chart](./results/comparisons/Throughput%20(60%20users_second).svg)