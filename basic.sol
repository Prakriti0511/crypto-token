// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Basic{
    address public minter;
    mapping(address => uint) public balances;
    event Sent(address receiver, address sender, uint amt);
    constructor(){
        minter = msg.sender;   
    }

    modifier onlyOwner(){
        require(minter == msg.sender, "YOU ARE NOT THE OWNER");
        _;
    }

    function minting(address receiver, uint amt) public payable onlyOwner{
            balances[receiver]+=amt;
           
    }
    error insufficientbalance(uint available, uint requested);

    function sending(address receiver, uint amt) public payable onlyOwner{
            // require(balances[msg.sender] >= amt, "INSUFFICIENT BALANCE");
            if(balances[msg.sender]<amt){
                revert insufficientbalance({
                    available: balances[msg.sender],
                    requested: amt
                });
            }
            balances[msg.sender] -= amt;
            balances[receiver]+=amt;
            emit Sent({
                receiver: receiver,
                sender: msg.sender,
                amt:amt
            });
    }
}