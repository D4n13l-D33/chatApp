// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.25;

import {IENS} from "./IENS.sol";

contract Chat {

    address EnsAddr;

    constructor(address _ens){
        EnsAddr = _ens;
    }

    struct Messages {
        string name;
        string message;
    }

    struct Users {
        string name;
        string imageUri;
        
        Messages [] sentMessages;
        Messages [] recievedMessages;
    }

    mapping(address => Users) public registeredUsers;
    mapping(address => bool) isRegistered;

    function createAccount(string memory _nickname, string memory _imageUri) external {
        require(isRegistered[msg.sender] == false, "Already have an account");

        address nickAddress = IENS(EnsAddr).getAddress(_nickname);
        require(nickAddress != address(0), "You don't have an ENS");
        require(nickAddress == msg.sender, "ENS not yours");

        Users storage newUser = registeredUsers[nickAddress];
        newUser.name = _nickname;
        newUser.imageUri = _imageUri;

        isRegistered[nickAddress] = true;
    }

    function sendMessages(string memory _receiverNick, string memory _message) external {
        require(isRegistered[msg.sender] == true, "You're not registered, Please create Account");
        address receiverAddress = IENS(EnsAddr).getAddress(_receiverNick);

        require(isRegistered[receiverAddress] == true, "Receiver does not exist");

        Users storage receiver = registeredUsers[receiverAddress];
        Users storage sender = registeredUsers[msg.sender];

        receiver.recievedMessages.push(Messages({ name: sender.name, message: _message}));

        sender.sentMessages.push(Messages({name: receiver.name, message: _message}));
    }

    function getAddressfromEns(string memory _nickname) public view returns(address nickaddress_){
        nickaddress_ = IENS(EnsAddr).getAddress(_nickname);
    }

    function getReceivedMessages(string memory _receiver, uint index) external view returns(string memory message){
        address receiverAdd = getAddressfromEns(_receiver);

        message = registeredUsers[receiverAdd].recievedMessages[index].message;
    }
    

}