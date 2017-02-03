#!/bin/sh

# エイリアスを全て削除する

export IFS="
"

for d in `curl -s 'localhost:9200/_cat/aliases' | awk '{ print $1,$2}'`
do
  alias=`echo $d | awk '{print $1}'`
  index=`echo $d | awk '{print $2}'`

  echo $alias","$index

  curl -XPOST localhost:9200/_aliases -d "{
  \"actions\": [
    { \"remove\" : { \"index\": \"${index}\", \"alias\": \"${alias}\" } }
  ]
}"
echo

done
