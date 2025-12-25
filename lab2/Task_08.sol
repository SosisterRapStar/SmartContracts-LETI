// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;


contract Task_08 {
   event Transfer(address indexed from, address indexed to, uint256 value);


   mapping(address => uint256) public balances;


   constructor() {
       balances[msg.sender] = 1000; // Начальный баланс создателя контракта
   }


   function transfer(address to, uint256 value) external {
       require(balances[msg.sender] >= value, "Insufficient balance");
       balances[msg.sender] -= value;
       balances[to] += value;
       emit Transfer(msg.sender, to, value);
   }
}