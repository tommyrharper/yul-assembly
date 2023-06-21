// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract IsPrime {
    function isPrime(uint256 x) public pure returns (bool p) {
        p = true;
        assembly {
            // yul writes out math expressions as function invocations
            // division happens first because it is the innermost function
            let halfX := add(div(x, 2), 1)
            for {
                // initializing
                let i := 2
                // stopping condition
            } lt(i, halfX) {
                // updating the counter
                i := add(i, 1)
            } {
                if iszero(mod(x, i)) {
                    // set p to false
                    p := 0
                    break
                }
            }
        }
    }

    function isPrimeV2(uint256 x) public pure returns (bool p) {
        p = true;
        assembly {
            let halfX := add(div(x, 2), 1)
            let i := 2
            // can do it like this as well
            for { } lt(i, halfX) { } {
                // using izero is more conventional, but eq works too
                if eq(mod(x, i), 0) {
                    p := 0
                    break
                }

                i := add(i, 1)
            }
        }
    }
}
