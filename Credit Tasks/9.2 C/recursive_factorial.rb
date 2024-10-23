# Recursive Factorial

# Complete the following
def factorial(number)
  if number <= 1
  number
  else
  number* (factorial(number-1))
  end
end

def main()
    if (ARGV[0].to_i) > 0
    puts(factorial(ARGV[0].to_i))
	  else
      puts("Incorrect argument - need a single argument with a value of 0 or more.")
	  end
  end


main()
