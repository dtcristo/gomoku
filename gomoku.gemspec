lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'gomoku/version'

Gem::Specification.new do |spec|
  spec.name         = 'gomoku'
  spec.version      = Gomoku::VERSION
  spec.authors      = ['David Cristofaro']
  spec.summary      = 'Classic five-in-a-row board game'
  spec.homepage     = 'https://github.com/dtcristo/gomoku'
  spec.license      = 'MIT'

  spec.files        = Dir['{lib}/**/*.rb', 'bin/gomoku', 'assets/*.png',
                          'LICENSE', '*.md']
  spec.executables  = ['gomoku']
  spec.require_path = 'lib'

  spec.add_runtime_dependency 'gosu', '~> 0.9.2'

  spec.add_development_dependency 'bundler', '~> 1.10'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'minitest'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'codeclimate-test-reporter'

  spec.required_ruby_version = '~> 2'
end
