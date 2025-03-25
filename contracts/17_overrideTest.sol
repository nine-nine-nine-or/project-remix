// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract A{

    uint public a = 3;
    uint public value;

    constructor(uint){
        value =value;
    }
    
    function add() public virtual  pure returns (string memory){
        return  "i am a";
    }

}


contract B is A(2){

     uint _c =20;

    constructor(uint){
        _c = 30;
    }

    function add() public override pure returns (string memory){
       return "i am b";
    }

    function userA() public  view returns(uint256){
          return a+1;
    }
}