// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

abstract  contract Shape{

     uint a;
    function area() public virtual returns(uint);
}


contract Square is Shape{
    function area() public  override returns(uint) {
            a =10 ;
            return  a+a;
    }
}

contract Circle is Shape{
    function area() public override returns(uint){
          a= 5;
         return a*a/2;
    }
}