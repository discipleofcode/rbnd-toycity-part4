class Module
  def create_finder_methods(*attributes)
    attributes.each do |attrib|
      new_method = %{
          def self.find_by_#{attrib}(search_phrase) 
            all.find {|product| product.#{attrib} == search_phrase}
          end
        }
      
      self.class_eval new_method
    end
  end
end
