// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Task_07 {
   // Владелец контракта — адрес, который развернул контракт
   address public owner;

   constructor() {
       owner = msg.sender;
   }

   function getBytesFromString(string memory _str) public pure returns (bytes memory) {
       return bytes(_str);
   }
}