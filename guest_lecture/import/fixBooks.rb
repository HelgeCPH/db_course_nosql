#!/usr/bin/env ruby

$prev=[]
ARGF.each do |line|
  if(line=~/^pg_id/)
    puts line
    next
  end
  if(line=~/^\d+\,/)
    puts $prev.join(" ") if($prev.length > 0)
    $prev=[]
  end
  $prev << line.chomp
end

puts $prev.join(" ") if($prev.length > 0)
