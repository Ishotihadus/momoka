# frozen_string_literal: true

require 'dotenv'

module Dotenv
  def self.parse!(*filenames)
    with(*filenames) do |f|
      Environment.new(f, false)
    end
  end
end
