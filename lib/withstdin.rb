require "tempfile"

# entry point
puts "ok go..."

tempfile = Tempfile.new("tempfile_with_stdin", "./")
tempfile.puts($stdin.read)
tempfile.close
tempfile.open.each_line.with_index do |line, idx|
    puts "#{idx}: #{line}"
end
tempfile.close(true)
