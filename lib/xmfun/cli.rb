# -*- encoding : utf-8 -*-

require 'clap'

module Xmfun
  class CLI
    def self.start(argv)
      argv_check(argv)

      begin
        Clap.run argv, tasks
      rescue ArgumentError
        puts "\e[31mInvalid Usage\e[0m"
        puts help
      end

      go!
    end

    private

    def self.load_task_manager
      Xmfun::Util::TaskManager.instance
    end

    def self.task_manager
      @task_manager ||= load_task_manager
    end

    def self.argv_check(argv)
      if argv.empty?
        puts help
        exit
      end
    end

    def self.method_missing(name, *args, &block)
      task_manager.send(name, *args, &block)
    end
  end
end
