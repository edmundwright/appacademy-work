require_relative 'piece'
require 'byebug'

class Board
  SIZE = 8
  STARTING_POSITIONS = {:black => [[0, 1], [0, 3], [0, 5], [0, 7],
                                   [1, 0], [1, 2], [1, 4], [1, 6],
                                   [2, 1], [2, 3], [2, 5], [2, 7]],
                        :white => [[5, 0], [5, 2], [5, 4], [5, 6],
                                   [6, 1], [6, 3], [6, 5], [6, 7],
                                   [ 7, 0], [7, 2], [7, 4], [7, 6]]}

  def initialize(skip_setup = false)
    @grid = Array.new(SIZE) { Array.new(SIZE) }
    setup unless skip_setup
  end

  def [](pos)
    raise BoardError.new("Position is not on board!") unless on_board?(pos)
    row, col = pos
    grid[row][col]
  end

  def []=(pos, value)
    raise BoardError.new("Position is not on board!") unless on_board?(pos)
    row, col = pos
    grid[row][col] = value
  end

  def remove_piece(pos)
    raise BoardError.new("No piece at that position!") unless piece?(pos)
    self[pos] = nil
  end
  
  def move(moves)
    raise BoardError.new("No piece at that position!") unless piece?(moves.first)
    self[moves.first].perform_moves(moves.drop(1))
  end

  def dup
    dup_board = self.class.new(true)
    pieces.each { |piece| dup_board[piece.pos] = piece.dup(dup_board) }
    dup_board
  end

  def num_moves_for_color(color)
    pieces_of_color(color).inject(0) do |acc, piece|
      acc + piece.num_available_moves
    end
  end

  def pieces_of_color(color)
    pieces.select { |piece| piece.color == color }
  end

  def on_board?(pos)
    pos.all? { |coord| coord.between?(0, SIZE - 1) }
  end

  def empty_square?(pos)
    on_board?(pos) && self[pos].nil?
  end

  def piece?(pos)
    on_board?(pos) && !self[pos].nil?
  end

  def color(pos)
    self[pos].color
  end

  def render
    puts
    puts "   #{("A".."Z").to_a.take(SIZE).join("  ")}"

    rows.each_with_index do |row, index|
      mapped_row = row.map do |square|
        square.nil? ? "[ ]" : "[#{square}]"
      end
      puts "#{index} #{mapped_row.join("")}"
    end
    puts
  end

  private

  attr_accessor :grid

  def setup
     [:black, :white].each do |color|
       STARTING_POSITIONS[color].each do |pos|
         self[pos] = Piece.new(self, pos, color)
       end
     end
  end

  def pieces
    grid.flatten.compact
  end

  def rows
    grid
  end
end
