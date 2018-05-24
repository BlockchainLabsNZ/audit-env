#!/usr/bin/env bash

echo "Blockchainlabs, NZ (https://blockchainlabs.nz)"

# Exit script as soon as a command fails.
set -o errexit

# Executes cleanup function at script exit.
trap cleanup EXIT

cleanup() {
  # Kill the ganache-cli instance that we started (if we started one and if it's still running).
  echo "Test node (ganache-cli/testrpc-sc) PID: $ganache_cli_pid"
  if [ -n "$ganache_cli_pid" ] && ps -p $ganache_cli_pid > /dev/null; then
    echo "Killed."
    kill -9 $ganache_cli_pid
  fi
}

if [ "$SOLIDITY_COVERAGE" = true ]; then
  ganache_cli_port=8555
else
  ganache_cli_port=8545
fi

ganache-cli_running() {
  nc -z localhost "$ganache_cli_port"
}

ganache-cli() {
  if [ "$SOLIDITY_COVERAGE" = true ]; then
    node_modules/.bin/testrpc-sc --gasLimit 0xfffffffffff --gasPrice 0 --port "$ganache_cli_port" "$@"
  else
    node_modules/.bin/ganache-cli --gasLimit 0xfffffffffff --gasPrice 0 "$@"
  fi
}

if ganache-cli_running; then
  echo "Using existing ganache-cli instance"
else
  echo "Starting our own ganache-cli instance"
#   We define 10 accounts with balance 1M ether, needed for high-value tests.
  ganache-cli -h 0.0.0.0 \
    --account="0x2bdd21761a483f71054e14f5b827213567971c676928d9a1808cbfa4b7501200,1000000000000000000000000"  \
    --account="0x2bdd21761a483f71054e14f5b827213567971c676928d9a1808cbfa4b7501201,1000000000000000000000000"  \
    --account="0x2bdd21761a483f71054e14f5b827213567971c676928d9a1808cbfa4b7501202,1000000000000000000000000"  \
    --account="0x2bdd21761a483f71054e14f5b827213567971c676928d9a1808cbfa4b7501203,1000000000000000000000000"  \
    --account="0x2bdd21761a483f71054e14f5b827213567971c676928d9a1808cbfa4b7501204,1000000000000000000000000"  \
    --account="0x2bdd21761a483f71054e14f5b827213567971c676928d9a1808cbfa4b7501205,1000000000000000000000000"  \
    --account="0x2bdd21761a483f71054e14f5b827213567971c676928d9a1808cbfa4b7501206,1000000000000000000000000"  \
    --account="0x2bdd21761a483f71054e14f5b827213567971c676928d9a1808cbfa4b7501207,1000000000000000000000000"  \
    --account="0x2bdd21761a483f71054e14f5b827213567971c676928d9a1808cbfa4b7501208,1000000000000000000000000"  \
    --account="0x2bdd21761a483f71054e14f5b827213567971c676928d9a1808cbfa4b7501209,1000000000000000000000000"  \
  > /dev/null 2> /dev/null & #may want to remove the 2> devnull part if you want to see errors for some reason
  ganache_cli_pid=$(($!+2)) #somehow for my mac the eventual pid becomes +2 compared to $!
fi

echo "truffle start, $ganache_cli_pid"
./node_modules/.bin/truffle version

if [ "$SOLIDITY_COVERAGE" = true ]; then
  node_modules/.bin/solidity-coverage

  if [ "$CONTINUOUS_INTEGRATION" = true ]; then
    cat coverage/lcov.info | node_modules/.bin/coveralls
  fi
else
  node_modules/.bin/truffle test "$@"
fi
