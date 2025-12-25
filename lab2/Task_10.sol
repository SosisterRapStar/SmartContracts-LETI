// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


contract Task_10 {
    event ReceivedEther(address sender, uint amount, string func);
    event FallbackCalled(address sender, uint amount, bytes data);


    // Функция receive: вызывается, когда контракт получает эфир без данных (пустой calldata)
    receive() external payable {
        emit ReceivedEther(msg.sender, msg.value, "receive");
    }


    // Функция fallback: вызывается, когда контракт получает эфир с данными
    // или вызывается несуществующая функция
    fallback() external payable {
        emit FallbackCalled(msg.sender, msg.value, msg.data);
    }


    // Вспомогательная функция для проверки баланса контракта
    function getBalance() external view returns (uint) {
        return address(this).balance;
    }
}