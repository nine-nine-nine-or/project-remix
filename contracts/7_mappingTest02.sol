pragma solidity >0.5.0;

contract test02{

   // 定义事件，用于记录交易
    event TransactionRecorded(address indexed user, bytes32 txHash);

    // 使用 mapping 存储每个用户的交易历史
    mapping(address => bytes32[]) private userTransactions;

    // 添加交易记录
    function addTransaction(address user) external {
        bytes32 txHash = blockhash(block.number); // 获取当前区块的哈希
        userTransactions[user].push(txHash); // 将交易哈希添加到用户的交易历史中
        emit TransactionRecorded(user, txHash); // 触发事件
    }

    // 获取用户的交易历史
    function getTransactionHistory(address user) external view returns (bytes32[] memory) {
        return userTransactions[user]; // 返回用户的交易历史
    }

    // 获取所有用户的地址（模拟 Java 的 Map 键集合）
    function getAllUsers() external view returns (address[] memory) {
        // 由于 Solidity 不支持直接获取 mapping 的键集合，需要通过事件或外部工具实现
        // 这里返回一个空数组，实际应用中可以通过事件日志或其他方式获取
        return new address[](0);
    }
}