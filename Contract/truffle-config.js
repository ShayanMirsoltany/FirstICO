module.exports = {
  networks: {
    development: {
     host: "127.0.0.1",     // Localhost (default: none)
     port: 7545,            // Standard Ethereum port (default: none)
     network_id: "*",       // Any network (default: none)
     networkCheckTimeout: 100000, // افزایش زمان انتظار
    },
  },
  compilers: {
    solc: {
      version: "0.8.22",      // Fetch exact version from solc-bin (default: truffle's version)
      settings: {          // See the solidity docs for advice about optimization and evmVersion
       evmVersion: "berlin", // یا "london"
       optimizer: {
         enabled: true,
         runs: 200
       },
      }
    }
  },
};

