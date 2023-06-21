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
            // the max this works for is 32 bytes
            myString := "hello world"
        }

        // this would work but it causes the test to fail due to the trailing zeros
        // return string(abi.encode(myString));

        // hence this is used instead to make the string comparison work with the trailing zeros
        return bytes32ToString(myString);
    }

    // this removes the trailing zeros
    function bytes32ToString(
        bytes32 _bytes32
    ) public pure returns (string memory) {
        uint8 i = 0;
        while (i < 32 && _bytes32[i] != 0) {
            i++;
        }
        bytes memory bytesArray = new bytes(i);
        for (i = 0; i < 32 && _bytes32[i] != 0; i++) {
            bytesArray[i] = _bytes32[i];
        }
        return string(bytesArray);
    }

    function getBool() external pure returns (bool) {
        bool x;

        assembly {
            x := 1
        }

        return x;
    }

    function getAddress() external pure returns (address) {
        address x;

        assembly {
            x := 1
        }

        return x;
    }
}
