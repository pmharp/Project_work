# enable RubyInstaller DevKit usage as a vendorable helper library
unless ENV['PATH'].include?('C:\\opscode\\chef-workstation\\embedded\\mingw\\bin') then
  phrase = 'Temporarily enhancing PATH to include DevKit...'
  if defined?(Gem)
    Gem.ui.say(phrase) if Gem.configuration.verbose
  else
    puts phrase
  end
  puts "Prepending ENV['PATH'] to include DevKit..." if $DEBUG
  ENV['PATH'] = 'C:\\opscode\\chef-workstation\\embedded\\bin;C:\\opscode\\chef-workstation\\embedded\\mingw\\bin;' + ENV['PATH']
end
ENV['RI_DEVKIT'] = 'C:\\opscode\\chef-workstation\\embedded'
ENV['CC'] = 'gcc'
ENV['CXX'] = 'g++'
ENV['CPP'] = 'cpp'
