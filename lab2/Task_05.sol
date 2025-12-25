pragma solidity ^0.8.0;

contract Task_05 {
    // Хранит список температур в градусах Цельсия
    uint256[] public celsiusTemperatures; // storage
    
    // Функция для добавления температуры в градусах Цельсия
    function addCelsiusTemperature(uint256 temperature) public {
        celsiusTemperatures.push(temperature); // добавляем значение в storage массив
    }
    
    // Функция для установки нескольких температур за раз
    function setCelsiusTemperatures(uint256[] memory temperatures) public {
        celsiusTemperatures = temperatures; // заменяем весь массив
    }
    
    // Функция для получения количества сохраненных температур
    function getTemperatureCount() public view returns (uint256) {
        return celsiusTemperatures.length;
    }
    
    // Функция для конвертации одной температуры из Цельсия в Фаренгейт
    function convertToFahrenheit(uint256 temperature) public pure returns (uint256) {
        // Используем memory для временной переменной
        uint256 fahrenheitTemperature = (temperature * 9 / 5) + 32; // конвертация
        return fahrenheitTemperature;
    }
    
    // Функция для получения всех температур в Фаренгейтах
    function getAllFahrenheitTemperatures() public view returns (uint256[] memory) {
        // Создаем memory массив для результата
        uint256[] memory fahrenheitTemps = new uint256[](celsiusTemperatures.length);
        
        // Конвертируем каждую температуру
        for (uint256 i = 0; i < celsiusTemperatures.length; i++) {
            fahrenheitTemps[i] = convertToFahrenheit(celsiusTemperatures[i]);
        }
        
        return fahrenheitTemps;
    }
    
    // Функция для конвертации массива температур из Цельсия в Фаренгейт
    function convertArrayToFahrenheit(uint256[] memory celsiusArray) public pure returns (uint256[] memory) {
        // Создаем memory массив для результата
        uint256[] memory fahrenheitArray = new uint256[](celsiusArray.length);
        
        // Конвертируем каждую температуру
        for (uint256 i = 0; i < celsiusArray.length; i++) {
            fahrenheitArray[i] = convertToFahrenheit(celsiusArray[i]);
        }
        
        return fahrenheitArray;
    }
    
    // Функция для получения температуры в Фаренгейтах по индексу
    function getFahrenheitTemperatureAtIndex(uint256 index) public view returns (uint256) {
        require(index < celsiusTemperatures.length, "Index out of bounds");
        return convertToFahrenheit(celsiusTemperatures[index]);
    }
}