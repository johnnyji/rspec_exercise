class Library
  attr_accessor :books

  def initialize(library_file = false)
    @library_file = library_file
    @books = @library_file ? YAML::load(File.read(@library_file)) : []
  end

  def get_books_in_category(category)
    @books.select {|book| book.category == category}
  end

  def add_book(book)
    @books << book
  end

  def get_book(title)
    @books.find {|book| book.title == title}
  end

  def save(library_file = false)
    @library_file = library_file || @library_file || 'library.yml'
    File.open @library_file, 'w' do |f|
      f.write YAML::dump @books
    end
  end
end