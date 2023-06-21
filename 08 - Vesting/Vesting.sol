// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/*
* @title : Vesting
* @author: @LenLabiano
* @notice: a vesting contract for youtube tutorial
*/
contract Vesting is Ownable {
  bool stateVesting;
  uint startVesting;
  uint interval = 30 days;
  uint totalCurrency;
  uint8 maxClaims = 10;
  
  IERC20 public currency;
  mapping(address => uint) public totalAmounts;
  mapping(address => uint) public totalClaims;

  constructor(address currency_) {
    require(currency_ != address(0), "Must be a token address");
    currency = IERC20(currency_);
  }

  modifier beforeVestingStart() {
    require(!stateVesting, "Only when the Vesting dont start"); 
    _;
  }

  /*
  ** @dev: owner can register accounts before start vesting. If one address appers twice, 
  ** the ammount is added
  ** @param accounts: List of account in vesting
  ** @param amounts: Amount of total vesting for each account
  */
  function resgisterVesting(address[] memory accounts, uint[] memory amounts) public  onlyOwner beforeVestingStart(){
    
    uint length = accounts.length;
    require(length == amounts.length);

    uint totalCurrency_;

    for(uint i; i <length;){
      require(accounts[i] != address(0));

      totalCurrency_ +=amounts[i];
      totalAmounts[accounts[i]] += amounts[i];
      unchecked {
        ++i;
      }
    }
    totalCurrency = totalCurrency_;
  }

  function removeAccounts()public onlyOwner beforeVestingStart(){
    // completar esta funcion:
  }

  function changeInterval(uint intervalInSconds) public onlyOwner beforeVestingStart(){
    interval = intervalInSconds;
  }

  function initializeVesting() public onlyOwner beforeVestingStart(){
    require(currency.balanceOf(address(this)) >= totalCurrency, "Not enough balance");
    stateVesting = true;
    startVesting = block.timestamp;
  }

  function claimTokens() external {
    require(stateVesting, "Vesting not started yet");
    address user = msg.sender;
    uint amount = totalAmounts[user];
    uint currentClaim = totalClaims[user]++; 
    require(amount > 0);
    require(block.timestamp >= startVesting + interval * ( currentClaim + 1), "Error: next claim instance not available yet");
    require(currentClaim <= 10);
    uint totalAmount = (amount * 10)/100;

    currency.transfer(user, totalAmount);
  }

}

//posibles tareas
/*
  - hacer que el contrato sea reutilizable. 
  - Completar la funcion remove acounts
  - permitir que el contrato use Crypto( matic en polygon, eth en ethereum (funciones payables))
*/