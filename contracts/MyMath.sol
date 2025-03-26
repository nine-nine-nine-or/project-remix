// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

library MyMath{
      
      function add(uint x, uint y)internal pure returns (uint z){
            z = x+y;
      }
      function notAdd(uint x, uint y)internal pure returns (uint z){
            z = x-y;
      }
      function sum(uint x, uint y)external  pure returns (uint z){
            z = x*y;
      }
}


library MyMath01{

    function contans(uint[] memory to,uint a) public pure   returns (bool){
           for ( uint i =0;i<to.length;i++){
                if (to[i] == a){
                return true;
                }
           }
        return false;
    }
}