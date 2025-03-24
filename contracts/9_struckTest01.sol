// SPDX-License-Identifier: MIT
pragma solidity ~0.8.0;

contract test01{



    struct Product{
        uint256 id;
        string name;
        uint256 price;
        uint256 num;
    }

    mapping (uint256 => Product) public products;
    uint public  count;

    function getProduct(uint256 id) public view returns (Product memory){
        return products[id];
    }

    function updateProduct(uint256 id,uint256 newNum) public {
        products[id].num = newNum;
    }

    function addProduct(string memory name, uint256 price, uint256 num) public {

            products[count++] = Product(count++,name,price,num);
    }



}