# Assembly Yul Course

- Github Code: https://github.com/RareSkills/Udemy-Yul-Code
- Course on Udemy: https://www.udemy.com/course/advanced-solidity-yul-and-assembly

## Bitwise operations on 32 byte words

- Warning: there is no overflow protection in yul
- Complete list: https://docs.soliditylang.org/en/v0.8.20/yul.html#evm-dialect

| solidity | YUL       |
|----------|-----------|
| a && b   | and(a, b) |
| a OR b   | or(a, b)  |
| a ^ b    | xor(a, b) |
| a + b    | add(a, b) |
| a - b    | sub(a, b) |
| a * b    | mul(a, b) |
| a / b    | div(a, b) |
| a % b    | mod(a, b) |
| a >> b   | shr(b, a) |
| a << b   | shl(b, a) |
