require './input_functions'

# It is suggested that you put together code from your 
# previous tasks to start this. eg:
# 8.1T Read Album with Tracks

module Genre
  POP, CLASSIC, JAZZ, ROCK = *1..4
end

$genre_names = ['Null', 'Pop', 'Classic', 'Jazz', 'Rock']
$album_read = false
class Album
# NB: you will need to add tracks to the following and the initialize()
	attr_accessor :artist, :title, :label, :genre, :tracks

# complete the missing code:
	def initialize (artist, title, label, genre, tracks)
		@artist = artist
		@title = title
		@label = label
		@genre = genre
		@tracks = tracks
	end
end

class Track
	attr_accessor :name, :location

	def initialize (name, location)
		@name = name
		@location = location
	end
end

# Reads in and returns a single track from the given file

def read_track(music_file)
	single_track = Track.new(music_file.gets, music_file.gets)
	return single_track
end

# Returns an array of tracks read from the given file

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
	return tracks
end

# Takes an array of tracks and prints them to the terminal

def print_tracks(tracks)
	i = 0

	while i < tracks.length 
	print((i+1).to_s + "  Track name: ")
	print_track(tracks[i])
	i+=1
	end
end

# Takes a single track and prints it to the terminal
def print_track(track)
  	puts(track.name)
	#puts(track.location)
end

def main_menu()
  finished = false
  begin
    puts 'Main Menu:'
    puts '1 Read in Albums'
    puts '2 Display Albums'
    puts '3 Select an Album to play'
	puts '5 Exit the application'
    choice = read_integer_in_range("Please enter your choice:", 1, 5)
    case choice
    when 1
      	albums = read_in_albums()
		if albums != nil
			$album_read = true
		else
			$album_read = false
		end
    when 2
      display_albums(albums)
	  when 3
      play_album(albums)
    when 5
      finished = true
    else
      puts "Please select again"
    end
  end until finished
end


def read_in_albums()
	input = read_string("Enter a file path to an Album:")
	if input == "albums.txt"
		music_file = File.new(input, "r")
		albums = read_albums(music_file)
		music_file.close()
		return albums
	else
		puts ("\nNo input file was found!\n")
	end
end

def display_albums(albums)
	if $album_read != true
		puts ("\nNo Album has been Read In!\n\n")
	else
     	finished= false
     	begin
     		puts 'Display Albums Menu:'
     		puts '1 Display All Albums'
     		puts '2 Display Albums by Genre'
     		puts '3 Return to Main Menu'
     		choice = read_integer_in_range("Please enter your choice:", 1, 3)
     	case choice
     		when 1
       		display_all_albums(albums)
     		when 2
       		display_genre(albums)
     		when 3
       		finished = true
     		else
       		puts "Please select again"
     		end
   		end until finished
	end
end

def play_album(albums)
	if $album_read != true
		puts ("\nNo Album has been Read In!\n\n")
	else
		display_all_albums(albums)
		begin
			select_album = read_integer("Enter Album number:")
		end while select_album > albums.length or select_album <= 0
		
		print_album(albums[select_album-1])
		puts("\n")
		if albums[select_album-1].tracks.length == 0
		return puts "No tracks were found"
		else
		tracks = albums[select_album-1].tracks
		print_tracks(tracks)
		begin
		select_track  = read_integer("Select a Track to play:")
		end while select_track > tracks.length or select_track <= 0
		print("Playing track " + albums[select_album-1].tracks[select_track-1].name.strip + " from album " + albums[select_album-1].title.strip + "\n\n" )
		sleep(3)
		end
	end
end

def read_albums(music_file)
	count = music_file.gets().to_i
	albums = Array.new()
	i = 0
	while i < count
	album = read_album(music_file)
	albums << album
	i += 1
	end
	return albums
end


def read_album(file)
	album = Album.new(file.gets, file.gets, file.gets, file.gets.to_i, read_tracks(file))
	return album
end


def display_all_albums(albums)
	i = 0
	while i < albums.length
	print((i+1).to_s + ": ")
	puts("Title: #{albums[i].title.strip} Artist: #{albums[i].artist.strip} Label: #{albums[i].label.strip} Genre: #{$genre_names[albums[i].genre.to_i].strip}")
	i += 1
	end
end

# Takes a single album and prints it to the terminal along with all its tracks
def print_album(album)
	puts("Title: #{album.title.strip} Artist: #{album.artist.strip} Label: #{album.label.strip} Genre: #{$genre_names[album.genre.to_i].strip}")
end


#Display Albums by Genre
def display_genre(albums)
    i = 0
	begin
	user_input = read_integer("1. Pop\n2. Classic\n3. Jazz\n4. Rock")
	end while user_input < 1 or user_input > 4
	tracks_count = 0
	while i < albums.length
		if user_input == albums[i].genre.to_i
			puts("Title: #{albums[i].title.strip} Artist: #{albums[i].artist.strip} Label: #{albums[i].label.strip} Genre: #{$genre_names[albums[i].genre.to_i].strip}")
			tracks_count += 1
		end
	i += 1
	end
	if tracks_count == 0
		puts ("\nNo tracks were found in this genre\n\n")
	end
end



# Reads in an album from a file and then print the album to the terminal

def main()
	main_menu()
end

main()

