pragma solidity ^0.8.17;

contract Counter {

    bytes4 storedSelector;

    //平方函数
    function square(uint x) public pure  returns (uint y) {
         return x**2;
    }
    //加倍函数
    function double(uint x) public pure returns (uint y) {
         return x * 2;
    }
    //根据传入的函数选择器去对数值做相应的函数操作
    function executeFunction(bytes4 selector, uint x) public returns (uint) {
         
         (bool success,bytes memory data) = address(this).call(abi.encodeWithSelector(selector,x));
         require(success,"failed");
         return abi.decode(data, (uint));
    }

    //将传入的函数选择器赋值给状态变量
    function storeSelector(bytes4 selector) external {
        storedSelector = selector;
    }
    //根据条件，处理对应的函数选择器赋值给状态变量
    function setSelector(uint z)external {
        if (z ==1){
            storedSelector = this.square.selector;
        }else {
            storedSelector = this.double.selector;
        }
    }
    //输出数据
    function getFinnal(uint c) external returns (uint) {

        return executeFunction(storedSelector,c);
    }
}