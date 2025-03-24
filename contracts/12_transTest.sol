// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Trans {
    

    mapping (address => uint) public balances; 

    event dopstion(address indexed from , uint indexed amount, uint timestamp);

    function trans() external payable {
        require(msg.value != 0,"user is not value");
        balances[msg.sender]  +=msg.value;

        emit dopstion(msg.sender, msg.value,block.timestamp);
    }

    function getThisBalances(address user) public view returns (uint) {
        return balances[user];
    }

  function getBalances(address user) public view returns (uint) {
        return address(this).balance;
    }
}