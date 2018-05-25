#!/bin/bash
  echo "Dynamic testing started";
  npm run blaTest > audit/dynamic-testing.txt & pid=$!
  PID_LIST+=" $pid";

  echo "Test coverage started";
  npm run blaCoverage > audit/test-coverage.txt & pid=$!
  PID_LIST+=" $pid";

  echo "Gas spending analysis started";
  npm run blaGas > audit/gas-spending.txt & pid=$!
  PID_LIST+=" $pid";


trap "kill $PID_LIST" SIGINT

echo "Parallel tests have started";

wait $PID_LIST

echo
echo "All reports have done";