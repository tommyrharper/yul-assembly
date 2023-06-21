// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/IsPrime.sol";

contract IsPrimeTest is Test {
    IsPrime public isPrime;

    function setUp() public {
        isPrime = new IsPrime();
    }

    function testPrime() public {
        assertTrue(isPrime.isPrime(2));
        assertTrue(isPrime.isPrime(3));
        assertTrue(!isPrime.isPrime(4));
        assertTrue(!isPrime.isPrime(15));
    }
}
