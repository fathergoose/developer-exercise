class Array

  def where(filters)
    results = self.dup
    self.each do |item|
      filters.each do |key,value|
        results.delete(item) unless filters[key] === item[key]
      end
    end
    results
  end

end

# I just realized that I don't believe
# this solution returns the orignal
# hashes, but rather copies of those objects.
# If that is the case, I would love to see
# how one can make a true non-destructive
# filter. I figure we want to leave
# the orignal Array intacat.
