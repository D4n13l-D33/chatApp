// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {Ens} from "../src/EnsContract.sol";
import {Chat} from "../src/Chat.sol";

contract ChatScript is Script {
    Chat chat;
    Ens ens;

    function setUp() public {}

    function run() public {
        vm.startBroadcast();

        ens = new Ens();

        chat = new Chat(address(ens));
    }
}
