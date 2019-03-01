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
      return new HDWalletProvider(MNEMONIC, 'https://ropsten.infura.io/d8ad6516506b45cf84a09fac6314cbbf')
      },
      network_id: '3', // factory addres here 0xc1B0746fBEAEc1D192290c8a32AB405A4f600685
      //boer 1 address : 0x82bf79c45Fbd01edcB08Cc0aC3785B27D9677A14
    }
  }
};
