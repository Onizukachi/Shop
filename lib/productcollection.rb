class ProductCollection
  PRODUCT_TYPES = {
    film: {dir: 'films', class: Movie},
    book: {dir: 'books', class: Book},
    disk: {dir: 'disks', class: Disk}
  }

  def initialize(products = [])
    @products = products
    @total_amout = @products.size
  end

  def self.from_dir(dir_path)
    products = []

    PRODUCT_TYPES.each do |type, hash|
      product_dir = hash[:dir]
      product_class = hash[:class]

      Dir[dir_path + '/' + product_dir + '/*.txt'].each do |path|
        products << product_class.from_file(path)
      end
    end

    self.new(products)
  end

  def self.from_xml(path)
    products = []

    PRODUCT_TYPES.each do |type, hash|
      begin
        products << hash[:class].from_xml(path)
      rescue
      end
    end

    self.new(products.flatten)
  end

  def to_a
    @products
  end

  def list
    unless @products.empty?
      @products.each_with_index { |x, i| puts "#{i+1}. #{x}"}
      puts "x. Покинуть магазин"
    else
      return "Магазин пустой"
    end
  end

  def sort!(params)
    case params[:by]
    when :title
      @products.sort_by! { |product| product.to_s }
    when :price
      @products.sort_by! { |product| product.price }
    when :amount
      @products.sort_by! { |product| product.amount }
    end

    @products.reverse! if params[:order] == :asc
    self
  end

  def buy(index)
    if index.to_i < 1 || index.to_i > @products.size
      puts "Такого продукта нет" 
      return 0
    end
    choice = @products[index.to_i - 1] 

    if choice.amount > 0
      choice.amount -= 1
      puts "Поздраввляем с покупкой - #{choice}\n"
      return choice.price
    else
      puts "Товар закончился, приходите позже"
      return 0
    end
  end
end
