class Array
  def where(what)
    results = []
    self.each do |quoteHash|
      matches = []
      what.each do |key,value|
        if what[key] === quoteHash[key]
          matches << quoteHash
        end
        # push matches into results if matches.length.eq?(what.length)
      end
    end
    return results
  end
end
