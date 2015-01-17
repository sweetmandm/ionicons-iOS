require 'nokogiri'
require 'open-uri'

cheatsheet_url = 'https://github.com/driftyco/ionicons/raw/master/cheatsheet.html'
font_url = 'https://github.com/driftyco/ionicons/raw/master/fonts/ionicons.ttf'


task :default => [:update]

desc "Updates the ionicons-codes.h file with the latest codes"
task :updateCodes do
	doc = Nokogiri::HTML(open(cheatsheet_url))
  
  version =  doc.css('title')[0].text.gsub(/ Cheatsheet/, "")
  updateReadme(version)
  updatePodspec(version)

  # update the icon codes
	codes_file = File.open('ionicons/ionicons-codes.h', 'w')

	doc.css('div.icon-row').each do |icon_row|
		icon_name = icon_row.css('div.preview-icon span.size-12 i')[0]["class"][5..-1].gsub('-', '_')
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

def updateReadme(version)
  text = File.read('README.md')
  new_contents = text.gsub( /^Currently using.*$/, "Currently using: #{version}")
  readme_file = File.open('ionicons/README.md', 'w') { |file| file.puts new_contents }
end

def updatePodspec(version)
  version = version.delete('^0-9\.')
  text = File.read('IonIcons.podspec')
  text = text.gsub( /s.version      = \".*\"/, "s.version      = \"#{version}\"")
  text = text.gsub(/:tag =>.*\"/, ":tag => \"#{version}\"")
  podspec_file = File.open('IonIcons.podspec', 'w') { |file| file.puts text }
end

desc "Updates to the latest ionicons font file and updates the ionicons-codes.h with the latest codes"
task :update do
	Rake::Task[:updateCodes].execute
	Rake::Task[:updateFont].execute
end
