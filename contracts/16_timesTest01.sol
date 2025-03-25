// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Times{


    function inString(string memory _value) public pure  returns (bytes32){
        
       bytes32 hash = keccak256(abi.encodePacked(_value));
       return  hash;
    }

    function outString(bytes memory _value) public pure  returns (string memory){

      
       (string memory decodedString) = abi.decode(_value, (string));
       return  decodedString;
    }
}