reports = []

File.open("input.txt", "r") do |f|
  f.each_line.with_index do |line,idx|
    report = line.split("\s")

    reports[idx] = report.map { |x| x.to_i }
  end
end

def check_report(report)
  report.each_cons(3).all? do |n1, n2, n3|
    # Check if the triplet is strictly increasing or decreasing
    if (n1 > n2 && n2 > n3) || (n1 < n2 && n2 < n3)
      diff1 = (n2 - n1).abs
      if diff1 > 0 && diff1 <= 3
        puts "safe1 #{diff1}"
        diff2 = (n3 - n2).abs
        if diff2 > 0 && diff2 <= 3
          puts "safe2 #{diff2}"
          true
        else
          puts "2nd two values too big #{diff2}"
          false
        end
      else
        puts "1st two values too big #{diff1}"
        false
      end
    else
      puts "#{(n1 > n2 && n2 > n3)} || #{(n1 < n2 && n2 < n3)}"
      puts "values don't all increase/decrease #{n1}, #{n2}, #{n3}"
      false
    end
  end
end

output = reports.map { |r| 
  o = check_report(r)
  puts "#{r} - #{o}"
  o
}

tally = output.tally

puts tally
