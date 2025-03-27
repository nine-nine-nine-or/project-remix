// // SPDX-License-Identifier: MIT
// pragma solidity ^0.8.0;

// import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
// import "@openzeppelin/contracts/utils/Counters.sol";
// import "@openzeppelin/contracts/access/Ownable.sol";
// import "@openzeppelin/contracts/utils/Strings.sol";
// import "@openzeppelin/contracts/utils/Base64.sol";

// contract VirtualCollectibles is ERC721, Ownable {
//     using Counters for Counters.Counter;
//     using Strings for uint256;
    
//     Counters.Counter private _tokenIdCounter;
    
//     // 定义收藏品类型
//     enum CollectibleType { 
//         DRAGON, 
//         WIZARD, 
//         KNIGHT, 
//         UNICORN, 
//         PHOENIX 
//     }
    
//     // 定义稀有度等级
//     enum Rarity { 
//         COMMON, 
//         UNCOMMON, 
//         RARE, 
//         EPIC, 
//         LEGENDARY 
//     }
    
//     // 存储每个NFT的属性
//     struct Collectible {
//         CollectibleType cType;
//         Rarity rarity;
//         uint256 strength;
//         uint256 agility;
//         uint256 intelligence;
//         uint256 createdAt;
//     }
    
//     // 稀有度对应的颜色
//     mapping(Rarity => string) private rarityColors;
    
//     // 类型对应的名称
//     mapping(CollectibleType => string) private typeNames;
    
//     // 存储所有NFT的属性
//     mapping(uint256 => Collectible) private collectibles;
    
//     // 稀有度概率分布（百分比）
//     uint256[] private rarityDistribution = [40, 30, 20, 8, 2];
    
//     // 类型概率分布（百分比）
//     uint256[] private typeDistribution = [25, 25, 20, 15, 15];
    
//     constructor() ERC721("Virtual Collectibles", "VC") {
//         // 初始化稀有度颜色
//         rarityColors[Rarity.COMMON] = "#9B9B9B";
//         rarityColors[Rarity.UNCOMMON] = "#4CAF50";
//         rarityColors[Rarity.RARE] = "#2196F3";
//         rarityColors[Rarity.EPIC] = "#9C27B0";
//         rarityColors[Rarity.LEGENDARY] = "#FF9800";
        
//         // 初始化类型名称
//         typeNames[CollectibleType.DRAGON] = "Dragon";
//         typeNames[CollectibleType.WIZARD] = "Wizard";
//         typeNames[CollectibleType.KNIGHT] = "Knight";
//         typeNames[CollectibleType.UNICORN] = "Unicorn";
//         typeNames[CollectibleType.PHOENIX] = "Phoenix";
//     }
    
//     // 铸造新的收藏品
//     function mintCollectible(address to) public returns (uint256) {
//         _tokenIdCounter.increment();
//         uint256 newTokenId = _tokenIdCounter.current();
//         _safeMint(to, newTokenId);
        
//         // 随机生成属性
//         Collectible memory newCollectible;
//         newCollectible.cType = _getRandomType();
//         newCollectible.rarity = _getRandomRarity();
//         newCollectible.strength = _randomInRange(1, 100);
//         newCollectible.agility = _randomInRange(1, 100);
//         newCollectible.intelligence = _randomInRange(1, 100);
//         newCollectible.createdAt = block.timestamp;
        
//         collectibles[newTokenId] = newCollectible;
        
//         return newTokenId;
//     }
    
//     // 批量铸造
//     function batchMint(address to, uint256 amount) public onlyOwner {
//         for (uint256 i = 0; i < amount; i++) {
//             mintCollectible(to);
//         }
//     }
    
//     // 获取NFT属性
//     function getCollectible(uint256 tokenId) public view returns (Collectible memory) {
//     require(exists(tokenId), "Token does not exist"); // 使用公共函数
//         return collectibles[tokenId];
//     }
    
//     // 生成NFT的SVG图像（链上）
//     function _generateSVG(uint256 tokenId) private view returns (string memory) {
//         Collectible memory c = collectibles[tokenId];
//         string memory color = rarityColors[c.rarity];
//         string memory typeName = typeNames[c.cType];
        
//         string memory svg = string(abi.encodePacked(
//             '<svg xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="xMinYMin meet" viewBox="0 0 350 350">',
//             '<style>.base { fill: white; font-family: serif; font-size: 14px; }</style>',
//             '<rect width="100%" height="100%" fill="', color, '" />',
//             '<text x="50%" y="30%" class="base" dominant-baseline="middle" text-anchor="middle">', typeName, '</text>',
//             '<text x="50%" y="40%" class="base" dominant-baseline="middle" text-anchor="middle">', _rarityToString(c.rarity), '</text>',
//             '<text x="50%" y="50%" class="base" dominant-baseline="middle" text-anchor="middle">Strength: ', uint256(c.strength).toString(), '</text>',
//             '<text x="50%" y="60%" class="base" dominant-baseline="middle" text-anchor="middle">Agility: ', uint256(c.agility).toString(), '</text>',
//             '<text x="50%" y="70%" class="base" dominant-baseline="middle" text-anchor="middle">Intelligence: ', uint256(c.intelligence).toString(), '</text>',
//             '</svg>'
//         ));
        
//         return svg;
//     }
    
//     // 生成NFT的元数据（链上）
//     function tokenURI(uint256 tokenId) public view override returns (string memory) {
//     require(exists(tokenId), "Token does not exist"); // 使用公共函数
        
//         Collectible memory c = collectibles[tokenId];
//         string memory typeName = typeNames[c.cType];
//         string memory rarity = _rarityToString(c.rarity);
        
//         string memory attributes = string(abi.encodePacked(
//             '[',
//             '{"trait_type": "Type", "value": "', typeName, '"},',
//             '{"trait_type": "Rarity", "value": "', rarity, '"},',
//             '{"trait_type": "Strength", "value": ', uint256(c.strength).toString(), '},',
//             '{"trait_type": "Agility", "value": ', uint256(c.agility).toString(), '},',
//             '{"trait_type": "Intelligence", "value": ', uint256(c.intelligence).toString(), '}',
//             ']'
//         ));
        
//         string memory image = string(abi.encodePacked(
//             "data:image/svg+xml;base64,",
//             Base64.encode(bytes(_generateSVG(tokenId)))));
        
//         string memory json = Base64.encode(bytes(string(abi.encodePacked(
//             '{"name": "Virtual Collectible #', tokenId.toString(), '",',
//             '"description": "A unique virtual collectible with randomly generated attributes.",',
//             '"image": "', image, '",',
//             '"attributes": ', attributes,
//             '}'
//         ))));
        
//         return string(abi.encodePacked("data:application/json;base64,", json));
//     }
    
//     // 辅助函数：随机生成类型
//     function _getRandomType() private view returns (CollectibleType) {
//         uint256 rand = _randomInRange(1, 100);
//         uint256 cumulative = 0;
        
//         for (uint256 i = 0; i < typeDistribution.length; i++) {
//             cumulative += typeDistribution[i];
//             if (rand <= cumulative) {
//                 return CollectibleType(i);
//             }
//         }
        
//         return CollectibleType.DRAGON; // 默认
//     }
    
//     // 辅助函数：随机生成稀有度
//     function _getRandomRarity() private view returns (Rarity) {
//         uint256 rand = _randomInRange(1, 100);
//         uint256 cumulative = 0;
        
//         for (uint256 i = 0; i < rarityDistribution.length; i++) {
//             cumulative += rarityDistribution[i];
//             if (rand <= cumulative) {
//                 return Rarity(i);
//             }
//         }
        
//         return Rarity.COMMON; // 默认
//     }
    
//     // 辅助函数：生成范围内的随机数（伪随机）
//     function _randomInRange(uint256 min, uint256 max) private view returns (uint256) {
//         uint256 random = uint256(keccak256(abi.encodePacked(
//             block.timestamp,
//             block.difficulty,
//             msg.sender,
//             _tokenIdCounter.current()
//         )));
        
//         return (random % (max - min + 1)) + min;
//     }
    
//     // 辅助函数：稀有度枚举转字符串
//     function _rarityToString(Rarity rarity) private pure returns (string memory) {
//         if (rarity == Rarity.COMMON) return "Common";
//         if (rarity == Rarity.UNCOMMON) return "Uncommon";
//         if (rarity == Rarity.RARE) return "Rare";
//         if (rarity == Rarity.EPIC) return "Epic";
//         if (rarity == Rarity.LEGENDARY) return "Legendary";
//         return "Unknown";
//     }
// }