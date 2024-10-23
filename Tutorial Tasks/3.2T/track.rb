require "./input_functions"
# put your code below
class Track
    attr_accessor :name, :location
    def initialize(name, location)
        @name=name
        @location= location
    end
end

def read_track()
    new_name = read_string('Enter track name: ')
    new_location= read_string('Enter track location ')
    new_track= Track.new(new_name, new_location)
    return new_track
end

def print_track(new_track)
    puts('Track name: ' + new_track.name)
    puts('Track location: ' + new_track.location)
end

def main()
    track = read_track()
	print_track(track)
end

# leave this line
main() if __FILE__ == $0
