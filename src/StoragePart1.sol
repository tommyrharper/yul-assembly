// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract StoragePart1 {
    // all of these are in the same slot
    uint128 public C = 4;
    uint96 public D = 6;
    uint16 public E = 8;
    uint8 public F = 1;

    function readBySlot(uint256 slot) external view returns (bytes32 value) {
        assembly {
            value := sload(slot)
        }
    }

    function getOffsetE() external pure returns (uint256 slot, uint256 offset) {
        assembly {
            slot := E.slot // 0
            offset := E.offset // 28 - this means if you look 28 bytes from left, you will find E
        }
    }

    function readE() external view returns (uint32 e) {
        assembly {
            let value := sload(E.slot) // must load in 32 byte increments
            // E.offset = 28
            // multiply by 8 to get the number of bits in 28 bytes
            // shr = shift right
            // can use division instead of shifting
            let shifted := shr(mul(E.offset, 8), value) // shift to the right by 28 bytes

            // 0x0000000000000000000000000000000000000000000000000000000000010008
            // equivalent to
            // 0x000000000000000000000000000000000000000000000000000000000000ffff
            e := and(0xffff, shifted)
        }
    }

    function readEAlt() external view returns (uint256 e) {
        assembly {
            let slot := sload(E.slot)
            let offset := sload(E.offset)
            let value := sload(E.slot)

            // shift right by 224 = divide by (2 ** 24). below is 2 ** 24 in hex
            let shifted := div(value, 0x100000000000000000000000000000000000000000000000000000000)

            e := and(0xffff, shifted)
        }
    }

    // masks can be hardcoded because variable storage slot and offsets are fixed
    // V and 00 = 00
    // V and FF = V
    // V or 00 = V
    // function arguments are always 32 bytes long under the hood
    function writeToE(uint16 newE) external {
        // newE = 10
        // newE = 0x000000000000000000000000000000000000000000000000000000000000000a
        assembly {
            let c := sload(E.slot) // slot 0
            // the 1, 8, 6 and 4 correspond to CDE and F
            // c = 0x0000010800000000000000000000000600000000000000000000000000000004
            // need to selectively delete E
            let clearedE := and(c, 0xffff0000ffffffffffffffffffffffffffffffffffffffffffffffffffffffff)
            // mask     = 0xffff0000ffffffffffffffffffffffffffffffffffffffffffffffffffffffff
            // c        = 0x0001000800000000000000000000000600000000000000000000000000000004
            // clearedE = 0x0001000000000000000000000000000600000000000000000000000000000004
            let shiftedNewE := shl(mul(E.offset, 8), newE)
            // shiftedNewE = 0x0000000a00000000000000000000000000000000000000000000000000000000
            let newVal := or(shiftedNewE, clearedE)
            // shiftedNewE = 0x0000000a00000000000000000000000000000000000000000000000000000000
            // clearedE    = 0x0001000000000000000000000000000600000000000000000000000000000004
            // newVal      = 0x0001000a00000000000000000000000600000000000000000000000000000004
            sstore(C.slot, newVal)
        }
    }
}
