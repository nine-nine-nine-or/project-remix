// SPDX-License-Identifier: MIT
pragma solidity ~0.8.0;

contract test01{

    struct Order{
        uint256 id;
        address buyer;
        address saler;
        uint256 price;
    }

    struct Product{
        uint256 id;
        string name;
        uint256 price;
        uint256 num;
    }

    mapping (uint256 =>Order) public orders;
    uint256 public num;
    function addOrder( address from,address to,uint256 price ) public {
        orders[num++] = Order(num++,from,to,price);
    }

    function getOrder(uint256 id )view public returns ( address ,address, uint){
         return (orders[id].buyer, orders[id].saler,orders[id].price );
    }


}