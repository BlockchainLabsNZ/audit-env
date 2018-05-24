require('babel-register');
require('babel-polyfill');


module.exports = {
  networks: {
    development: {
      host: '0.0.0.0',
      port: 8545,
      network_id: '*',
      gas: 4600000,
      gasPrice: 0x0
    },
    coverage: {
      host: "0.0.0.0",
      network_id: "*", 
      port: 8555,
      gas: 0xfffffffffff, 
      gasPrice: 0x0
    }
  },
  solc: {
    optimizer: {
      enabled: true,
      runs: 200
    }
  }
  // ,
  // mocha: {
  //     reporter: 'eth-gas-reporter',
  //     reporterOptions : {
  //         currency: 'USD',
  //         gasPrice: 21
  //     }
  // }
};
