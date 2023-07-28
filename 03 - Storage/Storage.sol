// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.2 <0.9.0;

// Este codigo puede no funcionar. Porque?

contract Storage {
    uint256[] number;

    function store(uint256 num) public {
        uint length = number.length;
        number[length] = num;
    }

    function retrieve(uint index) public view returns (uint256){
        return number[index];
    }
}