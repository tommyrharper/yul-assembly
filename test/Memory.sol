// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.17;

contract Memory {
    struct Point {
        uint256 x;
        uint256 y;
    }

    event MemoryPointer(bytes32);

    function memPointer() external {
        bytes32 x40;
        assembly {
            x40 := mload(0x40)
        }
        emit MemoryPointer(x40);
        Point memory p = Point({x: 1, y: 2});

        assembly {
            x40 := mload(0x40)
        }
        emit MemoryPointer(x40);
    }
}