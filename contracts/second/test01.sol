// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract bank{
    //状态变量
    address public immutable owner;
    
    event dosirty(address _own,uint a);
    event withdraw(uint account);

    receive() external payable {
        emit dosirty(msg.sender, msg.value);
     }

     constructor() payable  {
        owner = msg.sender;
     }

     function withdraw1() external  {

        require(owner == msg.sender,"address is not valid!");
        emit withdraw(address(this).balance);
        selfdestruct(payable (msg.sender));
     }

     function getBalance() public view returns(uint){
        return  address(this).balance;
     }
}