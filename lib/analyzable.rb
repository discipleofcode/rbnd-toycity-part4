module Analyzable

  def average_price products
    # hmm, Ive added round(2) cause I was getting 14.94999...98 insted of 14.95
    # anything else I could do ?
    (products.inject(0){ |sum, product| sum + product.price.to_f } / products.size).round(2)
  end
  
  def count_by_brand products
    brands_hash = Hash.new(0)
    products.each { |p| brands_hash[p.brand] += 1 }
    
    return brands_hash
  end
  
  def count_by_name products
    names_hash = Hash.new(0)
    products.each { |p| names_hash[p.name] += 1 }
    
    return names_hash
  end
  
  def print_report products
    puts "Inventory by Brand:"
    count_by_brand(products).each do |brand, stock|
      puts "  - #{brand}: #{stock}"  
    end
    
    puts ""
    
    puts "Inventory by Name:"
    count_by_name(products).each do |name, stock|
      puts "  - #{name}: #{stock}"  
    end
    
    average_price(products).to_s
  end
end
