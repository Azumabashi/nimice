# nimice
Yet another rational number library implemented by Nim.
For usage, see test programs.

## Alternatives
- [Standard rational library](https://nim-lang.org/docs/rationals.html)
- https://github.com/ykoba1994/bignumber.nim
- https://github.com/pietroppeter/nim-bigints

In most of the cases, the standard library should be enough.
Why I have created this is that the library does not work for `Rational[BigInt]`.
For example, following code yields compile error:

```nim
import rationals, bigints

let a = initBigInt(1)
let b = initBigInt(2)
let c = initBigInt(3)
let d = initBigInt(4)

echo Rational[BigInt](den: a, num: b) * Rational[BigInt](den: c, num: d)
```

## License
MIT