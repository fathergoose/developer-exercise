class Array
  def where(what)
    results = []
    self.each do |quoteHash|
      what.each do |key,value|
        if quoteHash[key] == what[key]
          results << quoteHash
        end
      end
    end
    return results
  end
end
