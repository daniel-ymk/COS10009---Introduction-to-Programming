# write code that reads in a user's name from the terminal.  If the name matches
# your name or your tutor's name, then print out "<Name> is an awesome name!"
# Otherwise call a function called print_silly_name(name) - which you must write -
# that prints out "<Name> is a " then print 'silly' (60 times) on one long line
# then print ' name.'

def print_silly_name(name):
    index = 0
    while (index < 60):
        index += 1
        print("silly ", end='')

def main():
    name = input("What is your name?\n")
    if (name == "Ted") or (name == "Fred"):
        print(name + " is an awesome name!")
    else: # replace the code below with a call to print_silly_name()
        print(f"{name} is a") # f allows {name}
        print_silly_name(name)
        print("name!")  
    return

main()

