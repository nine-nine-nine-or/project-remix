pragma solidity >0.5.0;

contract test03{

    address[] public  userAddress;
    mapping (address => uint) internal balances;


    function addUserBalance(address newAddress,uint balance)external {
        require(balances[newAddress] == 0," new user");

        userAddress.push(newAddress);
        balances[newAddress] = balance;
    }

   function getLeaderboard() external view returns (address[] memory, uint256[] memory) {
        return sortAllUserAndBalance(); // 调用排序函数
    }
    //冒泡排序算法排序mapping里面的余额
      function sortAllUserAndBalance() internal view returns (address[] memory, uint256[] memory) {
        address[] memory sortUserAddress = userAddress;
        uint256[] memory sortBalance = new uint256[](sortUserAddress.length);

        // 复制用户地址和余额
        for (uint256 i = 0; i < sortUserAddress.length; i++) {
            sortBalance[i] = balances[sortUserAddress[i]];
        }

        // 冒泡排序
        for (uint256 i = 0; i < sortUserAddress.length - 1; i++) {
            for (uint256 j = 0; j < sortUserAddress.length - i - 1; j++) {
                if (sortBalance[j] > sortBalance[j + 1]) {
                    // 交换余额
                    (sortBalance[j], sortBalance[j + 1]) = (sortBalance[j + 1], sortBalance[j]);
                    // 交换地址
                    (sortUserAddress[j], sortUserAddress[j + 1]) = (sortUserAddress[j + 1], sortUserAddress[j]);
                }
            }
        }

        return (sortUserAddress, sortBalance);
    }


    function getBalances(address user) external view   returns (uint256){
            (address[] memory sortUserAddress,uint256[] memory sortBalance)=sortAllUserAndBalance();
            
            for(uint256 i =0; i<sortUserAddress.length;i++){
               if (user == sortUserAddress[i]){
                    return i+1;
                }
            }
            return 0;
    }
}