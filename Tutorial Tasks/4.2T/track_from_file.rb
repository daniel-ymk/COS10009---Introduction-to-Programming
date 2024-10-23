# put your code here:
class Track
    attr_accessor :name, :location
    def initialize(name, location)
        @name=name
        @location= location
    end
end

def read_track(a_file)
    new_track= Track.new(a_file.gets, a_file.gets)
    return new_track
end

def print_track(new_track)
    puts('Track name: ' + new_track.name)
    puts('Track location: ' + new_track.location)
end

def main()
    track = File.new("track.txt", "r")
    a_file = read_track(track)
    track.close
    print_track(a_file)
end

main() if __FILE__ == $0 # leave this 
