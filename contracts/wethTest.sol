// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract wethTest{

    mapping (address => uint) public balances;
    mapping (address => mapping (address =>  uint)) public allowance;

    event Withdraw(address src,uint account);
    event Approval(address _appUser,address appUser,uint account);
    event transFrom(address src,address _to,uint256 _value);

    function dosirty() public payable {
        balances[msg.sender] += msg.value;
    }
    //取钱
    function withdraw(uint _value) public {
       balances[msg.sender] -= _value;
       payable (msg.sender).transfer(_value);
       emit Withdraw(msg.sender, _value);
    }

    function getBalances() public view returns (uint){
         return  balances[msg.sender];
    }

    function trans(address _to,uint256 _value) public payable returns (bool){
           return  transfor(msg.sender,_to,_value);
    }

    function approval(address _appUser,uint256 _account)public returns (bool) {
        allowance[msg.sender][_appUser] = _account;
        emit Approval(msg.sender,_appUser,_account);
        return true;
    }

    function getApply()public view returns (uint){
        return  address(this).balance;
    }

    //判断 src地址是否是调用该合约方法的调用者地址，不是的话，就说明是授权者去处理交易，在授权者余额里面减去交易的值，
    function transfor(address src,address _to,uint256 _value) public payable returns (bool){
         if  ( src != msg.sender){
               allowance[src][msg.sender] -= _value;
         }
         balances[src] -= _value;
         balances[_to] += _value;
         emit transFrom(src,_to,_value);
         return true;
    }
}