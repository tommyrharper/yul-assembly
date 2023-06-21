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

    function testGetHexYul() public {
        uint256 num = yulTypes.getHexYul();
        assertEq(num, 10);
    }

    function testGetStringYulNonsense() public {
        vm.expectRevert();
        yulTypes.getStringYulNonsense();
    }

    function testGetStringAsBytesYul() public {
        bytes32 str = yulTypes.getStringAsBytesYul();
        assertEq(str, "hello world");
    }

    function testGetStringYul() public {
        string memory str = yulTypes.getStringYul();
        assertEq(str, "hello world");
    }
}
