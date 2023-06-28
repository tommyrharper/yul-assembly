# Gas Costs

- Transaction cost: 21k gas
- Storage load: 2.1k gas

## Block Gas Limit

Throughput - transactions per second. ~30 million gas per block.
Tornado Cash is ~1m gas per transaction - so 30 transactions per block - 2.5 transactions per second.
Ethereum transfers are 21k gas - so 1428 transactions per block - 119 transactions per second.

## Sneaky gas costs

- Op codes - however much
- Tx cost - 21000
- tx.data - depends on how much data is in the transaction

## 5 ways to save gas

- On deployment - smaller contract - less paid on deployment
- During computation - fewer or cheaper opcodes
- Transaction data - the less transaction data, (the less non-zero bytes in it) the less the gas cost
- Storage - the less storage you use, the less gas you pay


