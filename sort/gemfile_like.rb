# This is an idea of what 'bundle install' does
begin
  # try to load gem
  gem 'colorize'
#uh-oh!!! ERROR CATCHING, NO GEM FOUND!
rescue LoadError
  puts 'colorize gem is missing.  Let me install that gem for you.....'
  #installs gem through your console
  system('gem install colorize')
  Gem.clear_paths
end