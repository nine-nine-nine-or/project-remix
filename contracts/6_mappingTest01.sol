pragma solidity >0.5.0;


contract test01 {
    
    mapping (address => uint) userBalances;
    address []public users;

    function getUserBalances(address _userAdress) external{
        require(userBalances[_userAdress] == 0,"not found");
        users.push(_userAdress);
        userBalances[_userAdress] =100;
    }

    function balances(address _userAdress) external  returns (uint){
        return userBalances[_userAdress];
    }

}