#!/bin/bash

mkdir -p audit

spinner()
{
    local pid=$!
    local delay=0.75
    local spinstr='|/-\'
    while [ "$(ps a | awk '{print $1}' | grep $pid)" ]; do
        local temp=${spinstr#?}
        printf " [%c]  " "$spinstr"
        local spinstr=$temp${spinstr%"$temp"}
        sleep $delay
        printf "\b\b\b\b\b\b"
    done
    printf "    \b\b\b\b"
}

echo "Test coverage analysis started";
docker run --rm -a STDOUT -v $(pwd)/contracts:/audit/contracts -v $(pwd)/test:/audit/test nzblabs/test-coverage > audit/test-coverage.txt & pid=$!
PID_LIST+=" $pid";

echo "Gas spending analysis started";
docker run --rm -a STDOUT -v $(pwd)/contracts:/audit/contracts -v $(pwd)/test:/audit/test nzblabs/gas-report > audit/gas-report.txt & pid=$!
PID_LIST+=" $pid";


trap "kill $PID_LIST" SIGINT

spinner & wait $PID_LIST

echo
echo "All reports have done.";