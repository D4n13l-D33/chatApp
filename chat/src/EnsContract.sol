// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.25;

error NICKNAME_ALREADY_TAKEN();
error ALDRESS_ALREADY_HAS_A_NAME();

contract Ens {
    string [] nicknames;
    address [] addresses;

    mapping (string => address) nickToAddress;
    mapping (address => bool) hasName;

    constructor(){
         nicknames.push("");
         addresses.push(address(0));
    }

    function createENS(string memory _nicknames) external {
            require(hasName[msg.sender] != true, "This address Already has a name");

            for(uint i; i<nicknames.length; i++){
                if(keccak256(abi.encodePacked(_nicknames)) == keccak256(abi.encodePacked(nicknames[i]))){
                    revert NICKNAME_ALREADY_TAKEN();
                }
            }

            nickToAddress[_nicknames] = msg.sender;
            nicknames.push(_nicknames);
            hasName[msg.sender] = true;
    }

    function getAddress (string memory _nickname) external view returns(address nickAddress_){
        nickAddress_ = nickToAddress[_nickname];
    }
}