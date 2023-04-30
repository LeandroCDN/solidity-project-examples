
// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.16;

contract TheHotelGame {
    struct Hotel {
        uint256 coins;
        uint256 money;
        uint256 money2;
        uint256 yield;
        uint256 timestamp;
        uint256 hrs;
        address ref;
        uint256 refs;
        uint256 refDeps;
        uint8[8] Stars;
    }
    mapping(address => Hotel) public hotels;
    uint256 public totalStars;
    uint256 public totalHotels;
    uint256 public totalInvested;
    address public manager = msg.sender;

    function addCoins(address ref) public payable {
        uint256 coins = msg.value / 2e13;
        require(coins > 0, "Zero coins");
        address user = msg.sender;
        totalInvested += msg.value;
        if (hotels[user].timestamp == 0) {
            totalHotels++;
            ref = hotels[ref].timestamp == 0 ? manager : ref;
            hotels[ref].refs++;
            hotels[user].ref = ref;
            hotels[user].timestamp = block.timestamp;
        }
        ref = hotels[user].ref;
        hotels[ref].coins += (coins * 7) / 100;
        hotels[ref].money += (coins * 100 * 3) / 100;
        hotels[ref].refDeps += coins;
        hotels[user].coins += coins;
        payable(manager).transfer((msg.value * 3) / 100);
    }

    function withdrawMoney() public {
        address user = msg.sender;
        uint256 money = hotels[user].money;
        hotels[user].money = 0;
        uint256 amount = money * 2e11;
        payable(user).transfer(address(this).balance < amount ? address(this).balance : amount);
    }

    function collectMoney() public {
        address user = msg.sender;
        syncHotel(user);
        hotels[user].hrs = 0;
        hotels[user].money += hotels[user].money2;
        hotels[user].money2 = 0;
    }

    function upgradeHotel(uint256 floorId) public {
        require(floorId < 8, "Max 8 floors");
        address user = msg.sender;
        syncHotel(user);
        hotels[user].Stars[floorId]++;
        totalStars++;
        uint256 Stars = hotels[user].Stars[floorId];
        hotels[user].coins -= getUpgradePrice(floorId, Stars);
        hotels[user].yield += getYield(floorId, Stars);
    }

    function sellHotel() public {
        collectMoney();
        address user = msg.sender;
        uint8[8] memory Stars = hotels[user].Stars;
        totalStars -= Stars[0] + Stars[1] + Stars[2] + Stars[3] + Stars[4] + Stars[5] + Stars[6] + Stars[7];
        hotels[user].money += hotels[user].yield * 24 * 14;
        hotels[user].Stars = [0, 0, 0, 0, 0, 0, 0, 0];
        hotels[user].yield = 0;
    }

    function getStars(address addr) public view returns (uint8[8] memory) {
        return hotels[addr].Stars;
    }

    function syncHotel(address user) internal {
        require(hotels[user].timestamp > 0, "User is not registered");
        if (hotels[user].yield > 0) {
            uint256 hrs = block.timestamp / 3600 - hotels[user].timestamp / 3600;
            if (hrs + hotels[user].hrs > 24) {
                hrs = 24 - hotels[user].hrs;
            }
            hotels[user].money2 += hrs * hotels[user].yield;
            hotels[user].hrs += hrs;
        }
        hotels[user].timestamp = block.timestamp;
    }

    function getUpgradePrice(uint256 floorId, uint256 workerId) internal pure returns (uint256) {
        if (workerId == 1) {
            return [500, 1500, 4500, 13500, 40500, 120000, 365000, 1000000][floorId];
        }
        if (workerId == 2) return [625, 1800, 5600, 16800, 50600, 150000, 456000, 1200000][floorId];
        if (workerId == 3) return [780, 2300, 7000, 21000, 63000, 187000, 570000, 1560000][floorId];
        if (workerId == 4) return [970, 3000, 8700, 26000, 79000, 235000, 713000, 2000000][floorId];
        if (workerId == 5) return [1200, 3600, 11000, 33000, 98000, 293000, 890000, 2500000][floorId];
        revert("Incorrect workerId");
    }

    function getYield(uint256 floorId, uint256 workerId) internal pure returns (uint256) {
        if (workerId == 1) return [41, 130, 399, 1220, 3750, 11400, 36200, 104000][floorId];
        if (workerId == 2) return [52, 157, 498, 1530, 4700, 14300, 45500, 126500][floorId];
        if (workerId == 3) return [65, 201, 625, 1920, 5900, 17900, 57200, 167000][floorId];
        if (workerId == 4) return [82, 264, 780, 2380, 7400, 22700, 72500, 216500][floorId];
        if (workerId == 5) return [103, 318, 995, 3050, 9300, 28700, 91500, 275000][floorId];
        revert("Incorrect workerId");
    }
}

/* TODO:
 * make tax in public var (line 41)
 * Can money2 can be deleted?
 * puedo hacer el juego gratis?
 * aumentarlo a 72hrs?
 * eliminar sis de referidos
*/