module Remoppy
  class CLI < Thor
    desc 'start', 'remoppy start'
    def start
      build_command(:run).call
    end

    desc 'new [DIR_NAME]', 'create new remoppy project'
    def new(dir_name = nil)
      build_command(:generator).call(dir_name)
    end

    desc 'version', 'show version number'
    def version
      puts Remoppy::VERSION
    end

    private

    def build_command(command_name)
      "Remoppy::Commands::#{command_name.to_s.camelize}".constantize.new
    end
  end
end
