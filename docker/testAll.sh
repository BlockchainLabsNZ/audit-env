#!/bin/bash

{
  echo "Dynamic testing started";
  npm run blaTest & pid=$!
  PID_LIST+=" $pid";

  echo "Test coverage started";
  npm run blaCoverage & pid=$!
  PID_LIST+=" $pid";

  echo "Gas spending analysis started";
  npm run blaGas & pid=$!
  PID_LIST+=" $pid";

} done

trap "kill $PID_LIST" SIGINT

echo "Parallel tests have started";

wait $PID_LIST

echo
echo "All reports have done";