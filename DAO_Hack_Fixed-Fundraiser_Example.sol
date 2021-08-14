// Vulnerable contract.
    pragma solidity ^0.4.8;

    contract Fundraiser{
        
            // Attaching ether balances to each contributing address.
        mapping  (address => uint) balances;
    
            // Making contributions and updating balances.
        function contribute() payable{
            balances[msg.sender] += msg.value;
        }
        
            // Checking contributions from senders address and throws error if balance is zero but if 
            // they have a non-zero balance then they are allowed to withdraw up to their balance.
        function withdraw(){
            if(balances[msg.sender] == 0){
                throw;
            }
            
// Fixed Code Without the Vulneribility Here
                // No longer vulnerable because balance is updated BEFORE transacton is carried out, protecting the contract from re-enreancy attack.
            balances[msg.sender] = 0;
            msg.sender.call.value(balances[msg.sender])();
        }
    
            // Amount of funds in Fundraiser contract
        function getFunds() returns (uint){
            return address(this).balance;
        }
    
    }

