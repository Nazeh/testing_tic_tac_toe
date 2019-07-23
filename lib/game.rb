# frozen_string_literal: true

require_relative '../lib/board.rb'
require_relative '../lib/player.rb'
require_relative '../lib/ui.rb'

# class Game Initiate a new board (using Board class) and status,
# plays one match, and update the UI (using Ui module) and change
# the player score in the mean time.
class Game
  attr_reader :status

  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
  end

  def new_match
    @status = 'continue'
    @moves = 0
    @board = Board.new
    @cur_player = @player1
    assign_players_marks
  end

  def play
    @cur_player = ([@player1, @player2] - [@cur_player]).first
    @status = update_status(@board.get_row_col_diagonals(prompt_cell), @cur_player.mark)
  end

  def play_again?
    @cur_player.add_score if @status == 'win'

    answer = nil
    until %w[y n].include?(answer)
      winlose = @status == 'win' ? display_wins(@cur_player.name) : display_draw
      answer = prompt(game_over + winlose + prompt_play_again)
    end
    answer == 'y'
  end

  private

  def prompt(message)
    puts message
    gets.chomp.downcase.to_s
  end

  def assign_players_marks
    user_input = nil
    loop do
      user_input = prompt("\nPlayer 1, Please choose a mark? (X/O)").upcase
      break if %w[X O].include?(user_input)
    end
    @player1.add_mark(user_input)
    @player2.add_mark(@player1.mark == 'X' ? 'O' : 'X')
  end

  def prompt_cell
    cell = nil
    while cell.nil?
      answer = prompt("\n#{@cur_player.name} cur_player\nWhere would you like to put your mark?").to_i
      cell = answer if @board.update(answer, @cur_player.mark) || (1..9).to_a.include?(answer)
    end
    cell
  end

  def update_status(row_col_diagonals, mark)
    @rounds += 1
    @status = 'draw' if @rounds >= 9
    @status = 'win' if row_col_diagonals.any? { |element| element.count(mark) == 3 }
    @status
  end
end
