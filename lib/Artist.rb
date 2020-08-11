class Artist
  attr_accessor :name, :song
  @@all = []
  extend Concerns::Findable
  
  def initialize(name)
    @name = name
    @songs = []
  end
  
  def self.all
    @@all
  end
  
  def self.destroy_all
    @@all.clear
  end
  
  def save
    @@all << self
  end
  
  def self.create(artist_name)
    artist = self.new(artist_name)
    artist.save
    artist
  end
  
  def add_song(song)
    if song.artist == nil
      song.artist = self
    end
    if @songs.include?(song)
      nil
    else
      @songs << song
    end
    song
  end
  
  def songs
    @songs
  end
  
  def genres
    @songs.collect {|song| song.genre}.uniq
  end
end