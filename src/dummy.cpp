#include "dummy.hpp"

#include <algorithm>

auto fib(int x) noexcept -> int
{
  int a = 0, b = 1;
  for (int i = 0; i < x; ++i) {
    auto olda = a;
    a = b;
    b = olda + b;
  }

  return a;
}
