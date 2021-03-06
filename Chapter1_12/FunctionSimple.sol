pragma solidity ^0.5.13;

contract FunctionSimple{
    mapping(address => uint) public balanceReceived;
    
    address payable owner;
    
    constructor() public{
        owner = msg.sender;
    }
    
    function getOwner()public view returns(address){
    return owner;
    }
    
    function destroySmartContract() public{
        require(msg.sender == owner, "you are not the owner!");
        selfdestruct(owner);
    }
    
    function receiveMoney() public payable{
        assert(balanceReceived[msg.sender] + uint64(msg.value) >= balanceReceived[msg.sender]);
        balanceReceived[msg.sender] +=uint64(msg.value);
    }
    
    function withdrawMoney(address payable _to, uint64 _amount) public{
        require(_amount <= balanceReceived[msg.sender],"you dont'n have enough ether");
        assert(balanceReceived[msg.sender] >= balanceReceived[msg.sender] - _amount);
            balanceReceived[msg.sender] -= _amount;
            _to.transfer(_amount);
        
    }
    function() external payable{
        receiveMoney();
    }
}