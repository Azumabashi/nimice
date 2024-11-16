import unittest

import nimice

test "stringify":
  check $toRational(2, 3) == "2/3"
  check $toRational("2", "4") == "2/4"
  check $toRational("-1", "1") == "-1/1"

test "add":
  let x = toRational(1, 3)
  let y = toRational(1, 2)
  let z = toRational("100000000000000000000000000000000", "200000000000000000000000000000000")
  let neg = toRational(-1, 2)
  check x + y == toRational(5, 6)
  check y + z == toRational(1, 1)
  check y + neg == toRational(0, 1)
  check neg == toRational(1, -2)

test "abs":
  let den = 2
  let num = 3
  let r = toRational(num, den)
  check abs(r) == r
  check abs(toRational(-num, den)) == r
  check abs(toRational(num, -den)) == r
  check abs(toRational(-num, -den)) == r

  var a = toRational(-2, 5)
  a += toRational(1, 2)
  check a == toRational(1, 10)

test "regularize sign":
  let den = 2
  let num = 3
  let r = toRational(num, den)
  let s = toRational(-num, den)
  check r.regularizeSign == r
  check s.regularizeSign == s
  check toRational(-num, -den).regularizeSign == r
  check toRational(num, -den).regularizeSign == s

test "negate":
  let x = toRational(1, 3)
  check -x == toRational(-1, 3)
  check -(-x) == x
  let y = toRational(1, -2)
  check -y == toRational(1, 2)
  check -(-y) == toRational(-1, 2)

test "minus":
  let x = toRational(1, 3)
  let y = toRational(1, 2)
  check x - y == toRational(-1, 6)
  check y - x == toRational(1, 6)

  var a = toRational(1, 3)
  a -= toRational(1, 2)
  check a == toRational(-1, 6)

test "product":
  let x = toRational(2, 3)
  let y = toRational(1, 2)
  check x * y == toRational(1, 3)
  check y * x == toRational(1, 3)

  check toRational(1, 3) * toRational(-1, 2) == toRational(-1, 6)

test "division":
  let x = toRational(1, 3)
  let y = toRational(1, 2)
  check x / y == toRational(2, 3)
  check toRational(2, 1) / toRational(4, 1) == toRational(1, 2)

test "larger than":
  let x = toRational(1, 3)
  let y = toRational(1, 2)
  check x < y
  check not (y < x)
  check not (x < x)

test "equal to or larger than":
  let x = toRational(1, 3)
  let y = toRational(1, 2)
  check x <= y
  check not (y <= x)
  check x <= x

test "reduce":
  check toRational(1, 2).reduce == toRational(1, 2)
  check toRational(2, 4).reduce == toRational(1, 2)
  check toRational(21, -14).reduce == toRational(-3, 2)

test "sum":
  check @[
    toRational(-1, 3), toRational(-1, 2),
    toRational(1, 3), toRational(1, 2)
  ].sum == toRational(0, 1)
  check @[
    toRational(1, 2), toRational(1, 3), toRational(1, 6)
  ].sum == toRational(1, 1)