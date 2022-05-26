#!/bin/bash


is_ok=0

function check_ok_and_exit {
  if grep -qi "Done in" load_output.txt
  then
    echo "exiting"
    break
    exit 0
  fi
}

while [ $is_ok -eq 0 ]
do
  check_ok_and_exit
  yarn load 2>&1 | tee load_output.txt &
  pid=$!
  while true
    do
    check_ok_and_exit
      if grep -qi Error load_output.txt
      then
        kill $pid
        break
      fi
      sleep 10
  done
done

echo "Loading finished"

rm load_output.txt