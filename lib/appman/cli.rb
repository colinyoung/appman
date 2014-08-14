require 'optparse'

module Appman
  class CLI

    TEXT_PATH = File.dirname(__FILE__) + '/text'

    def initialize(argv=ARGV)
      @options = OptionParser.new do |opts|
        opts.banner = "Usage: appman [command] [options]"
      end

      @options.parse!

      puts @options.banner if argv.empty?

      command = argv[0]

      begin
        send(command)
      rescue NoMethodError
        print "No such command - try another."
        print @options.banner
        print "\r\n"
        print help
      end
    end

    def print(line)
      $stdout.puts(line)
    end

    def method_missing(method)
      begin
        print File.open("#{TEXT_PATH}/#{method}", 'r').read
      rescue Errno::ENOENT
        raise NoMethodError
      end
    end
  end
end