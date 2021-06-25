# thrift-http-server-docker
Thrift server container running spark hive thrift server over http binding and cliservice endpoint

Popular BI tools like PowerBI and Tableau cannot access spark over standard thriftserver 10000 RPC port
This docker container launches Thrift server with the HTTP binding configured for 10001 port:

http://localhost:10001/cliservice

Typical service configuration in the docker-compose.yml looks like this:

```yml
# spark http thrift server that offer HTTB RPC endpoint
# used by many BI tools such as powerbi and tabelau
# and allows execution of the HIVE SQL with Spark workers
# this server exposes http://localhost:10001/cliservice endpoint
  thrift-server:
    #image: bde2020/spark-worker
    container_name: thrift-server
    hostname: thrift-server
    image: stellars/thrift-server:3.1.1-hadoop3.2
    build:
       context: $PWD/build/thrift-http-server-docker
       dockerfile: Dockerfile
    environment:
       SPARK_MASTER: "spark://spark-master:7077"
       SERVICE_PRECONDITION: "hive-metastore:9083"
    env_file:
      - ./hadoop-hive.env
      - ./hadoop-hive-http.env
    ports:
       - "10001:10001"
    volumes:
       - $PWD/work:/opt/workspace
    #command: /usr/bin/tail -F /dev/null
    networks:
       - localnet
```

