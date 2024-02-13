//SPDX-License-Identifier: MIT
pragma solidity 0.8.4;

//Pre-compute contract deployment address using CREATE2 opcode of EVM. Deployment of the contract and matching of addresses
contract PreComputeAddress{
    event Deployed(address indexed preComputedAddress);

    // we need bytecode of the contract to be deployed along with the constructor parameters
    function getBytecode(address payable _owner) public pure returns (bytes memory){
        bytes memory bytecode =type(MyWallet).creationCode;
        return abi.encodePacked(bytecode,abi.encode(_owner));
    }

    //compute the deployment address
    function computeAddress(bytes memory _byteCode, uint256 _salt)public view returns (address ){
        bytes32 hash_ = keccak256(abi.encodePacked(bytes1(0xff),address(this),_salt,keccak256(_byteCode)));
        return address(uint160(uint256(hash_)));
    }

    //deploy the contract and check the event for the deployed address
    function deploy(bytes memory _byteCode, uint256 _salt)public payable{
        address depAddr;

        assembly{
            depAddr:= create2(callvalue(),add(_byteCode,0x20), mload(_byteCode), _salt)
        
        if iszero(extcodesize(depAddr)){
            revert(0,0)
        }

        }
        emit Deployed(depAddr);
    }

}

//A basic wallet contract owned by a hardcoded address, that allows the owner to retrieve funds sent to the contract´s address before contract creation
contract MyWallet{

    //replace with the prefered address
    //address constant public myAddress = 0x67fd15A39319598A868C42415237ee883d811653;
    address owner;

    constructor (address payable _owner) {
        owner= _owner;
    }

    function getBalance () public view returns (uint) {
        return address(this).balance;
    }

    //allows the owner to sweep the balance of the address
    function widthdrawMoney (address payable recipient) external {
        require (msg.sender==owner);
        recipient.transfer (address(this).balance);
    }  

    receive () external payable {
        }

}
