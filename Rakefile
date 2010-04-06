# encoding: utf-8
require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "howdy"
    gem.summary = %Q{Query web dictionaries from command line}
    gem.description = %Q{Howdy is a tool that allows querying web dictionaries from a command line.}
    gem.email = "michal.lomnicki@gmail.com"
    gem.homepage = "http://github.com/mlomnicki/howdy"
    gem.authors = ["Michał Łomnicki"]
    gem.add_dependency "nokogiri"
    gem.add_development_dependency "rspec"
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: sudo gem install jeweler"
end

require 'spec/rake/spectask'
Spec::Rake::SpecTask.new(:spec) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.spec_files = FileList['spec/**/*_spec.rb']
end

Spec::Rake::SpecTask.new(:rcov) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rcov = true
end

task :spec => :check_dependencies

task :default => :spec

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  if File.exist?('VERSION')
    version = File.read('VERSION')
  else
    version = ""
  end

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "howdy #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/*/*.rb', 'lib/core/**/*.rb')
  rdoc.options << "-c UTF-8"
end

namespace :rdoc do
  desc 'Upload documntation'
  task :upload => :rerdoc do 
    require 'net/scp'
    Net::SSH.start('autonom', 'myst') do |ssh|
      ssh.exec!('rm -rf _apps/howdy')
    end
    Net::SCP.upload!('autonom', 'myst', 'rdoc', '_apps/howdy', :recursive => true)
  end
end

