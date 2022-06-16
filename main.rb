require_relative 'lib/product'
require_relative 'lib/book'
require_relative 'lib/movie'
require_relative 'lib/disk'
require_relative 'lib/productcollection'

curr_path = File.dirname(__FILE__)

leon = Movie.new(price: 290, amount: 10, title: "Леон", director: "Люк Бессон", year: 1998)
durak = Movie.new(price: 400, amount: 13, title: "Дурак", director: "Юрий Быков", year: 2019)
nachalo = Movie.new(price: 330, amount: 7, title: "Начало", director: "Кристофер Нолан", year: 2010)

sao = Book.new(price: 40, amount: 4, title: "SAO", author: "Hikaru", genre: "LitRpg")

film = Movie.from_file('./data/films/01.txt')

film2 = Movie.new(price: 290, amount: 10, title: "Леон", director: "Люк Бессон", year: 1998)

book = Book.from_file('./data/books/03.txt')

# begin
#   x = Product.from_file('./data/books/04.txt')  #родитель не должен уметь считывать файл
# rescue NotImplementedError
#   puts "Файл не удалось считать"
# end

collection = ProductCollection.from_dir(File.dirname(__FILE__) + '/data')

 collection.sort!(by: :price)

# collection.to_a.each do |product|
#   puts product
# end
xml_path = File.dirname(__FILE__) + '/data/products.xml'

# disks_xml = Disk.from_xml(xml_path)

# movies_xml = Movie.from_xml(xml_path)

# books_xml = Book.from_xml(xml_path)

# p disks_xml

# puts 

# p movies_xml

# puts

products = ProductCollection.from_xml(xml_path)
products.sort!(by: :amount, order: :asc)

puts "Что хотите купить?:\n"
puts

choice = nil
total_amout = 0

while choice != 'x'
  products.list
  choice = STDIN.gets.chomp
  total_amout += products.buy(choice.to_i)
  puts 
end

puts "Спасибо за визит\n Ваш чек #{total_amout}"





