class Array
  def where(what)
    results = self.dup
    self.each_with_index do |quoteHash|
      what.each do |key,value|
        unless what[key] === quoteHash[key]
          results.delete(quoteHash)
        end
      end
    end
    return results
  end
end
