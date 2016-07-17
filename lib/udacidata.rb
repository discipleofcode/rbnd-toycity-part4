require_relative 'find_by'
require_relative 'errors'
require 'csv'

class Udacidata
  
  @@file = File.dirname(__FILE__) + "/../data/data.csv"
  
  create_finder_methods :brand, :name

  def self.create(opts={})
    
    brand = opts[:brand]
    name  = opts[:name]
    price = opts[:price]
    id = opts[:id]

    product = self.new(id: id, brand: brand, name: name, price:price)

    CSV.open(@@file, "a+") do |csv|
      csv << [product.id, product.brand, product.name, product.price]
    end
     
    product
  end
  
  def update opts={}
    brand = opts[:brand] || @brand
    name = opts[:name] || @name
    price = opts[:price] || @price
    id = @id
    
    Product.destroy id

    Product.create(id: id, brand: brand, name: name, price: price)
  end
  
  def self.destroy id
    product = self.find id
    
    table = CSV.table(@@file)

    table.delete_if do |row|
     row[:id] == product.id
    end

    File.open(@@file, 'wb') do |f|
      f.write(table.to_csv)
    end
    
    return product
  end
  
  def self.convert_row_to_product row
    new(id: row['id'], brand: row['brand'], name: row['product'], price: row['price'])
  end
  
  def self.find id
    all.find { |product| product.id == id }
  end
  
  def self.all
    products = []
    CSV.foreach(@@file, headers:true) do |row|
      products << convert_row_to_product(row)
    end
    
    products
  end
  
  def self.first n = 1
    if n == 1
      all.first
    elsif n > 1  
      all.first(n)
    end      
  end
  
  def self.last n = 1
    if n == 1
      all.reverse.first
    elsif n > 1
      all.reverse.first(n)
    end      
  end
  
  def self.where(opts = {})
    all.find_all {|product| product.brand == opts[:brand] || product.name == opts[:name] }
  end
  
end
