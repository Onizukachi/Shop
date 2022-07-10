require_relative 'lib/product'
require_relative 'lib/book'
require_relative 'lib/movie'
require_relative 'lib/disk'
require_relative 'lib/productcollection'

xml_path = File.dirname(__FILE__) + '/data/products.xml'

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
