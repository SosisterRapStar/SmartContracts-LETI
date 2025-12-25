// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

contract Task_09 {
   
   mapping(uint256 => string) public users;
   uint256 public userCount;
   
   // Событие для добавления пользователя с индексируемым userId и неиндексированным сообщением
   event UserAdded(
       uint256 indexed userId,
       string message
   );
   
   // Событие для удаления пользователя с индексируемым userId и неиндексированным сообщением
   event UserRemoved(
       uint256 indexed userId,
       string message
   );

   function addUser(string memory name) external {
       userCount++;
       users[userCount] = name;
       
       // Генерируем событие добавления пользователя
       emit UserAdded(
           userCount, 
           string(abi.encodePacked("User '", name, "' added with ID: ", uintToString(userCount)))
       );
   }

   function removeUser(uint256 userId) external {
       require(bytes(users[userId]).length != 0, "User does not exist.");
       
       // Сохраняем имя пользователя перед удалением для сообщения
       string memory userName = users[userId];
       
       delete users[userId];
       
       // Генерируем событие удаления пользователя
       emit UserRemoved(
           userId, 
           string(abi.encodePacked("User '", userName, "' with ID: ", uintToString(userId), " has been removed"))
       );
   }
   
   // Вспомогательная функция для конвертации uint256 в string
   function uintToString(uint256 _value) internal pure returns (string memory) {
       if (_value == 0) {
           return "0";
       }
       
       uint256 temp = _value;
       uint256 digits;
       
       while (temp != 0) {
           digits++;
           temp /= 10;
       }
       
       bytes memory buffer = new bytes(digits);
       
       while (_value != 0) {
           digits -= 1;
           buffer[digits] = bytes1(uint8(48 + _value % 10));
           _value /= 10;
       }
       
       return string(buffer);
   }
}