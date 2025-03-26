// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./MyMath.sol";

contract Test01{
  
    function sum(uint a, uint b) public pure returns (uint){
    
              uint z= MyMath.sum(a, b);
              return z;
        
    }

    using MyMath01 for uint[];

    function contains( uint[] memory to,uint a ) public pure   return s(bool){
            return   MyMath01.contans(to,a); 
    }

    function contains1( uint[] memory to,uint a ) public pure   returns(bool){
            return   to.contans(a); 
    }
}