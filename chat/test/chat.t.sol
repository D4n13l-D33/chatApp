// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.25;

import "forge-std/Test.sol";
import {Ens} from "../src/EnsContract.sol";
import {Chat} from "../src/Chat.sol";


contract ChatTest is Test {
    Ens public ens;
    Chat public chat;

    function setUp() public {
        ens = new Ens();
        chat = new Chat(address(ens));
        
    }

    function test_Ens() public {
        vm.startPrank(0x1804c8AB1F12E6bbf3894d4083f33e07309d1f38);
        ens.createENS("D4n13l");

        assertEq(ens.getAddress("D4n13l"), msg.sender);
        
        vm.stopPrank();

        vm.startPrank(0x7FA9385bE102ac3EAc297483Dd6233D62b3e1496);
        
        vm.expectRevert();

        //should revert because Name already exists
        ens.createENS("D4n13l");

        vm.stopPrank();

        vm.startPrank(0x1804c8AB1F12E6bbf3894d4083f33e07309d1f38);
        vm.expectRevert();
        //Shoul revert because an address should not have more than one name
        ens.createENS("Ar13s");
    }

    function test_CreateAccount() public {
        vm.startPrank(0x1804c8AB1F12E6bbf3894d4083f33e07309d1f38);
        ens.createENS("V3nu5");

        vm.stopPrank();


        vm.expectRevert();

        //should revert cuz ENS hasn't been created
        chat.createAccount("D4n13l", "");

        vm.startPrank(0x7FA9385bE102ac3EAc297483Dd6233D62b3e1496);
        ens.createENS("D4n13l");

        chat.createAccount("D4n13l", "");

        vm.expectRevert();

        //Should revert cuz an address can't create account twice
        chat.createAccount("V3nu5", "");
        vm.stopPrank();

        vm.startPrank(0xE0597973e8105aC58A9E6652577135dF4e9a5da4);
        vm.expectRevert();
        //should revert cuz an address shouldn't be able to create Account with ENS that's not its own 
        chat.createAccount("V3nu5", "");
        vm.stopPrank();

    }

    function test_SendMessage() public{
        vm.expectRevert();
        //Should revert cuz sender doesn't have account
        chat.sendMessages("D4n13l", "Hi Let's Chat");
        
        vm.startPrank(0x7FA9385bE102ac3EAc297483Dd6233D62b3e1496);
        ens.createENS("D4n13l");

        chat.createAccount("D4n13l", "");

        vm.expectRevert();

        //Should revert cuz receiver doesn't have account
        chat.sendMessages("V3nu5", "Hi Let's chat");
        vm.stopPrank();

        vm.startPrank(0x1804c8AB1F12E6bbf3894d4083f33e07309d1f38);
        ens.createENS("V3nu5");
        chat.createAccount("V3nu5", "");
        vm.stopPrank();

        vm.startPrank(0x7FA9385bE102ac3EAc297483Dd6233D62b3e1496);
        chat.sendMessages("V3nu5", "Hi Let's Chat");

        assertEq(chat.getReceivedMessages("V3nu5", 0), "Hi Let's Chat");

        chat.sendMessages("V3nu5", "Whats going on");

        assertEq(chat.getReceivedMessages("V3nu5", 1), "Whats going on");
    }
}
