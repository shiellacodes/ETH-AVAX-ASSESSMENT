# ETH-AVAX-ASSESSMENT
Functions and Errors

## Description

This project is a simple Solidity smart contract that demonstrates the usage of three key control flow statements in Solidity: **`require`**, **`assert`**, and **`revert`**. The contract allows users to deposit and withdraw Ether, while ensuring proper validation of inputs and internal consistency using these statements.

The contract implements:
- **Deposit** function that accepts Ether and checks for valid deposits.
- **Withdraw** function that allows users to withdraw Ether and ensures the contract has enough balance.
- **Check Balance** function to view the contract's balance in Ether.

Each function uses `require`, `assert`, and `revert` to handle errors and ensure the contract behaves correctly.

---

## Getting Started
### Executing program
To run this program, you can use Remix, an online Solidity IDE. To get started, go to the Remix website at https://remix.ethereum.org/. Once you are on the Remix website, create a new file by clicking on the "+" icon in the left-hand sidebar. Save the file with a .sol extension (e.g., Statements.sol). Copy and paste the following code into the file:

```javascript

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


```

To compile the code, click on the "Solidity Compiler" tab in the left-hand sidebar. click on the "Compile Statements.sol" button.

You can deploy the contract by clicking on the "Deploy & Run Transactions" tab in the left-hand sidebar. Select the "Statements" contract from the dropdown menu, and then click on the "Deploy" button.

Once the Statements contract is deployed to the blockchain, users can interact with it by calling its functions. Below is a description of how the contract operates:

- Deposit Ether:
Action: To deposit Ether into the contract, users call the deposit() function and send Ether along with the transaction.
Process: The contract checks if the deposited amount is greater than zero. If valid, it updates the contract’s balance and emits the BalanceUpdated event to log the transaction. The contract also performs an internal check (via an assert statement) to ensure that the contract balance has been updated correctly.

- Withdraw Ether:
Action: Users can withdraw Ether by calling the withdraw(uint amountInEth) function and specifying the amount they wish to withdraw (in Ether).
Process: The contract converts the specified amount from Ether to Wei (the smallest unit). It checks if the contract has enough balance to cover the withdrawal. If sufficient funds are available, the contract transfers the requested amount to the user, updates the contract's balance, and emits a BalanceUpdated event. An internal assert statement ensures that the balance has decreased correctly after the withdrawal.

- Check Contract Balance:
Action: Anyone can check the contract's balance by calling the checkBalance() function.
Process: This function returns the contract’s balance in Ether (converted from Wei) so users can monitor the available funds.



## Authors

Shiella Marie P. Umali
202010956@fit.edu.ph


## License

This project is licensed under the MIT License License - see the LICENSE.md file for details

