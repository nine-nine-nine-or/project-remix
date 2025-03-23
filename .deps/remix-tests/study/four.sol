pragma solidity ^0.8.17;

contract Four {

    uint[] data ;
    function updateData(uint[] memory newData) public {
        data =newData;
    }

    function getData() public view  returns (uint[] memory){
       return  data;
    }

    function modifyStorageData(uint index,uint value) public {
        require(index < data.length, "Index out of bounds");
       data[index] =value;
    }

    function modifyMemoryData(uint[] memory memData) public  returns (uint[] memory){
        if (memData.length > 0) {
             memData[0] = 999; // 修改memory中的值，开销较小
        }
        return  memData;
    }

    function modifyMemoryData1(uint[] memory memData) public returns (uint[] memory) {
        if (memData.length > 0) {
            memData[0] = 999; // 修改 memory 中的值
        }
        data = memData; 
        return memData;
    }


}