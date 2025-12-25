// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Task_11 {
    address public owner;
    uint public targetAmount;
    uint public totalUserDeposits; // Общая сумма всех переводов на контракт
   
    enum State { Active, Paused, Closed }
    State public state;

    mapping(address => uint) public balances;

    event Deposited(address indexed user, uint amount);
    event Withdrawn(address indexed user, uint amount);
    event StateChanged(State newState);
    event TargetReached(uint totalAmount);

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }

    modifier whenActiveOrPaused() {
        require(state == State.Active || state == State.Paused, "Unavailable in closed state");
        _;
    }

    modifier whenActive() {
        require(state == State.Active, "Contract is not active");
        _;
    }

    modifier whenClosed() {
        require(state == State.Closed, "Contract is not closed");
        _;
    }

    constructor(uint _targetAmount) {
        require(_targetAmount > 0, "Target amount should be > 0");
        owner = msg.sender;
        targetAmount = _targetAmount;
        state = State.Active;
        totalUserDeposits = 0;
    }

    function deposit() external payable whenActive {
        require(msg.value > 0, "Deposit must be greater than 0");
        
        // Обновляем баланс пользователя
        balances[msg.sender] += msg.value;
        // Обновляем общую сумму депозитов
        totalUserDeposits += msg.value;
        
        // Генерируем событие депозита
        emit Deposited(msg.sender, msg.value);
        
        // Проверяем, достигли ли целевой суммы
        if (address(this).balance >= targetAmount && state == State.Active) {
            state = State.Closed;
            emit StateChanged(state);
            emit TargetReached(address(this).balance);
        }
    }

    function pause() external onlyOwner whenActiveOrPaused {
        require(state != State.Paused, "Contract paused");
        state = State.Paused;
        emit StateChanged(state);
    }

    function resume() external onlyOwner {
        require(state == State.Paused, "Contract is not paused");
        state = State.Active;
        emit StateChanged(state);
    }

    function withdraw() external whenActiveOrPaused {
        require(state == State.Paused, "Fund withdraw available only if paused");
        
        uint userBalance = balances[msg.sender];
        require(userBalance > 0, "No funds to withdraw");
        
        // Обнуляем баланс пользователя перед отправкой (защита от reentrancy)
        balances[msg.sender] = 0;
        
        // Обновляем общую сумму депозитов
        totalUserDeposits -= userBalance;
        
        // Отправляем средства пользователю
        (bool success, ) = msg.sender.call{value: userBalance}("");
        require(success, "Transfer failed");
        
        // Генерируем событие вывода
        emit Withdrawn(msg.sender, userBalance);
    }

    function ownerWithdrawAll() external onlyOwner whenClosed {
        uint contractBalance = address(this).balance;
        require(contractBalance > 0, "No fund to withdraw");
        
        // Обнуляем все балансы
        balances[owner] = 0;
        totalUserDeposits = 0;
        
        // Отправляем все средства владельцу
        (bool success, ) = owner.call{value: contractBalance}("");
        require(success, "Transfer failed");
        
        // Генерируем событие вывода владельцем
        emit Withdrawn(owner, contractBalance);
    }

    function getState() external view returns (string memory) {
        if (state == State.Active) return "Active";
        if (state == State.Paused) return "Paused";
        if (state == State.Closed) return "Closed";
        return "";
    }
    
    // Вспомогательная функция для проверки баланса контракта
    function getContractBalance() external view returns (uint) {
        return address(this).balance;
    }
    
    // Вспомогательная функция для проверки прогресса сбора
    function getProgress() external view returns (uint, uint) {
        return (address(this).balance, targetAmount);
    }
}