// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Counter {
    uint256 count;
    uint public maxCount;
    uint public minCount;

    constructor(uint maxCount_, uint minCount_){
        maxCount = maxCount_;
        minCount = minCount_;
    }

    function getCount() public view returns (uint256) {
        return count;
    }

    function incrementCount() public {
        require(count < maxCount, "maxCount error");
        count++;
    }

    function decrementCount() public {

        require(count > minCount, "minCount error");
        count--;
    }

    function setMaxAndMinCount(uint maxCount_, uint minCount_) public {
        maxCount = maxCount_;
        minCount = minCount_;
    }

    function setCount(uint newValueForCount) public {
        require(newValueForCount > minCount, "minCount error");
        require(newValueForCount < maxCount, "maxCount error");
        
        count = newValueForCount;
    }
}