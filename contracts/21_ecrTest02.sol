// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./MyToken.sol"; // 假设 MyToken 在同一目录下

contract Reward {
    MyToken public token;
    
    constructor(address tokenAddress) {
        token = MyToken(tokenAddress);
    }


    event DebugBalance(uint256 balance);

    function remainingTokens() public returns (uint256) {
        uint256 balance = token.balanceOf(address(this));
        emit DebugBalance(balance); // 注意：由于这是个view函数，实际上emit在这里不起作用，此行仅为说明目的
        return balance;
    }

    function rewardUser(address user, uint256 amount) external {
        require(amount > 0, "Reward amount must be greater than zero");
        
        // 发放奖励
        bool sent = token.transfer(user, amount);
        require(sent, "Failed to send token");
    }
    
    // 检查合约中剩余的代币数量
    // function remainingTokens() public view returns (uint256) {
    //     return token.balanceOf(address(this));
    // }

    
}