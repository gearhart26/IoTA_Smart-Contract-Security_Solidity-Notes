pragma solidity 0.7.5;

contract Bank {
    
    mapping(address => uint) balances;
    
    bool private _paused;
    
    address private owner;
    
    constructor(){
        _paused = false;
        owner = msg.sender;
    }
    
    modifier onlyOwner {
        require(msg.sender == owner);
            _;
    }
    
        //modifier to allow functions to execute only when contract is not paused
    modifier whenNotPaused {
        require(!_paused);
        _;
    }
    
        //modifier for when contract is paused
    modifier whenPaused {
        require(_paused);
        _;
    }
    
        //allows owner to pause contract when it is not paused
    function pause() public onlyOwner whenNotPaused {
        _paused = true;
    }
    
        //allows owner to unpause contract when it is paused
    function unPause() public onlyOwner whenPaused{
        _paused = false;
    }
    
    function withdrawALL() public whenNotPaused returns (uint){
        uint amount = balances[msg.sender];
        balances[msg.sender] = 0;
        msg.sender.transfer(amount);
        return balances[msg.sender];
    }
    
        //example of type of function that could be useful when paused
        //although function like this seems very sketchy to users. Possible rugpull situation
    //function emergencyWithdrawal() public onlyOwner whenPaused
}
