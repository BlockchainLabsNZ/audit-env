# Dynamic testing basic Env for your Smart Contracts Audit

This is specific environment we use for running Solidity tests in the form of a Docker image that you can download and run on your project.

<br>

## Prerequisites

- Smart contracts
- [Docker](https://docs.docker.com/install) installed and running (as a daemon)


<br>

## Typical environment we use for testing

- Environment
	- Ethereum blockchain
	- Solidity, Truffle
	- Mocha/Chai as testing framework
	
- Projects folders 	
	-  `/contracts` folder with smart contracts
	-  `/test` folder with tests

- Project files:
	-  `Migration.sol`, `1_initial_migration.js`, `2_deploy_contracts.js` for truffle migration
	-  `truffle.js` with networks settings
	-  `package.json` with dependencies and scripts

- Networks 
	- Testrpc, Ganache or Parity for testing
	- Kovan/Ropsten/Rinkeby testnetwork with Infura

<br>

## Installation and running

1. Download/clone/fork this repository.
- Copy `npm` commands from this repo's `package.json` to your project.
- Copy `testAll.sh` from this repo to your project.
- Go to you project folder that contains `/contracts` and `/test` folders.
	- Run `npm run blaTest` for dynamic testing
	- Run `npm run blaCoverage` for test coverage report
	- Run `npm run blaGas` for gas spending report
	- Run `npm run blaAll`  for simultaneous testing. Results will be printed to the same named files in the  `/audit` folder
	- Run `npm run blaPlay` to have your playground inside the container
		
		> There are VI and nano editors installed, so, feel free to change something, help yourself, its all yours. <br>
		> Press `Cntrl-D` to exit container.


Each run of these commands will create new Docker container, copy your contracts and tests from the project directory to the container’s volume and then run tests in our typical testing environment. Containers are self destroying on exit.

 
<br>

## Updating your environment configuration

If your tests are not working in our environment, we need to figure out *Why* and change the environment. 
It will take some time. You can save that (paid) time and update the configuration by yourself:

1. Go to the `/docker` folder.
- Update the `package.json` with new dependencies from **your** `package.json`, but keep it clean from unused dependencies (such as frontend packages, webpack configs and so on).
- Check *dockerfile* and update it if needed.
- Build new docker image: `docker build -t yourcompanyname/projectname` from **`/docker` folder**.
- Check that new Docker image is ready by running it in your **project folder**: `docker run --rm -it -v $(pwd)/contracts:/audit/contracts -v $(pwd)/test:/audit/test yourcompanyname/projectname` with parameters you need.


<br>

## Send us your configuration

We will rebuild the Docker image by ourselves, so please send us:

- `dockerfile` (or files)
- `package.json` 
	- only dependencies for the testing, not all of your dependencies
	- your `package.json` scripts section
- `truffle.js` with your networks congiguration

Push it back to the Github if you forked this repo before or achive it with zip/tar.

Send us the link to that commit (or .zip file)




<br>
