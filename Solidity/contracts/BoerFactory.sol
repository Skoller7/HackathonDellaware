pragma solidity >=0.4.21;


//to test this code go to : https://remix.ethereum.org/#optimize=false&version=soljson-v0.4.24+commit.e67f0147.js
//past the code and go to "run", chose " enviroment : javascript VM".
//

contract BoerFactory {
    BoerContract[]public deployedBoerContracts; //alle gemaakte adressen opslaan.

    //maakt persoonlijke contracten per gebruiker.
    function createBoerContract() public {
        BoerContract newBoerContract = new BoerContract(msg.sender);
        deployedBoerContracts.push(newBoerContract);
    }

    function getDeployedContracts() public view returns(BoerContract[] memory)  {
      return deployedBoerContracts;
    }
}

contract BoerContract {

    jaarSubContract[]public deployedJaarSubContracts;
    address public contractOwner;

    constructor(address creator) public {
      contractOwner = creator;

    }

    function createJaarSubContract(uint price, uint length) public {
         require(msg.sender == contractOwner); //enkel eigenaar mag dit doen.

         jaarSubContract newJaarSubContract = new jaarSubContract(price, length, msg.sender);
         deployedJaarSubContracts.push(newJaarSubContract);
    }

    function getDeployedContracts() public view returns(jaarSubContract[] memory){
        return deployedJaarSubContracts;
    }
}


contract jaarSubContract {

    address public dataSeller; //address van de boer die data verkoopt.
    uint public buyersCount = 0;
    uint public priceOfData;
    uint public lengthOfSubscription;
    mapping(address => bool) public backers;
    loadContract[]public deployedLoads;


    constructor(uint price, uint length, address creator) public {
        dataSeller = creator;
        priceOfData = price;
        lengthOfSubscription = length;
    }

    modifier restricted(){
        require(msg.sender == dataSeller);
        _;
    }

    function changePrice(uint newPrice) public restricted {
        priceOfData = newPrice;
    }

    function createBuyRequest() public payable {
        require(msg.value >= priceOfData);
        backers[msg.sender] = true;
        buyersCount++;
    }

    function getPrice() public view returns(uint){
        return priceOfData;
    }

    function getBuyersCount() public view returns(uint){
        return buyersCount;
    }

    function getSubLength()public view returns(uint){
        return lengthOfSubscription;
    }

    function createLoad(uint loadId, uint companyId)public{ //loadId & companyId om te achterhalen van waar de load komt + dataseller.
        loadContract newDeployedLoad = new loadContract(loadId, companyId, dataSeller);
        deployedLoads.push(newDeployedLoad);
    }
}

contract loadContract { //kiezen of load items gezien mogen worden door iedereen of niet.
                        //eventueel nog extra data toevoegen, hoe oud zijn de patatten?
                        //Wanneer zijn ze geoogst ,......
    uint public loadId;
    uint companyId;
    address farmer;
    address loadBuyer; //person who bought the load can see the content.
    bool public sold = false; //verkocht of niet?
    bool public forSale = false; // is de load for sale?
    bool lock = false; //locks the load. no changes can be made
    uint loadPrice = 0;


    constructor(uint id, uint cId, address harvester)public { //harvester == boer die de patatten hebben gekweekt.
        loadId = id;
        companyId = cId;
        farmer = harvester;
    }

    function createBuyRequest()public payable {
        require(lock == false);
        require(forSale == true);
        require(sold == false);
        require(loadPrice != 0);
        require(msg.value >= loadPrice);

        loadBuyer = msg.sender;
        lock = true;
    }

    function swapForSale()public {
        require(lock == false);
        require(msg.sender == farmer); // enkel farmer kan

        if(forSale == false){
            forSale = true;
        }
        else forSale = false;
    }

    function changeLoadPrice(uint newPrice)public {
        require(lock == false);
        require(msg.sender == farmer);

        loadPrice = newPrice;
    }



}


