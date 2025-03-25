// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract signTest {
    
    function outputBlock() public view returns (address coin,uint256  num,uint difficult,uint gasLimit,uint left){

       //矿工地址
        coin =  block.coinbase;
       //区块号
         num = block.number;
       //区块难度
        difficult = block.difficulty;
       //gas上限
        gasLimit = block.gaslimit;
       //剩余gas
        left = gasleft();
    }


    function decodeTest(address  _user,uint _value) public pure  returns (address,uint){

        bytes memory en = abi.encode(_user,_value);
        (address decodedUser,uint decodedValue) =abi.decode(en,(address,uint));
        return  (decodedUser, decodedValue);
    }

    function decodeTest02() public pure{
       bytes4 selector = bytes4(keccak256("decodeTest(address,uint)"));
       bytes memory encodedWithSelector = abi.encodeWithSelector(selector, address(0x123), 100);
    }
}