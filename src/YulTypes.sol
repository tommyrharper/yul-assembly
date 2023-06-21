// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract YulTypes {
    function getNumberSol() external pure returns (uint256) {
        return 42;
    }

    function getNumberYul() external pure returns (uint256) {
        uint256 x;

        assembly {
            x := 42
        }

        return x;
    }
}
