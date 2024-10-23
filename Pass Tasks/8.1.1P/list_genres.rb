
# put the genre names array here:
module Genre
  POP, CLASSIC, JAZZ, ROCK = *1..3
end

Genre_names = ['Pop', 'Classic', 'Jazz', 'Rock']

def main()
    i = 0
    while i < Genre_names.length
    puts( (i+1).to_s + " " + Genre_names[i])
    i += 1
    end

end

main()
