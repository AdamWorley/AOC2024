lines = File.readlines("example.txt")

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

wrong = pages.map{|p| 
  result = order.map{|k,v| 
    key_index = p.find_index(k).to_i

    v.map{|x| 
    page_index = p.find_index(x)

    ok = key_index <= (page_index.nil? ? 100 : page_index)
    ok
  }
  }.flatten

  [result.all?{|e| e}, p]

}.select{|i| i[0] == false}

corrected = wrong.map{|w|
  ps = w[1]
  swapped = true

  while swapped 
    swapped = false
    i = 0

    while i <= ps.size
      cur = ps[i]
      remaining = ps[i..]

      o = order[cur] || []
      w = remaining.find{|r|o.include?(r)}
      indx = ps.find_index(w)

      if(indx)
        ps[i] = ps[indx]
        ps[indx] = cur
        swapped = true
      end

      i += 1
    end
  end

  ps
}

result = corrected.map{|p| p[p.size/2]}.sum

p result