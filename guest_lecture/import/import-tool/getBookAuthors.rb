#!/usr/bin/env ruby

$books=[]
$authors={}
$book_authors=[]
$linenum=0
ARGF.each do |line|
  $linenum+=1
  begin
    next if(line=~/^pg_id/)
    fields=line.chomp.gsub(/\"[^\"]*\"/) do |match|
      match.gsub(/\,/,"_COMMA_")
    end.split(/\,/)
    pg_id=fields[0]
    title=fields[1].gsub(/_COMMA_/,",")
    author=fields[2].gsub(/_COMMA_/,",")
    language=fields[3]
    $books << [pg_id,title,language].join(",")
    $authors[author]=true
    $book_authors << [pg_id,author].join(",")
  rescue Exception => e
    puts "Error on line #{$linenum}: #{e.message}"
  end
end

File.open("books.csv","w") do |out|
  out.puts "pg_id:ID,title,language"
  $books.each{|line| out.puts line}
end

File.open("authors.csv","w") do |out|
  out.puts "author:ID"
  $authors.keys.sort.each{|author| out.puts author}
end

File.open("book_authors.csv","w") do |out|
  out.puts ":START_ID,:END_ID"
  $book_authors.each{|line| out.puts line}
end
