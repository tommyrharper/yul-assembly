// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract IfComparison {
    function isTruthy() external pure returns (uint256 result) {
        result = 2;
        assembly {
            // 2 is truthy
            if 2 {
                result := 1
            }
        }

        return result; // returns 1
    }

    function isFalsy() external pure returns (uint256 result) {
        result = 1;
        assembly {
            // 0 is falsy
            if 0 {
                result := 2
            }
        }

        return result; // returns 1
    }

    function negation() external pure returns (uint256 result) {
        result = 1;
        assembly {
            if iszero(0) {
                result := 2
            }
        }

        return result; // returns 2
    }

    function unsafe1NegationPart1() external pure returns (uint256 result) {
        result = 1;
        assembly {
            // in this situation this works
            if not(0) {
                result := 2
            }
        }

        return result; // returns 2
    }

    function bitFlip() external pure returns (bytes32 result) {
        assembly {
            // not of something that isn't zero flips all the bits
            result := not(2)
        }
    }

    function unsafeNegationPart2() external pure returns (uint256 result) {
        result = 1;
        assembly {
            // this will still evaluate to a truth condition
            if not(2) {
                result := 2
            }
        }

        return result; // returns 2
    }
}
