// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.17;

contract HelloWorld {

   //string public  hello ="Hello World, I am a Remix test contract";

   struct Student{
      uint256 id ;
      uint256 score;
   }

   Student student;

   function initStudent() external {

    student.id = 10;
    student.score = 100;
   }

     // 获取学生信息
    function getStudent() external view returns (uint256, uint256) {
        return (student.id, student.score);
    }
}