class Track
	attr_accessor :name, :location

	def initialize (name, location)
		@name = name
		@location = location
	end
end


def read_tracks(music_file)
  count = music_file.gets().to_i()
  tracks = Array.new()
  i = 0
  # Put a while loop here which increments an index to read the tracks
  while i < count
    track = read_track(music_file)
    tracks << track
    i += 1
  end
  puts tracks
  return tracks
end

def read_track(a_file)
  i = 0
  while i <= 2
  


  end
  retrun single_track
  # complete this function
	# you need to create a Track here.
end

def main()
  a_file = File.new("input.txt", "r") # open for reading
  
  # Print all the tracks
  print_tracks(tracks)
end

main()
