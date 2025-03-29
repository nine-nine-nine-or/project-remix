// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract wethTest{

    mapping (address => uint) public balances;
    mapping (address => mapping (address =>  uint)) public allowance;

    //
    function dosirty() public payable {
        balances[msg.sender] += msg.value;
    }

    function withdraw() public {

    }

    function getBalances() public view returns (uint){
         return  balances[msg.sender];
    }

    function trans(address _to,uint256 _value) public payable returns (bool){
           return  transfor(msg.sender,_to,_value);
    }

    function approval(address _appUser,uint256 _account)public returns (bool) {
        allowance[msg.sender][_appUser] = _account;
        return true;
    }

    function getApply()public view returns (uint){
        return  address(this).balance;
    }

    function transfor(address src,address _to,uint256 _value) public payable returns (bool){
         if  ( src != msg.sender){
               allowance[src][msg.sender] -= _value;
         }
         balances[src] -= _value;
         balances[_to] += _value;
         return true;
    }
}