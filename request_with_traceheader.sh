#!/usr/bin/env bash

for VARIABLE in {1..10}
do
 traceId=$(uuidgen | tr [:upper:] [:lower:] | sed 's/-//g')
 parentId=$(uuidgen | tr [:upper:] [:lower:] | sed 's/-//g' | cut -c1-16)
 #echo "$traceId-$parentId"
 curl --location --request GET 'http://localhost:8081/test' -H "traceParent: 00-$traceId-$parentId-01" -H 'tracestate: es=s:0.01'
 echo
 echo
done