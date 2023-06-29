# Storage Gas Costs

- SSTORE => 20k gas, 1 order of magnitude more expensive than most operations

## Gas Costs

- Update storage 0 to non-zero => 20k
- Update storage non-zero to non-zero => 5k
- Update storage from non-zero to zero => refund
- Pay additional 2.1k for the first time accessing a variable in a transaction
- Pay additional 100 if the variable has already been touched

### Notes

Doing a storage read and then a write is similar to the cost of doing a storage write.

- Read plus write
  - 2.1k (Read + Cold Access) + 20.1k (Write + Warm access) = 22.2k
- Write without a read
  - 22.1k (write + cold access) = 22.1k
- Cost(Read + Write) ≈ Cost(Write)

## Small Integers

Setting an 8 bit integer does not save gas over a 256 bit integer. Under the hood it is still a 32 byte slot for both.

## Unchanged Storage Values

If you set a storage value to the value that it already was, you pay less gas. 2.2k gas (2.1k for warm load, then 100 gas extra)

Nevertheless, you can save gas by checking before hand if a value is going to change:
```solidity
contract SameValue {
    uint256 private myInteger = 1;

    function maybeSet(uint256 i) external payable {
        uint256 _myInteger = myInteger;
        require(_myInteger != 100);
        // this saves gas
        if (_myInteger != i) {
            myInteger = i;
        }
    }
}
```

This trick only works if the workflow of your code requires to read the storage variable before reading it.

This may end up costing more gas if most of the time the integer is changed.

## Arrays

Costs extra to update as you have to update the array length also.

For example, to store this array [1, 2] - it will cost around 66k gas => 22k x 2 for both the values, and 22k for the length.

### Example

Not using push

[2] => [2,9]

- Gas = ~51k
  - 21k tx, 22k to add 9. 5k to update length, 2k to re-write 2 = 21k + 22k + 5k + 2k = 50k


### Refunds

- RSCLEAR = 15k added into refund counter when changing from non-zero to zero value
  - Still have to pay 2.9k for Gsreset and 2.1k for Gcoldsload

You cannot get a 15k gas refund if your transaction costs less than 75k gas. It only goes up to one fifth the transaction cost after the 21k base cost.

### Summary

1. Setting to zero can cost between 200-5000 gas
2. Deleting an array (or setting many values to zero) can be expensive. Beware of the 20% rule
3. Setting one variable to zero is okay. Setting several variables to zero is like doing several non-zero to non-zero operations.
4. For every zero operation, try to spend 24k gas elsewhere (tsn cost, or setting zero to non-zero)
5. Counting down is more effective than counting up

## Strings

- Under 32 bytes => fits in 1 slot
- Over 32 bytes => 1 slot for every 32 bytes + an extra slot to store the length

## Structs

```solidity
// this only uses up two slots due to storage compacting/variable packing
struct MyStruct {
    uint256 a;
    address b;
    bool c;
}
```

## Variable Packing

It actually requires more work to use storage packed variables due to the extra logic around bitmasking etc.

However if you update all or a group of the variables packed into the same slot in the same transaction, then it can be more efficient to pack them.
