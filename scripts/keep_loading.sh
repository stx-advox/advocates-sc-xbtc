#!/bin/bash


is_ok=0

while [ $is_ok -eq 0 ]
do
  echo "sup"
  yarn load 2>&1 | tee load_output.txt &
  pid=$!
  echo $pid
  while true 
    do
      if grep -qi Error load_output.txt
      then
        kill $pid
        break
      fi
      sleep 10
  done

  echo "Loading finished"
  if grep -qi Error load_output.txt; then
    is_ok=0
    echo "Error found"
  else
    is_ok=1
    kill $pid
  fi
done

rm load_output.txt