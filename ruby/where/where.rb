class Array
  def where(what)
    results = []
    self.each do |quoteHash|
      what.each do |key,value|
        if what[key].class == Regexp 
          results << quoteHash if what[key] =~ quoteHash[key]
        else
          results << quoteHash if what[key] == quoteHash[key]
        end
      end
    end
    return results
  end
end
