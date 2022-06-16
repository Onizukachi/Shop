require 'rexml/document'

class Product
  attr_accessor :price, :amount
  include REXML

  def initialize(params)
    @price = params[:price]
    @amount = params[:amount]
  end

  def to_s
    " — #{@price} руб. [осталось: #{@amount}]"
  end

  def update(params)  
    @price = params[:price] if params[:price]
    @amount = params[:amount] if params[:amount]
  end

  def self.from_file(file_path)
    raise NotImplementedError
  end

  def self.from_xml(file_path)
    raise NotImplementedError
  end

end