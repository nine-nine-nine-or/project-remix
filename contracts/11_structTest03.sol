// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
contract test03{

    struct Userful{
        address uid;
        uint256 balances;
        uint16 age;
    }
    
    struct Transaction{
        address from;
        address to;
        bytes8  name;
    }

    mapping ( address => Transaction[]) private trans;

    mapping (address => Userful) public  users;

    function addUser(address uid,uint256 balances , uint16 age ) public {
        users[uid] = Userful(uid,balances,age);
    }

    function addTransaction(address to, string memory name)public {

            bytes8 descHash = bytes8(keccak256(abi.encodePacked(name)));

        trans[msg.sender].push( Transaction({from: msg.sender,to : to,name:descHash}));
    }

}