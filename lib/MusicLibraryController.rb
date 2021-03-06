class MusicLibraryController
    def initialize(path = './db/mp3s')
      @path = path
      MusicImporter.new(path).import
    end
    
    def call
      user_input = gets.chomp
      user_input != exit
      puts "Welcome to your music library!"
      puts "To list all of your songs, enter 'list songs'."
      puts "To list all of the artists in your library, enter 'list artists'."
      puts "To list all of the genres in your library, enter 'list genres'."
      puts "To list all of the songs by a particular artist, enter 'list artist'."
      puts "To list all of the songs of a particular genre, enter 'list genre'."
      puts "To play a song, enter 'play song'."
      puts "To quit, type 'exit'."
      puts "What would you like to do?"
    end

    def list_songs
        Song.all.sort {|a, b| a.name <=> b.name}.each_with_index do |song, i|
            puts "#{i + 1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
        end
    end

    def list_artists
        Artist.all.sort {|a, b| a.name <=> b.name}.each_with_index do |artist, i|
            puts "#{i + 1}. #{artist.name}"
        end
    end

    def list_genres
        Genre.all.sort {|a, b| a.name <=> b.name}.each_with_index do |genre, i|
            puts "#{i + 1}. #{genre.name}"
        end
    end

    def list_songs_by_artist
        puts "Please enter the name of an artist:"
        user_input = gets.chomp

        if artist = Artist.find_by_name(user_input)
            artist.songs.sort {|a, b| a.name <=> b.name}.each_with_index do |song, i|
                puts "#{i + 1}. #{song.name} - #{song.genre.name}"
            end
        end
    end

    def list_songs_by_genre
        puts "Please enter the name of a genre:"
        user_input = gets.chomp

        if genre = Genre.find_by_name(user_input)
            genre.songs.sort {|a, b| a.name <=> b.name}.each_with_index do |song, i|
                puts "#{i + 1}. #{song.artist.name} - #{song.name}"
            end
        end
    end

    def play_song
        puts "Which song number would you like to play?"
        user_input = gets.chomp.to_i
        if user_input > 0 && user_input <= Song.all.length
            sorted_songs = Song.all.sort {|a, b| a.name <=> b.name}
            chosen_song = sorted_songs[user_input - 1]
            puts "Playing #{chosen_song.name} by #{chosen_song.artist.name}"
        end
    end
  end