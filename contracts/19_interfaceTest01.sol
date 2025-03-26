// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

interface  IVault {
    function setMoney(address _user,uint _value) external ;
    function getMoney(address _user,uint _value) external ;
}

contract Bank is IVault {
    mapping (address=>uint) public balances;
   
   function setMoney(address _user,uint _value) public override {
    require(_value>=0,"no money");
         balances[_user] +=_value;
   }
   function getMoney(address _user,uint _value) public override {
        require(_value>=balances[_user],"no money can use");
         balances[_user] -=_value;
   }

}