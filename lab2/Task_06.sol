// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


contract Task_06 {


    mapping(uint => string) private colors;
    address public owner;


    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }


    constructor() {
        owner = msg.sender;
        colors[0] = "Red";
        colors[1] = "Orange";
        colors[2] = "Yellow";
        colors[3] = "Green";
        colors[4] = "Blue";
        colors[5] = "Indigo";
        colors[6] = "Violet";
    }


    function addColor(uint index, string calldata color) external {
        colors[index] = color;
    }


    function getColor(uint index) external returns (string memory) {
        return colors[index];
    }


    function getAllColors() internal view returns (string[] memory) {
        string[7] memory allColors;
        for (uint i = 0; i < 7; i++) {
            allColors[i] = colors[i];
        }
        return allColors;
    }


    function colorExists(uint index) private view returns (bool) {
        if (index > 6) {
            return false;
        }
        return bytes(colors[index]).length > 0;
    }


    function removeColor(uint index) public {
        require(msg.sender == owner, "Only owner can remove colors");
        delete colors[index];
    }
}
