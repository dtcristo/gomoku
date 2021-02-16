require 'gosu'
require 'gomoku/version'

module Gomoku
  autoload :Board,    'gomoku/board'
  autoload :Computer, 'gomoku/computer'
  autoload :Human,    'gomoku/human'
  autoload :Player,   'gomoku/player'
  autoload :Utility,  'gomoku/utility'
  autoload :Window,   'gomoku/window'
end
