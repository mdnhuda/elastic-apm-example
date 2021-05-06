## Purpose of this project
Forked from https://github.com/kamil-gawlik/elastic-apm-example

This is short presentation of Elastic APM set up.
This set of tools can be used to present flow of information in microservices based system, leting user find out which applications participate in communication and how long each step takes.

### Requirements

 - java 1.8
 - docker
 - docker-compose

### Used tools
 - kibana:7.3.1
 - elasticsearch:7.3.1
 - apm-server:7.3.1
 - apm-agent:1.9.0
 - springboot:2.1.7
 
### How to run

To run infrastructure execute:
```bash
    docker-compose up elasticsearch kibana apm 
```

To run apps, execute in `server` and `frontend` folders:

```bash

    ./mvnw clean package
    docker-compose up --build server frontend
```

##### Check if everything is running:

Server is available at:
[link](http://localhost:8082/test)

Frontend is available at:
[link](http://localhost:8081/test)

Kibana should be available at [link](http://localhost:5601) with no errors

You can check if infrastructure is in place visiting [kibana apm setup](http://localhost:5601/app/kibana#/home/tutorial/apm?_g=())

Apm page is available at [link](http://localhost:5601/app/apm#/services?rangeFrom=now-24h&rangeTo=now&refreshPaused=true&refreshInterval=0)
Chose frontend and on the bottom of the page select transaction. If no transactions are available visit [frontend](http://localhost:8081/test) 
to generate some traffic and refresh kibana's apm page.

### Available data

 If everything is up and running explore available data.
 
 - Choose `frontend` as a service which stats you will explore
 ![frontend service selection](./docs/images/apm_services.png)

 - You can see stats like transaction duration and request per minute charts. Let's explore one of the transactions.
 Choose `FrontendRestEndpoint#test` from transactions list at the bottom of the page
 ![frontend service selection](./docs/images/apm_transactions.png)

 - Have a look on transaction sample at the bottom of the page and it's content
    - services participating in transaction (frontend and server)
    - timeline of transaction
    - custom scope of operation shown on timeline (longRunningMethod)
    - duration of executed sql query (bottom line) and query itself 
    
 ![frontend service selection](./docs/images/apm_transaction_sample.png)

### Passing Open Tracing Header
Sample request:
``` 
curl --location --request GET 'http://localhost:8081/test' \
  --header 'traceparent: 00-13bf7366817b40b68c03c8c9a5ab983b-c52f5b687dfcd7f4-01' \
  --header 'tracestate: es=s:0.01'

```
or
```bash
./request_with_traceheader.sh
```

### Troubleshooting
 
 - APM may not be not available after firs start, try:
 ```bash
     docker-compose -f infrastructure/docker-compose.yml restart apm
 ```
 
 - If your have an obscure problem with elasticsearch shards please try:
```bash
curl -XPUT -H 'Content-Type: application/json' 'localhost:9200/_settings' -d '
{
    "index" : {
        "number_of_replicas" : 0
    }
}'

```
