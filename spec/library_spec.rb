require_relative "spec_helper"

describe "Library object" do
  before :all do
    library_object = [
      Book.new("JavaScript: The Good Parts", "Douglas Crockford", :development),
      Book.new("Designing with Web Standards", "Jeffrey Zeldman", :design),
      Book.new("Don't Make me Think", "Steve Krug", :usability),
      Book.new("JavaScript Patterns", "Stoyan Stefanov", :development),
      Book.new("Responsive Web Design", "Ethan Marcotte", :design)
    ]
    File.open 'books.yml', 'w' do |f|
      f.write YAML::dump library_object
    end
  end

  before :each do
    @lib = Library.new "books.yml"
  end

  describe '#new' do
    context 'with no parameters' do
      it 'has no books' do
        lib = Library.new
        lib.should have(0).books
      end
    end

    context 'with a YAML file parameter' do
      it 'has five books' do
        @lib.should have(5).books
      end
    end
  end

  it 'returns all books in a given category' do
    @lib.get_books_in_category(:development).length.should == 2
  end

  it 'accepts new books' do
    @lib.add_book(Book.new('Garfield', 'Jim Davis', :other))
    @lib.books.should have(6).books
    @lib.get_book('Garfield').should be_an_instance_of Book
  end

  it 'saves the library' do
    books_in_lib = @lib.books.map {|book| book.title}
    @lib.save
    lib2 = Library.new 'books.yml'
    books_in_lib2 = lib2.books.map {|book| book.title}
    books_in_lib.should == books_in_lib2
  end
end
