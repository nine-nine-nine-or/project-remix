
pragma solidity ^0.8.17;

contract  wallet{

     // 映射 地址映射到账户余额
     mapping (address =>uint256) public balances;
     // 映射 获取白名单
     mapping (address => bool) public withList;
     // 取款
     function withdrow(uint256  account) public {
            require(balances[msg.sender] >= account,"balance is insufficent");
            balances[msg.sender] -= account;
            payable(msg.sender).transfer(account);
     }
     // 存款
     function durstory() public payable {
            balances[msg.sender] += msg.value;
     }
     // 查看余额
     function viewBalances() public view returns (uint256) {
       return balances[msg.sender];
     } 

     //设置白名单
     function setWhiteList(address account) public {
        withList[account] =true;
     }
     //查询白名单状态
     function getWhiteStatus(address account) public view returns (bool){
        return  withList[account];
     }
     //授权支付合同
     function authPayBalances(address payable  _account) public payable  {
         require(getWhiteStatus(_account),"this is not a white list");
         _account.transfer(msg.value);
     }
}