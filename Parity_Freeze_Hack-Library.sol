pragma solidity ^0.4.8;

    contract Library{
    
        address owner;
    
        function isNotPositive(uint number) returns (bool){
            if(number<=0){
                return true;
            }
            return false;
        }
    
        function destroy() public onlyOwner {
            selfdestruct(owner);
        }
        
        modifier onlyOwner {
            if(msg.sender != owner){
                throw;
            }
            _;
        }
        
// Where the vulneribility started
            // If there is no owner set for the wallet then anyone could call the contract 
            // and set themselves as the owner of the wallet. Which is exactly what happened.
            // The person who made themselves the owner then used the destroy function available
            // only to the owner (which he now was) and destroyed the library that all of these wallets, 
            // which have been used for Initial Coin Offerings (ICOs), needed to function. 
            // Esentially breaking the wallets and freezing all the funds they held. 
            
            // The owner should have been set up when the contract was created.
        function initOwner(){
            if(owner==address(0)){
                owner = msg.sender;
            }
            else{
                throw;
            }
        }
        
    }

