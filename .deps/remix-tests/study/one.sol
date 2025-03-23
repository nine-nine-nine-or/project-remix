
pragma solidity ^0.8.17;

contract SolidityTest { 

    uint storedData; // 状态变量 

    constructor() public { 
        storedData = 10; // 使用状态变量 
        } 

        function getResult() public view returns(uint) {
              uint a1= 1;
              uint b1= 2;
              return storedData +a1*b1 ;
        }

        function add(uint x, uint y) public pure returns (uint z) {
                z = x + y; 
                return  z   ;
                }
        function divide(uint x, uint y ) public pure returns (uint z){
                z = x / y; 
                return  z   ;

                } 
        function leftshift(int x, uint y) public pure returns (int z){
                z = x << y; 
                return  z   ;
                } 
        function rightshift(int x, uint y) public pure returns (int z){
                z = x >> y; 
                return  z   ;
                } 
        function testPlusPlus() public pure returns (uint ) { 
                uint x = 1; uint y = ++x; // c = ++a; 
                return y; 
         } 

         function sub1() public pure returns (uint8) { 
                uint8 m = 1; 
                unchecked{
                 uint8 n = m - 2; 
                return n; 
                }
                
} 
}