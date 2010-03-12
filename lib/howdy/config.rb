require 'fileutils'

module Howdy

  # Howdy configuration. 
  # Configuration file points to $HOME/.howdy by default
	class Config < Hash

		attr_reader :file

    # Path of default configuration file
    # It's copied to user directory if config file doesn't exist.
		TEMPLATE_PATH = File.join(File.dirname(__FILE__), 'templates', 'howdy')

		def	initialize(file = self.class.config_path)
			@file = file
		end

    # Parse file and associate options to self
    #   example:
    #     howdy.conf:
    #       default_dictionary = dictionary.com
    #       verbose = true
    #
    #     c = Config.new('howdy.conf')
    #     c.parse
    #     c.inspect
    #       { :default_dictionary => 'dictionary.com', :verbose => 'true' }
		def	parse
			readlines.each do |line|
				next if line =~ /\s*#/
				key, value = line.split('=', 2).map! { |arg| arg.strip }
        self[key.to_sym] = value
			end
      self
		end

    # path of configuration file
    #   example: /home/stella/.howdy
    def	self.config_path
      @config_path ||= File.join(root_config_path, config_filename) 
    end

    # root directory of config file
    #   example: /home/stella
    def	self.root_config_path
      @root_config_path ||= (ENV['HOME'] || '') 
    end

    # filename of configuration file
    #   example: .howdy
    def	self.config_filename
      @config_filename ||= ".howdy".freeze
    end

    protected
		def	readlines
			config = File.readable?(@file) ? @file : self.class.create_config!
			return File.readlines(config)
		end

		def self.create_config!
			FileUtils.cp(TEMPLATE_PATH, config_path)
			return config_path
		end

	end

end
