// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Statements {

    // Event to log balance updates
    event BalanceUpdated(address indexed user, uint newBalance);

    // Function to deposit ether into the contract
    function deposit() external payable {
        // Ensure the deposit amount is greater than zero
        require(msg.value > 0, "Deposit amount must be greater than zero");

        // Add a revert condition: prevent deposits over 100 ETH
        if (msg.value > 100 ether) {
            revert("Deposit amount exceeds the maximum allowed limit of 100 ETH");
        }

        // Emit event after a successful deposit
        emit BalanceUpdated(msg.sender, address(this).balance);

        // Assert that the contract balance has increased by the deposited amount
        uint contractBalanceBefore = address(this).balance - msg.value;
        uint contractBalanceAfter = address(this).balance;
        assert(contractBalanceAfter == contractBalanceBefore + msg.value); // Assert that the balance has increased correctly
    }

    // Function to withdraw ether from the contract in Ether (ETH)
    function withdraw(uint amountInEth) external {
        uint amountInWei = amountInEth * 1 ether; // Convert ETH to Wei

        // Ensure the sender has sufficient balance in the contract
        require(address(this).balance >= amountInWei, "Insufficient balance in contract");

        // Prevent withdrawals that exceed a certain threshold (e.g., 100 ETH)
        if (amountInEth > 100) {
            revert("Withdrawal amount exceeds maximum limit of 100 ETH");
        }

        // Transfer the requested amount of ether (in Wei) to the sender
        payable(msg.sender).transfer(amountInWei);

        // Emit event after a successful withdrawal
        emit BalanceUpdated(msg.sender, address(this).balance);

        // Assert that the contract balance has decreased by the withdrawn amount
        uint contractBalanceBefore = address(this).balance + amountInWei;
        uint contractBalanceAfter = address(this).balance;
        assert(contractBalanceAfter == contractBalanceBefore - amountInWei); // Assert that the balance has decreased correctly
    }

    // Function to check the balance of the contract in Ether (ETH)
    function checkBalance() external view returns (uint) {
        return address(this).balance / 1 ether; // Return balance in Ether (ETH)
    }
}
