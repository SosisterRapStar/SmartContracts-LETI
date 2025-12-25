// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;


contract Task_01 {
    // Функция для вычисления суммы с использованием цикла for
    function calculateSumFor(uint256 n) public pure returns (uint256) {
        uint256 sum = 0; // переменная для хранения суммы
        for (uint256 i = 1; i <= n; i++) {
            sum += i; // добавляем текущее число к сумме
        }
        return sum; // возвращаем итоговую сумму
    }


    // Функция для вычисления суммы с использованием цикла while
    function calculateSumWhile(uint256 n) public pure returns (uint256) {
        uint256 sum = 0; // переменная для хранения суммы
        uint256 i = 1; // инициализация счетчика
        while (i <= n) {
            sum += i; // добавляем текущее число к сумме
            i++; // инкрементируем счетчик
        }
        return sum; // возвращаем итоговую сумму
    }


    // Функция для вычисления суммы с использованием цикла do while
    function calculateSumDoWhile(uint256 n) public pure returns (uint256) {
        uint256 sum = 0; // переменная для хранения суммы
        uint256 i = 1; // инициализация счетчика
        do {
            sum += i; // добавляем текущее число к сумме
            i++; // инкрементируем счетчик
        } while (i <= n); // продолжаем, пока счетчик меньше или равен n
        return sum; // возвращаем итоговую сумму
    }
}
