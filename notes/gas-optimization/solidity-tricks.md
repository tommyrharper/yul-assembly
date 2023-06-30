# Solidity Tricks

- If you have a function that is very gas sensitive, make sure it's function selector is near the top in the assembly code (which means near the bottom of the solidity code), as it costs more the further down the JUMPI statement the function selector is.
- The other thing to note here, is that when changing a function name, it may change the gas cost, so watch out when testing gas optimizations.

```solidity
contract Example {
    // most expensive - 44 gas more expensive than blue()
    function red() pubic {
        // do something
    }
    // 22 gas more expensive
    function green() pubic {
        // do something
    }
    // cheapest
    function blue() pubic {
        // do something
    }
}
```

## Less than or equal to

- EVM has no <= or => operator inbuilt
  - Hence `x <= 2` gets translated into `!(2 < x)`
  - Hence `<` & `>` is more efficient than `<=` `=>`

## Bit Shifting

When you multiply or divide by 2, you are really just shifting the bits left or right

```solidity
// more expensive
contract Regular {
    // 21,469
    function multiplyByTwo(uint256 n) public {
        unchecked {
            return n * 2;
        }
    }

    // 21,450
    function divideByTwo(uint256 n) public {
        unchecked {
            return n / 2;
        }
    }
}

// cheaper
contract Shift {
    // 21,467
    function multiplyByTwo(uint256 n) public {
        // WARNING - can overflow
        return n << 1;
    }

    /// this may be more expensive, need to check
    function multiplyByTwoCannotOverflow(uint256 n) public {
        // cannot overflow
        uint256 x = n << 1;
        require(x >= n, "overflow");
        return x;
    }

    // 21,445
    function divideByTwo(uint256 n) public {
        return n >> 1;
    }
}
```

## Reverting early

- Always revert as early as possible to save users gas.

## Short Circuiting

- Solidity shortcut evaluates & and || evaluators.
  - Hence do the cheapest operations/most likely to short circuit first.
    - To evaluate, multiple gas cost * likelihood of short circuiting, and put highest value first.

## Precomputing

```solidity
contract Precompute {
    function div() external pure returns(uint256) {
        // solidity will precompute this to 11 (hex b)
        return 22 / 2;
    }

    function mul() external pure returns(uint256) {
        // solidity will precompute this to 21 (hex 15)
        return 3 * 7;
    }

    // the solidity compiler will not optimize this with precomputation
    function devUnoptimized() external pure returns(uint256) {
        uint256 a = 2;
        return 22 / a;
    }

    // precomputed/optimized by the solidity compiler
    function functionSignatureOptimized() external pure returns(bytes4) {
        return bytes4(keccak256("withdraw()"));
    }

    // not optimized/precomputed by the solidity compiler
    function hashNotOPtimized() external pure returns(bytes32) {
        return keccak256(abi.encodePacked(uint256(2 + 3)));
    }
}
```
