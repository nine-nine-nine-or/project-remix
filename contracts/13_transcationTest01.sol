// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract Trans{


    mapping (address => uint) public balances; 
    
    event Pays(address indexed from ,uint indexed amount,uint timestemp);
    

    function Transfer()external payable returns (bool){

        require(msg.value == 0,"invaild value");

        balances[msg.sender] += msg.value;
        emit Pays(msg.sender,msg.value,block.timestamp);
        return true;
    }

    //查询合约的余额
    function getBalances()external view returns (uint256){
    
       return address(this).balance;
    }
    //查询指定账户的余额
    function getUserBalances(address _user) external view returns (uint256){
         return balances[_user];
    }
    function test01()public pure  returns (uint){
        uint result = mulmod(10, 20, 7);
        return  result;
    } 
}