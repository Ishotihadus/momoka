# frozen_string_literal: true

require 'base64'
require 'dotenv'
require 'openssl'
require_relative 'momoka/dotenv_inject'
require_relative 'momoka/version'

module Momoka
  class << self
    def load(*filenames, key_file: nil)
      env = Dotenv.parse(*filenames)
      decrypt!(env, key_file: key_file)
      env.each {|k, v| ENV[k] ||= v}
    end

    def load!(*filenames, key_file: nil)
      env = Dotenv.parse!(*filenames)
      decrypt!(env, key_file: key_file)
      env.each {|k, v| ENV[k] ||= v}
    end

    def overload(*filenames, key_file: nil)
      env = Dotenv.parse(*filenames)
      decrypt!(env, key_file: key_file)
      env.each {|k, v| ENV[k] = v}
    end

    def overload!(*filenames, key_file: nil)
      env = Dotenv.parse!(*filenames)
      decrypt!(env, key_file: key_file)
      env.each {|k, v| ENV[k] = v}
    end

    def encrypt(text, key_file: nil)
      key = default_key(key_file: key_file)

      enc = OpenSSL::Cipher.new('AES-256-CBC').encrypt
      enc.key = key.byteslice(0, 32)
      enc.iv = key.byteslice(32, 16)

      encrypted = Base64.strict_encode64(enc.update(text) + enc.final)
      ":momoka:#{encrypted}:"
    end

    private

    def default_key(key_file: nil)
      key =
        if key_file
          File.read(key_file)
        elsif ENV.key?('MOMOKA_KEY')
          ENV['MOMOKA_KEY']
        else
          raise 'Neither .momoka file nor MOMOKA_KEY environment variable exists' unless File.exist?('./.momoka')

          File.read('./.momoka')
        end

      key = Base64.decode64(key)
      raise 'invalid key' unless key.bytesize >= 48

      key
    end

    def decrypt!(env, key_file: nil)
      dec = nil

      env.transform_values! do |v|
        next v unless v.size >= 10 && v[0, 8] == ':momoka:' && v[-1] == ':'

        unless dec
          key = default_key(key_file: key_file)

          dec = OpenSSL::Cipher.new('AES-256-CBC').decrypt
          dec.key = key.byteslice(0, 32)
          dec.iv = key.byteslice(32, 16)
        end

        _empty, _momoka, data = v.split(':')
        data = Base64.decode64(data)
        dec.reset
        dec.update(data) + dec.final
      end
    end
  end
end
