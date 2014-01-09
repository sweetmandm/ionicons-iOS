require 'nokogiri'
require 'open-uri'

cheatsheet_url = 'https://github.com/driftyco/ionicons/raw/master/cheatsheet.html'
font_url = 'https://github.com/driftyco/ionicons/raw/master/fonts/ionicons.ttf'


task :default => [:update]

desc "Updates the ionicons-codes.h file with the latest codes"
task :updateCodes do
	doc = Nokogiri::HTML(open(cheatsheet_url))

	codes_file = File.open('ionicons/ionicons-codes.h', 'w')

	doc.css('div.icon-row').each do |icon_row|
		icon_name = 'icon' << icon_row.css('div.preview-icon span.size-12 i')[0]["class"][8..-1].gsub('-', '_')
		icon_code = icon_row.css('div.usage input.css')[0]['value'].gsub('\\', '')
		definition = "#define #{icon_name} @\"\\u#{icon_code}\""

		codes_file.puts(definition)
	end

	codes_file.close()
end

desc "Updates to the lastest ionicons font file"
task :updateFont do
	File.open('ionicons/ionicons.ttf', 'wb') do |file|
  		file.write open(font_url).read
	end
end

desc "Updates to the latest ionicons font file and updates the ionicons-codes.h with the latest codes"
task :update do
	Rake::Task[:updateCodes].execute
	Rake::Task[:updateFont].execute
end