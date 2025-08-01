// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleWallet {
    address public owner;
    mapping(address => uint) public balances;

    constructor() {
        owner = msg.sender;
    }

    function deposit() public payable {
        require(msg.value > 0, "Deposit amount must be greater than zero.");
        balances[msg.sender] += msg.value;
    }

    function withdraw(uint _amount) public {
        require(_amount > 0, "Withdraw amount must be greater than zero.");
        require(balances[msg.sender] >= _amount, "Insufficient balance.");
        balances[msg.sender] -= _amount;

        (bool success, ) = payable(msg.sender).call{value: _amount}("");
        require(success, "Failed to send Ether.");
    }

    function changeOwner(address _newOwner) public {
        require(msg.sender == owner, "Only the owner can change the owner.");
        require(_newOwner != address(0), "New owner address cannot be zero.");
        owner = _newOwner;
    }
}
