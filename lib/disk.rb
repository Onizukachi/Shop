class Disk < Product
  attr_reader :title, :genre

  def initialize(params)
    super
    @title = params[:title]
    @genre = params[:genre]
  end

  def self.from_file(file_path)
    lines = File.readlines(file_path, encoding: 'UTF-8').map { |l| l.chomp }

    self.new(
      title: lines[0],
      genre: lines[1],
      price: lines[2].to_i,
      amount: lines[3].to_i
    )
  end

  def self.from_xml(path)
    begin
      file = File.open(path, 'r:UTF-8')
    rescue => e
      puts e.message
    end

    doc = Document.new(file)

    disks = []
    doc.root.elements.each("disks/disk") do |el| 
      disks << self.new(
        title: el.text,
        genre: el.attributes["genre"],
        price: el.attributes["price"].to_i,
        amount: el.attributes["amount"].to_i
      )
    end

    disks
  end

  def to_s
    "Диск #{title} (#{genre})#{super}"
  end

  def update(params)
    super

    @title = params[:title] if params[:title]
    @genre = params[:genre] if params[:genre]
  end
end