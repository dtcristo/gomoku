lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'gomoku/version'

Gem::Specification.new do |s|
  s.name         = 'gomoku'
  s.version      = Gomoku::VERSION
  s.authors      = ['David Cristofaro']

  s.summary      = 'Classic five-in-a-row board game'
  s.homepage     = 'https://github.com/dtcristo/gomoku'
  s.license      = 'MIT'

  s.files        = Dir['{lib}/**/*.rb', 'bin/gomoku', 'assets/*.png', 'LICENSE', '*.md']
  s.executables  = ['gomoku']
  s.require_path = 'lib'

  s.add_runtime_dependency 'gosu', '~> 0.9.2'

  s.add_development_dependency 'bundler', '~> 1.10'
  s.add_development_dependency 'rake', '~> 10.0'
  s.add_development_dependency 'minitest'
  s.add_development_dependency 'pry'
  s.add_development_dependency 'codeclimate-test-reporter'
end
