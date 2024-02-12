# Pre-compute contract deployment address using CREATE2
The following Solidity source code and usage script ilustrates how to pre-calculate the deployment address of a contract,  on the EVM blockchain before deploying it.

# Required software
Remix; Metamask; Etherscan.

# Steps

1. Upload PreComputeAddr.sol file in Remix- Contains 2 contracts:
   
     a) PreComputeAddress
   
     b) MyWallet 
3. Deploy PrecomputeAddress contract in Sepolia testnet through a Metamask account (or your prefered wallet).
4. Calculate the bytecode of MyWallet contract using function getByteCode.
5. Use the computeAddress function to generate the target wallet contract address. Arguments: bytecode of the contract calculated in the former step with a salt (random number of your election, e.g. "123").
6. Send some SepoliaETH (e.g. 0.001) to the precomputed address. Note that the contract has not been deployed yet. Check the address balance in Etherscan. There is no information about the bytecode, it is an address for which a key does not exist, but has balance.
7. Deploy the MyWallet contract using the function deploy from the PreComputeAddress contract (same bytecode and salt used for the address pre-computation). The Metamask account is hardcoded in the contract. Observe in Etherscan that now the address is a SmartContract (with bytecote), and a balance.
8. Upload myWallet contract functions in Remix with “At address” button and the target wallet contract address. 
9. Withdraw all funds to Metamask account. Check that the balance of the contract in Etherscan is 0 and that the address balance has been transfered to the Metamask account.



