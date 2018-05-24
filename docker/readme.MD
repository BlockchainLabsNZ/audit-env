# Dynamic testing basic environment for your Smart Contracts Audit

<br>

## Prerequisites

We assume you have these installed/used:

- Environment
	- Ethereum blockchain
	- Solidity, Truffle
	- Docker ([install it](https://docs.docker.com/install))
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
- Go to you project folder that contains `/contracts` and `/test` folders.
	- Run `npm run blaTest` for dynamic testing
	- Run `npm run blaCoverage` for test coverage report
	- Run `npm run blaPlay` to have your playground inside the container
		
		> There are VI and nano editors installed, so, feel free to change something, help yourself, its all yours. <br>
		> Press `Cntrl-D` to exit container.


Each run of these commands will create new Docker container, copy your contracts and tests from the project directory to the container’s volume and then run tests in our typical testing environment. Containers are self destroing on exit.

 
<br>

## Updating your environment configuration

If your tests are not working in our environment, we need to figure out *Why* and change the environment. 
It will take some time. You can save that (paid) time and update the configuration by yourself:

1. Go to the `/docker` folder.
- Update the `package.json` with new dependencies from **your** `package.json`, but keep it clean from unused dependencies (such as webded packages, webpack configs and so on).
- Check *dockerfile* and update it if needed.
- Build new docker image: `docker build -t yourcompanyname/projectname` from **`/docker` folder**.
- Check that new Docker image is ready by running it in your **project folder**: `docker run --rm -it -v $(pwd)/contracts:/audit/contracts -v $(pwd)/test:/audit/test yourcompanyname/projectname` with parameters you need.
- Add new npm script commands with all switches for `docker run ...` to the `package.json` in **this folder**


<br>

## Sending us your configuration

We will rebuild the Docker image, so please send us:

- `dockerfile`
- `package.json` - only dependencies for the testing, not all of your dependencies and, probably, commands
- `truffle.js` with your network congiguration

Push it to the Github if you forked this repo before (or just archive it).
Send us commit number (or .zip file)




<br>
