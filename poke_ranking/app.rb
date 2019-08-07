require 'bundler'
Bundler.require
require 'json'

file = File.read('poke_ranking/data.html')
result = []

756.times do |i|
  parse = Oga.parse_html(file)
  img = parse.xpath(%{//*[@id="button#{i}"]/img}).attribute("src")[0].value
  id = img.match(%r{images\/(\d+).*\.png})[1]
  result << {
    rank: i + 1,
    id: id
  }
end

File.open("poke_ranking.json","w") do |text|
  text.puts(JSON.generate(result))
end

