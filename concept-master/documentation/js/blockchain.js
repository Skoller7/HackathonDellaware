App = {
    web3Provider: null,
    contracts: {},

    initWeb3: async function(){

        if (window.ethereum) {
            App.web3Provider = new Web3(ethereum);
            try {
                // Request account access
                await window.ethereum.enable();
            } catch (error) {
                // User denied account access...
                console.error("User denied account access")
            }
        }
        // Legacy dapp browsers...
        else if (window.web3) {
            App.web3Provider = window.web3.currentProvider;
        }
        // If no injected web3 instance is detected, fall back to Ganache
        else {
            App.web3Provider = new Web3.providers.HttpProvider('http://localhost:7545');
        }
        web3 = new Web3(App.web3Provider);
        return App.initContract1();
    },

    initContract1: function(){
    $.getJSON('../../../Solidity/build/contracts/BoerContract.json').then(BoerContractArtifact => {
        App.contracts.BoerContract = TruffleContract(BoerContractArtifact);
        App.contracts.BoerContract.setProvider(App.web3Provider);
        return $.getJSON('../../../Solidity/build/contracts/loadContract.json')
    }).then(loadContractArtifact => {
        App.contracts.loadContract = TruffleContract(loadContractArtifact);
        App.contract.loadContract.setProvider(App.web3Provider);
        console.log(App.contracts);
        console.log("test");
    })
    },

}
