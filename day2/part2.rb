reports = []

File.open("input.txt", "r") do |f|
  f.each_line.with_index do |line,idx|
    report = line.split("\s")

    reports[idx] = report.map { |x| x.to_i }
  end
end

def check_report(report)
  decreased = 0
  increased = 0
  bad_diff = false

  for i in 0..(report.count - 2) do
    diff = report[i] - report[i + 1]

    decreased += 1 if diff > 0
    increased += 1 if diff < 0
    bad_diff = true if diff.abs < 1 || diff.abs > 3
  end

  return 0 if decreased > 0 && increased > 0 || bad_diff

  1
end

def run_dampener(report)
  report.each_with_index do |num, index|
    report.delete_at(index)
    return true if check_report(report) == 1
    report.insert(index, num)
  end

  false
end

output = reports.map {|report|

  check_report(report) == 1 ? true : run_dampener(report)
  
}


puts output.tally