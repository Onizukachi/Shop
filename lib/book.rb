class Book < Product
  attr_reader :author, :genre, :title

  def initialize(params)
    super
    @title = params[:title]
    @genre = params[:genre]
    @author = params[:author]
  end

  def self.from_file(file_path)
    lines = File.readlines(file_path, encoding: 'UTF-8').map { |l| l.chomp }

    self.new(
      title: lines[0],
      genre: lines[1],
      author: lines[2],
      price: lines[3].to_i,
      amount: lines[4].to_i
    )
  end

  def self.from_xml(path)
    begin
      file = File.open(path, 'r:UTF-8')
    rescue => e
      puts e.message
    end

    doc = Document.new(file)

    books = []
    doc.root.elements.each("books/book") do |el| 
      books << self.new(
        title: el.text,
        genre: el.attributes["genre"],
        author: el.attributes["author"],
        price: el.attributes["price"].to_i,
        amount: el.attributes["amount"].to_i
      )
    end

    books
  end

  def to_s
    "Книга «#{title}», #{genre}, автор: #{author}#{super}"
  end

  def update(params)
    super

    @title = params[:title] if params[:title]
    @genre = params[:genre] if params[:genre]
    @author = params[:author] if params[:author]
  end
end
