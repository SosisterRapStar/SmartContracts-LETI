// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Task_06 {
   uint256 public constant MAX_UINT = type(uint256).max; // Максимальное значение uint256

   function getMaxUint256() external pure returns (uint256) {
       return MAX_UINT; // Возвращает максимальное значение
   }

   function getMaxUint8() external pure returns (uint8) {
       return type(uint8).max;
   }
}