#!/bin/bash


is_ok=0
LOAD_FILE=load_output.txt

function check_ok_and_exit {
  if test -f "$FILE" && grep -qi "Done in" $LOAD_FILE
  then
    echo "exiting"
    break
    exit 0
  fi
}

while [ $is_ok -eq 0 ]
do
  check_ok_and_exit
  yarn load 2>&1 | tee $LOAD_FILE &
  pid=$!
  while true
    do
    check_ok_and_exit
      if grep -qi Error $LOAD_FILE
      then
        kill $pid
        break
      fi
      sleep 10
  done
done

echo "Loading finished"

rm $LOAD_FILE