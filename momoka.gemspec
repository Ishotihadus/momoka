# frozen_string_literal: true

require_relative 'lib/momoka/version'

Gem::Specification.new do |spec|
  spec.name = 'momoka'
  spec.version = Momoka::VERSION
  spec.authors = ['Ishotihadus']
  spec.email = ['hanachan.pao@gmail.com']

  spec.summary = 'Dotenv encryptor with AES-256-CBC'
  spec.description = 'Dotenv encryptor with AES-256-CBC'
  spec.homepage = 'https://github.com/Ishotihadus/momoka'
  spec.required_ruby_version = '>= 2.6.0'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage

  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{\Aexe/}) {|f| File.basename(f)}
  spec.require_paths = ['lib']

  spec.add_dependency 'dotenv'
  spec.add_dependency 'openssl'
end
