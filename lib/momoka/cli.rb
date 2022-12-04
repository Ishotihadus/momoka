# frozen_string_literal: true

require 'momoka'
require 'dotenv/cli'

module Momoka
  class CLI < Dotenv::CLI
    def run
      if @overload
        Momoka.overload!(*@filenames)
      else
        Momoka.load!(*@filenames)
      end
    rescue Errno::ENOENT => e
      abort e.message
    else
      exec(*@argv) unless @argv.empty?
    end
  end
end
