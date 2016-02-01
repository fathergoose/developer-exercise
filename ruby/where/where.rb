class Array

  def where(filters)
    results = self.dup
    self.each do |item|
      filters.each do |key,value|
        results.delete(item) unless filters[key] === quoteHash[key]
      end
    end
    results
  end

end
