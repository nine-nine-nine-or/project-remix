// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;


/*  
        多签钱包的功能: 合约有多个 owner，一笔交易发出后，需要多个 owner 确认，确认数达到最低要求数之后，才可以真正的执行。

        1.原理
        部署时候传入地址参数和需要的签名数
        多个 owner 地址
        发起交易的最低签名数
        有接受 ETH 主币的方法，
        除了存款外，其他所有方法都需要 owner 地址才可以触发
        发送前需要检测是否获得了足够的签名数
        使用发出的交易数量值作为签名的凭据 ID（类似上么）
        每次修改状态变量都需要抛出事件
        允许批准的交易，在没有真正执行前取消。
        足够数量的 approve 后，才允许真正执行。
*/
contract MuchSign {

    //签名者集合
    address[] public owner;
    //映射，每个地址对应的签名权
    mapping (address => bool) public isOwner;
    //每笔交易需要的最低签名
    uint public requires;
    //交易的结构体   交易地址，交易值，交易的状态，交易的数据
    struct Transaction{
          address _to;
          uint256 _value;
          bool expected;
          bytes datas;
    }

    //交易的集合
    Transaction[] public trans;
    //根据交易的id获取 其签名者的状态
    mapping (uint256 =>mapping (address=> bool))  private approved;
    //判断是否是当前调用者()
    modifier isOwens(address _address){
        require(_address != msg.sender, "must be owner");
        _;
    }
    //判断当前交易是否在交易集合里
    modifier isTrans(uint256 _id){
        require(_id<=trans.length,"the trans length not enough");
        _;
    }
    //判断输入参数的交易是否被调用者签名过
    modifier isSign(uint256 _id){
      require(!approved[_id][msg.sender],"is sign");
      _;
    }
    //判断输入参数的交易是否已经交易
    modifier isTranxed(uint256 _id){
        require(!trans[_id].expected,"is transactioned");
        _;
    }

    event TransferETH(address indexed from, uint256 amount);
    
    constructor(address[] memory _address,uint16  _requires){
        require(_address.length>0,"requires must be bigger than zero");
        require( _requires > 0 && _requires<_address.length,"requires is too much");
        for (uint i = 0; i< _address.length;i++){
            address one = _address[i];
            require(one != address(0) ,"require address can not be zero address");
            require(!isOwner[one], "require address can not be owner");
            isOwner[one]= true;
            owner.push(one);
        }
    }

    receive() external payable {
        emit TransferETH(msg.sender,msg.value);
     }
}