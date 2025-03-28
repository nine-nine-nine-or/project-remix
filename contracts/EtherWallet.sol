// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract etherWallet{

    address public  immutable ower;
    event Withdraw(string funName,address _to,uint amount, bytes data);
    
    modifier onlyOwner {
        require(ower == msg.sender,"ower is not");
        _;
    }
    constructor(){
        ower = msg.sender;
    }

   receive() external payable {
    emit Withdraw("receive",msg.sender, msg.value, "");
    }

    function withdraw1() external payable   onlyOwner{

        payable (msg.sender).transfer(msg.value);
    }

     function withdraw2()external payable onlyOwner returns (bool success) {

        success = payable (msg.sender).send(msg.value);

    }

    function withdraw3()external  onlyOwner {

       (bool success,)  = msg.sender.call{value: address(this).balance}("");
       require(success, "Call Failed");

    }


}