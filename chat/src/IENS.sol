// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.25;

interface IENS {

    function getAddress (string memory _nickname) external view returns(address nickAddress_);

}