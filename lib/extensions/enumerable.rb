module Enumerable

  def mean
    sum / length.to_f
  end

  def variance
    return 0 if length == 0
    avg = mean
    sum = inject(0) { |acc,i| acc + (i - avg)**2 }
    (1 / length.to_f * sum)
  end

  def standard_deviation
    Math.sqrt(variance)
  end

  # Gives counts of items, or of items categories if the categorization is given a block
  # (1..30).histogram{ |x| x % 3 } #=> {0=>10, 1=>10, 2=>10}
  def histogram(&to_category_block)
    hist = Hash.new(0)
    each{ |i| hist[block_given? ? yield(i) : i] += 1 }
    hist
  end
end
