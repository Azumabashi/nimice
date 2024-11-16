import math
import bigints
import hashes

type Rational* = ref object
  den, num: BigInt

# Just declaration...
func `*`*(x, y: Rational): Rational
func regularizeSign*(x: Rational): Rational
func `-`*(x: Rational): Rational

# constants
const zero = initBigInt(0)
const one = initBigInt(1)

func toRational*(num, den: BigInt): Rational =
  ## Initialize rational number num/den.
  Rational(den: den, num: num).regularizeSign

func toRational*(num, den: string | int): Rational =
  ## Initialize rational number num/den from string or int.
  toRational(initBigInt(num), initBigInt(den))

func abs*(x: Rational): Rational =
  ## Returnx abs(x), i.e., abs(y)/abs(z) if x = y/z.
  Rational(den: abs(x.den), num: abs(x.num))

func regularizeSign*(x: Rational): Rational =
  if x.num == zero:
    return Rational(num: zero, den: one)
  elif x.den < zero xor x.num < zero:
    return Rational(num: -one * abs(x.num), den: abs(x.den))
  else:
    return abs(x)

func reduce*(x: Rational): Rational =
  ## Reduce x.
  assert x.den != zero
  let g = gcd(x.den, x.num)
  let newDen = x.den div g
  let newNum = x.num div g
  toRational(newNum, newDen).regularizeSign

func `+`*(x, y: Rational): Rational =
  ## Return x + y
  let g = lcm(x.den, y.den)
  let cx = g div x.den
  let cy = g div y.den
  Rational(num: x.num * cx + y.num * cy, den: g).reduce

func `-`*(x: Rational): Rational =
  ## Return -x
  Rational(num: -x.num, den: x.den).reduce

func `-`*(x, y: Rational): Rational =
  ## Return x - y
  x + (-y)

func `*`*(x, y: Rational): Rational =
  ## Return x * y
  Rational(num: x.num * y.num, den: x.den * y.den).reduce

func `/`*(x, y: Rational): Rational =
  ## Return x / y, i.e., x * (1 / y)
  Rational(num: x.num * y.den, den: x.den * y.num).reduce

func `$`*(x: Rational): string = 
  ## Stringify x
  $x.num & "/" & $x.den

func `==`*(x, y: Rational): bool = 
  ## Returns true if x and y are the same rational number.
  ## **Note that no reduction will be executed in this function.**
  x.den == y.den and x.num == y.num

func isInt*(x: Rational): bool = 
  ## Returns true if x is an integer
  x.den == one

func `<`*(x, y: Rational): bool =
  ## Returns true if x < y
  (x - y).num < zero

func hash*(x: Rational): Hash =
  hash($x)