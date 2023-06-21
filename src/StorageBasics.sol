// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract StorageBasics {
    uint256 x = 2;
    uint256 y = 13;
    uint256 z = 54;

    function setX(uint256 newVal) external {
        x = newVal;
    }

    function getX() external view returns (uint256) {
        return x;
    }

    function getXYul() external view returns (uint256 ret) {
        assembly {
            ret := sload(x.slot)
        }
    }

    function getVarYul(uint256 slot) external view returns (uint256 ret) {
        assembly {
            // slot = 0 => 2
            // slot = 1 => 13
            // slot = 2 => 54
            // slot = 3 => 0
            ret := sload(slot)
        }
    }
}
