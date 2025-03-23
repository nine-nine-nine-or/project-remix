pragma solidity >=0.7.0 <0.9.0;

contract ArrayExample{

    uint[] public addressArray;

    function sumArray(uint[] memory  array) public view returns (uint256){
    
        uint sumAll;
        for (uint i = 0 ;i < array.length; i++){
            sumAll += array[i];
        }
         
        return  sumAll;
    }


    function addArray(uint i) public {
        addressArray.push(i);
    }

    function updateArray() external  returns (uint256){
            
        addressArray.pop();
        return  addressArray.length;
    }

    function muchArray(bytes memory _array,string memory _string) external {

       require(_array.length >0,"Not enough data");
       require(bytes(_string).length >1,"Not enough data");
     }
}