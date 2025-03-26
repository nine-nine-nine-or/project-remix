// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

library math{
      
      function add(uint x, uint y)internal pure returns (uint z){
            z = x+y;
      }
      function notAdd(uint x, uint y)internal pure returns (uint z){
            z = x-y;
      }
      function sum(uint x, uint y)internal pure returns (uint z){
            z = x*y;
      }
}



contract libraryTest01{

    function add(uint x , uint y) public pure  returns(uint){
    
          uint z= math.add(x,y);
          return z;
    }
    function notAdd(uint x , uint y) public pure  returns(uint){
    
          uint z= math.notAdd(x,y);
          return z;
    }
    function sum(uint x , uint y) public pure  returns(uint){
    
          uint z= math.sum(x,y);
          return z;
    }
}