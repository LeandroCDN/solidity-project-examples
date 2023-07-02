// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/* 
* @Author: remember use npm intall to install all openzepellin dependencies 
*/
contract Faucet is Ownable{
    uint dailyAmountPerWallet;
    uint claimCooldown = 1 days;
    IERC20 public token;
    mapping(address wallet => uint lastClaim) public claims;

    constructor(address token_, uint dailyAmount){
        token = IERC20(token_);
        dailyAmountPerWallet = dailyAmount;
    }

    function fillFaucet(uint amount) public {
        token.transferFrom(msg.sender, address(this), amount);
    }

    function claim() public{
        require(token.balanceOf(address(this)) > dailyAmountPerWallet, "not enough balance");
        require(claims[msg.sender] + claimCooldown < block.timestamp, "need more time" );
        claims[msg.sender] = block.timestamp + claimCooldown;
        token.transfer(msg.sender, dailyAmountPerWallet);
    }

    function changeDailyAmount(uint dailyAmount) public onlyOwner{
        dailyAmountPerWallet = dailyAmount;
    }

    function changeClaimCooldown(uint claimCooldown_) public onlyOwner{
        claimCooldown = claimCooldown_;
    }
}