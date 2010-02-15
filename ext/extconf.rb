# This is ridiculous but I couldn't find out a better solution...
#
# We need to install win32console gem conditionally. Obviously
# when gem is installed on windows platform. As far as I know
# there are 2 possible solution
# 1. create separated gems
# 2. install via gem extensions

# 1. sucks obviously.
# 2. is better but I was suprised that gem extension raises an exception
# if not makefile is created. So create_makefile is here only to satifsy
# rubygems. 

require 'mkmf'
require 'rbconfig'

if RUBY_PLATFORM =~ /(win|w)32$/
  require 'rubygems'
  require 'rubygems/dependency_installer.rb'

  installer = Gem::DependencyInstaller.new
  begin
    installer.install "win32console"
  rescue Exception => exc
    $stderr.puts exc.message
  end
end
create_makefile 'howdy'
