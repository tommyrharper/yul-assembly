// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

// sload(slot)
// sstore(slot, value)
// variableName.slot
contract StorageBasics {
    uint256 x = 2;
    uint256 y = 13;
    uint256 z = 54;
    uint128 a = 1;
    uint128 b = 1;

    function getSlotForA() external pure returns (uint256 slot) {
        assembly {
            slot := a.slot // returns 3
        }
    }

    function getSlotForB() external pure returns (uint256 slot) {
        assembly {
            slot := b.slot // returns 3
        }
    }

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

    function setXYul(uint256 value) external {
        assembly {
            sstore(x.slot, value)
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

    function setVarYul(uint256 slot, uint256 value) external {
        assembly {
            sstore(slot, value)
        }
    }
}
