// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract HelloWorld {
    string mensaje= "Hello World!";

    function getGreeting() public view returns (string memory) {
        return mensaje;
    }
}