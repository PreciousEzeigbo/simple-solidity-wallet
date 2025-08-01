# Simple Solidity Wallet

A basic smart contract wallet implemented in Solidity, demonstrating fundamental concepts like Ether deposits, withdrawals, ownership management, and practices with `require` statements.

---

## 🚀 Features

* **Deposit Ether**: Users can send Ether to the contract to store funds.
* **Withdraw Ether**: Users can withdraw their deposited Ether.
* **Owner Management**: The contract deployer is set as the owner, with a function to transfer ownership.
* **Basic Security**: Utilizes `require` statements for input validation, state checks, and access control.

---

## 🛠️ Technologies Used

* **Solidity**: The primary language for writing smart contracts on the Ethereum blockchain.
* **Hardhat / Truffle (Optional)**: Recommended development environments for compiling, testing, and deploying Solidity contracts (not included in this repo but typically used).

---

## 📋 Contract Details

### Contract Name: `SimpleWallet.sol`

### State Variables

* `owner` (address): Stores the address of the contract owner.
* `balances` (mapping): Maps user addresses to their deposited Ether balances.

### Functions

* **`constructor()`**:
    * Called only once upon contract deployment.
    * Sets the `msg.sender` (the address deploying the contract) as the initial `owner`.

* **`deposit() public payable`**:
    * Allows any user to send Ether to the contract.
    * `payable` keyword enables it to receive Ether.
    * Requires the `msg.value` (amount of Ether sent) to be greater than 0.
    * Adds the sent Ether to the `msg.sender`'s balance in the `balances` mapping.

* **`withdraw(uint _amount) public`**:
    * Allows a user to withdraw a specified `_amount` of Ether from their balance.
    * Requires `_amount` to be greater than 0.
    * Requires the user's `balances` to be greater than or equal to `_amount`.
    * Deducts `_amount` from the user's `balances`.
    * Safely transfers Ether to the `msg.sender` using `call{value: _amount}("")`.
    * Reverts if the Ether transfer fails.

* **`changeOwner(address _newOwner) public`**:
    * Allows the current `owner` to transfer ownership of the contract to a `_newOwner`.
    * Requires the caller (`msg.sender`) to be the current `owner` (access control).
    * Requires `_newOwner` not to be the zero address (`address(0)`).
    * Updates the `owner` state variable.

---

## ⚙️ How to Use (Local Development)

1.  **Prerequisites**:
    * [Node.js](https://nodejs.org/) (LTS recommended)
    * [npm](https://www.npmjs.com/) or [Yarn](https://yarnpkg.com/)
    * A Solidity development environment like [Hardhat](https://hardhat.org/) or [Truffle](https://trufflesuite.com/truffle/) (recommended)

2.  **Setup (if using Hardhat/Truffle)**:
    ```bash
    # Initialize a new Hardhat project (example)
    npx hardhat init
    # Or for Truffle
    truffle init
    ```

3.  **Place the Contract**:
    Save the `SimpleWallet.sol` file in your `contracts/` directory (for Hardhat/Truffle).

4.  **Compile the Contract**:
    ```bash
    npx hardhat compile
    # Or for Truffle
    truffle compile
    ```

5.  **Deploy (Example with Hardhat)**:
    Create a deployment script (e.g., `scripts/deploy.js`):
    ```javascript
    const { ethers } = require("hardhat");

    async function main() {
        const SimpleWallet = await ethers.getContractFactory("SimpleWallet");
        const simpleWallet = await SimpleWallet.deploy();
        await simpleWallet.waitForDeployment();
        console.log("SimpleWallet deployed to:", simpleWallet.target);
    }

    main().catch((error) => {
        console.error(error);
        process.exitCode = 1;
    });
    ```
    Then run:
    ```bash
    npx hardhat run scripts/deploy.js --network localhost # Or your desired network
    ```

6.  **Interact**:
    You can interact with the deployed contract using Hardhat Console, Ethers.js, Web3.js, or a tool like Remix IDE.

---

## 🤝 Contributing

Contributions are welcome! If you have suggestions for improvements or find any issues, please open an issue or submit a pull request.

---

## 📜 License

This project is licensed under the MIT License.
