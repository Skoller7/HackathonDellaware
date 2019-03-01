var HDWalletProvider = require("truffle-hdwallet-provider");

var MNEMONIC = "panda voice ripple lucky session what clay wild also nominee scrap swim";
/*
 * NB: since truffle-hdwallet-provider 0.0.5 you must wrap HDWallet providers in a
 * function when declaring them. Failure to do so will cause commands to hang. ex:
 * ```
 * mainnet: {
 *     provider: function() {
 *       return new HDWalletProvider(mnemonic, 'https://mainnet.infura.io/<infura-key>')
 *     },
 *     network_id: '1',
 *     gas: 4500000,
 *     gasPrice: 10000000000,
 *   },
 */
 module.exports = {
    networks: {
  // development: {
  //   host: "localhost",
  //   port: 7545,
  //   network_id: "*" // Match any network id
  // },
  ropsten: {
    provider: function() {
      return new HDWalletProvider(MNEMONIC, 'https://ropsten.infura.io/4017b2e363014111adbb3b26a4240cf0')
      },
      network_id: '3', // factory addres here 0x6e5F94401Fd5046A6e3eAaAf79299146E987B333.
    }
  }
};
