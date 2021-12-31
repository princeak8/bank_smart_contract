// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Token is ERC20 {
  //string public name = "my token";

  address public minter;

  //add minter changed event
  event MinterChanged(address indexed from, address to);

  /*
    The constructor is called immediately the contract is deployed
    the constructor must be public type for u to deploy it
    and if the contract sends funds, then it has to be a 'payable'
    the argumentsts assigned to ERC20 Contructor has to be 'name', and 'symbol'
  */

  constructor() public payable ERC20("Decentralized Bank Currency", "DBC") {
    minter = msg.sender;
  }

  function passMinterRole(address dBank) public returns (bool) {
  	require(msg.sender==minter, 'Error, only owner can change pass minter role');
  	minter = dBank;

    emit MinterChanged(msg.sender, dBank);
    return true;
  }

  function mint(address account, uint256 amount) public {
    //check if msg.sender have minter role
    require(msg.sender == minter, 'Error, msg.sender does not have minter role');
		_mint(account, amount);
	}
}