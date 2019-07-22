# frozen_string_literal: true

require_relative '../lib/board.rb'
require_relative '../lib/ui.rb'

# class Game Initiate a new board (using Board class) and status,
# plays one match, and update the UI (using Ui module) and change
# the player score in the mean time.
class Game
  include Ui

  attr_reader :status

  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
  end

  def new_match
    @player1.add_mark(nil)
    @status = 'continue'
    @rounds = 0
    @board = Board.new
    @turn = @player2
    assign_players_marks
  end

  def play
    update_turn
    update
  end

  def play_again?
    update_score
    answer = nil
    until %w[y n].include?(answer)
      winlose = @status == 'win' ? display_wins(@turn.name) : display_draw
      answer = prompt(game_over + winlose + prompt_play_again)
    end
    answer == 'y'
  end

  private

  def assign_players_marks
    while @player1.mark.nil?
      user_input = prompt("\nPlayer 1, Please choose a mark? (X/O)").upcase
      break if %w[X O].include?(user_input)
    end
    @player1.add_mark(user_input)
    @player2.add_mark(@player1.mark == 'X' ? 'O' : 'X')
  end

  def update_turn
    @turn = ([@player1, @player2] - [@turn]).first
  end

  def prompt_cell
    cell = nil
    while cell.nil?
      answer = prompt("\n#{@turn.name} turn\nWhere would you like to put your mark?").to_i
      cell = answer unless @board.update(cell, @turn.mark) || (1..9).to_a.include?(answer)
    end
    cell
  end

  def update
    @status = update_status(@board.get_row_col_diagonals(prompt_cell), @turn.mark)
  end

  def update_status(row_col_diagonals, mark)
    @rounds += 1
    @status = 'draw' if @rounds >= 9
    @status = 'win' if row_col_diagonals.any? { |element| element.count(mark) == 3 }
    @status
  end

  def update_score
    @turn.add_score if @status == 'win'
  end
end
