class Book
  attr_accessor :author, :page_count
  attr_reader :title, :genre

  GENRES = []

  def initialize(title)
    @title = title
  end

  def turn_page
    puts "Flipping the page...wow, you read fast!"
  end

  # creates the writer for genre and adds the logic for the class constant
  def genre=(genre)
    @genre = genre
    GENRES << genre
  end
end
