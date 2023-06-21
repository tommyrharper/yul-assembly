// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract YulTypes {
    function getNumberSol() external pure returns (uint256) {
        return 42;
    }

    function getNumberYul() external pure returns (uint256) {
        uint256 x;

        assembly {
            // Yul also has no semicolons
            x := 42
        }

        return x;
    }

    function getHexYul() external pure returns (uint256) {
        uint256 x;

        assembly {
            // Yul has only one type, the 32 bit word (256 bits)
            x := 0xa
        }

        return x;
    }
}
