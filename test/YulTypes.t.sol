// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/YulTypes.sol";

contract YulTypesTest is Test {
    YulTypes public yulTypes;

    function setUp() public {
        yulTypes = new YulTypes();
    }

    function testGetNumberSol() public {
        uint256 num = yulTypes.getNumberSol();
        assertEq(num, 42);
    }

    function testGetNumberYul() public {
        uint256 num = yulTypes.getNumberYul();
        assertEq(num, 42);
    }
}
