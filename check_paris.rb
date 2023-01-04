require 'optparse'
require 'watir'

options = {}
option_parser = OptionParser.new do |parser|
  parser.banner = "Usage: #{$0} -i <IDENTIFIER> -p <PASSWORD> [options]"

  parser.on("-i", "--identifier IDENTIFIER", "[MANDATORY] Login Identifier (impots.gouv)") do |i|
    options[:identifier] = i
  end

  parser.on("-p", "--password PASSWORD", "[MANDATORY] Login password (impots.gouv)") do |p|
    options[:password] = p
  end

  parser.on("-h", "--headless", "Run in headless mode") do |h|
    options[:headless] = h
  end
end

option_parser.parse!

# The options hash will now contain the values passed on the command line
if [:identifier, :password].any? { |key| options[key].nil? }
  puts option_parser.help
  exit 1
end

begin
  browser = Watir::Browser.new :chrome, headless: options[:headless]

  browser.goto 'https://teleservices.paris.fr/rdvtitres/jsp/site/Portal.jsp?page=appointmenttitresearch'

  browser.text_field(name: 'nb_consecutive_slots').set '1'
  browser.text_field(name: 'zip_code').set '75008'

  browser.button(name: 'action_presearch').click

  browser.img(title: "S'identifier avec FranceConnect").click

  browser.button(id: 'fi-dgfip').click

  browser.text_field(name: 'spi_tmp').set options[:identifier]

  browser.button(id: 'btnAction').click

  browser.text_field(name: 'pwd_tmp').set options[:password]

  browser.button(id: 'btnAction').click

  browser.button(type: 'submit').click

  if browser.text.include? "Aucun rendez-vous n'est actuellement disponible"
    puts 'No appointment available'
  else
    puts 'Appointment available'
  end
ensure
  browser.close
end