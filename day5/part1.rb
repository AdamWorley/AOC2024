lines = File.readlines("input.txt")

split_index = lines.find_index("\n")

order = lines[0..split_index-1].map { |x| 
  x.split("|").map{|n| 
    n.to_i
  } 
}.group_by { |num| 
  num.shift 
}.transform_values { |values|
  values.flatten
}.sort.to_h


pages = lines[split_index+1..].map { |x| 
  x.split(",").map{|n| 
    n.to_i
  } 
}

filtered = pages.map{|p| 
  result = order.map{|k,v| 
    key_index = p.find_index(k).to_i

    v.map{|x| 
    page_index = p.find_index(x)

    ok = key_index <= (page_index.nil? ? 100 : page_index)
    ok
  }
  }.flatten

  [result.all?{|e| e}, p[p.size/2]]

}.select(&:first)

p filtered.sum(&:last)
