require 'bundler'
Bundler.require

(1..809).each do |i|
  num = i.to_s.rjust(3, '0')
  url = "https://www.pokemon.jp/zukan/detail/#{num}.html"
  res = Faraday.get url
  parse = Oga.parse_html(res.body)
  text = parse.xpath('//*[@id="tab1"]/p').text
  dic << {
    id: i,
    desc: text.force_encoding("UTF-8")
  }
end

File.open("pokedic.json","w") do |text|
  text.puts(JSON.generate(dic))
end