// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract TestPayable {
    event Received(address sender, uint amount);
    
    receive() external payable {
        emit Received(msg.sender, msg.value);
    }
}