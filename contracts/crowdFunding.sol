// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract CrowdFunding{

    //受益人
    address immutable beneficiary ;
    //筹集金额
    uint256 immutable contributeAmount;
    //映射  捐助人=》捐助金额
    mapping (address =>uint) public contribuution ;
    //映射  捐助人=》捐助人状态
    mapping (address => bool) public contribuitionState;
    //当前筹集的金额
    uint256 public contributeMoney;
    //捐助人列表
    address[] public contributors;
    //合约状态
    bool public isOpen =true;

    event AddAmount(address _from,uint256 _accounts,uint256 _to);

    //构造方法，合约部署的时候初始化受益人和筹集金额
    constructor(address _beneficiary,uint256 _contributeAmount){
         beneficiary =_beneficiary ;
         contributeAmount = _contributeAmount;
    }

    //捐助人捐助金额给受益人      
    //筹集的金额增加
    //捐助人-》捐助金额的映射增加
    //捐助人列表增加
    function addAmount(address from,uint256 _account) external  payable {
        require(isOpen,"Contract is not open");
        require(_account < contributeAmount,"contribute is too much");
        //超出筹集金额的值
        uint256  contributeCount = 0;

        emit AddAmount(from,_account,msg.value);
        if ((_account + contributeMoney)> contributeAmount) {   //筹集金额增加到筹集金额){
                contributeCount = _account + contributeMoney-contributeAmount;
                contribuution[from] += _account-contributeCount;
                contributeMoney += _account-contributeCount;
                isOpen = false;
        }else {
                contribuution[from] +=_account;
                contributeMoney += _account;
        }

        //判断之前是否捐赠过
        if (!contribuitionState[from]){
            contribuitionState[from] =true ;
            contributors.push(from);
        }

        //超过筹集金额的捐款需要被退回
        if (contributeCount>0){
            payable(msg.sender).transfer(contributeCount);
        }
    }

    function close() public payable returns(bool){
        require(contributeAmount ==contributeMoney,"money is not enough");
        require(beneficiary==msg.sender, "Not the beneficiary contract");

        if (contributeAmount>contributeMoney){
            return false;
        }
        //将已经满足筹集金额的状态变量赋值给内存变量，减少gas消耗
        uint account = contributeMoney;
        //将已经收集到的状态变量 已收集金额置为0，防止重入攻击
        contributeMoney = 0;
        isOpen =false;

        payable (beneficiary).transfer(account);
    
        return true;
    }
    function getContributeAmount() external view returns (uint256) {
           return contributeMoney;
    }
}