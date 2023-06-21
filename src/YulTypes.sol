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
            // Yul has only one type, the 32 byte word (256 bits)
            x := 0xa
        }

        return x;
    }

    function getStringYulNonsense() external pure returns (string memory) {
        string memory myString = "";

        assembly {
            // this is setting the pointer on the stack myString to be a string - nonsense 
            myString := "hello world"
        }

        return myString;
    }

    function getStringAsBytesYul() external pure returns (bytes32) {
        bytes32 myString = "";

        assembly {
            // this is setting the pointer on the stack myString to be a string - nonsense 
            myString := "hello world"
        }

        return myString;
    }

    function getStringYul() external pure returns (string memory) {
        bytes32 myString = "";

        assembly {
            // this is setting the pointer on the stack myString to be a string - nonsense 
            myString := "hello world"
        }

        return string(abi.encode(myString));
    }
}
