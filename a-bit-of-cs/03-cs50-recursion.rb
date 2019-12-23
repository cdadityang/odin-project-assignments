def collatz(n, s = 0)
  return s if n == 1
  if(n%2 == 0)
    n = n/2
    s = s + 1
    collatz(n, s)
  else
    n = ((3 * n) + 1)
    s = s + 1
    collatz(n, s)
  end
end

p collatz(27)

## Or this solution

=begin

def collatz(n)
  return 0 if n == 1
  if(n%2 == 0)
    return 1 + collatz(n/2)
  else
    return 1 + collatz(((3 * n) + 1))
  end
end

=end