class Movie < Product
  attr_reader :title, :year, :director

  def initialize(params)
    super
    @title = params[:title]
    @year = params[:year]
    @director = params[:director]
  end

  def self.from_file(file_path)
    lines = File.readlines(file_path, encoding: 'UTF-8').map { |l| l.chomp }

    self.new(
      title: lines[0],
      director: lines[1],
      year: lines[2].to_i,  # Конвертируем в число, чтобы превратить также nil в 0
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

    movies = []
    doc.root.elements.each("movies/movie") do |el| 
      movies << self.new(
        title: el.text,
        director: el.attributes["director"],
        year: el.attributes["year"],
        price: el.attributes["price"].to_i,
        amount: el.attributes["amount"].to_i
      )
    end

    movies
  end

  def to_s
    "Фильм «#{title}», реж. #{director} (#{year})#{super}"
  end

  def update(params)
    super

    @title = params[:title] if params[:title]
    @year = params[:year] if params[:year]
    @director = params[:director] if params[:director]
  end
  
end