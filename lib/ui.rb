# frozen_string_literal: true

require_relative '../lib/board'
require_relative '../lib/player'

# Ui module contains a collection of methods for displaying state of the game and prompt messages.
module Ui
  class << self
    def prompt_name(player_number)
      display_template(Player.new('Player 1'), Player.new('Player 2'), Board.new)
      puts "\n#{player_number}: what's your name?  default: #{player_number}"
      answer = gets.chomp[0...8]
      answer.empty? ? player_number : answer
    end

    def prompt_first_player(player1, player2)
      message = "Who plays first 1:#{player1.name}, or 2:#{player2.name}? (1/2)"
      error_message = "#{color('Invalid!', 31)} please choose between (1/2)"

      answer = prompt(player1, player2, Board.new, message)
      answer = prompt(player1, player2, Board.new, error_message) until ['1', '2', ''].include?(answer)
      answer.to_i
    end

    def prompt_cell(game)
      message = "#{color(game.current_player.name.to_s, game.current_player.color)}'s turn! choose a cell to mark!"
      answer = prompt(game.player1, game.player2, game.board, message).to_i
      check_cell_valid?(answer, game)
    end

    def play_again?(game)
      game_status = game_end(game)
      message = "#{game_status} \nWould you like to play again? (y/n)"
      error_message = "#{game_status} \n#{color('Invalid!', 31)} please choose (y/n)"

      answer = prompt(game.player1, game.player2, game.board, message)
      answer = prompt(game.player1, game.player2, game.board, error_message) until ['y', 'n', ''].include?(answer)
      answer != 'n'
    end

    def thanks
      display_template(Player.new('Player 1'), Player.new('Player 2'), Board.new)
      puts "\n" + Line +
           ' Thanks for playing Tic Tac Toe '.center(50, '*') + "\n" + Line +
           " Authors' Github: Nazeh  / tundeiness ".center(50, '*') + "\n" + Line
    end

    private

    Line = '*' * 50 + "\n"

    def check_cell_valid?(answer, game)
      error_message = "#{color('Invalid!', 31)} please choose unmarked cell between [1..9]"

      until (1..9).to_a.include?(answer) && game.board.cell_available?(answer)
        answer = prompt(game.player1, game.player2, game.board, error_message).to_i
      end
      answer
    end

    def prompt(player1, player2, board, message)
      display_template(player1, player2, board)
      puts "\n" + message
      gets.chomp.downcase
    end

    def display_template(player1, player2, board)
      puts `clear`
      puts Line +
           ' Welcome To Our Tic-Tac-Toe Game! '.center(50, '*') +
           "\n" + Line +
           ' Instructions '.center(50, '*') +
           "\n** Each player should use an 8 characters name ***" \
           "\n** Choose who will play first, using the X mark **" \
           "\n** Each turn a player will choose a cell to mark *" \
           "\n** Who marks a full row, col or a diagonal wins **" \
           "\n** Players draw, if all cells are marked w/ win **" \
           "\n** You can play again & players' score persist ***" \
           "\n" + Line
      display_board(board)
      display_score(player1, player2)
    end

    def display_board(board = Board.new)
      puts '****************                 *****************'
      board.board.reverse.each_with_index do |row, i|
        puts "    #{colorize(row[0])} | #{colorize(row[1])} | #{colorize(row[2])}    ".center(77, '*')
        puts '****************   ---+---+---   *****************' unless i == 2
      end
      puts '****************                 *****************'
    end

    def colorize(cell)
      cell_collor = cell == 'X' ? 31 : 32
      color(cell, %w[X O].include?(cell) ? cell_collor : 11)
    end

    def color(text, color)
      "\e[#{color.nil? ? 11 : color}m#{text}\e[0m"
    end

    def display_score(player1, player2)
      puts '********************* Score  *********************'
      puts " #{color(player1.name, player1.color)} : #{player1.score} " \
          " #{color(player2.name, player2.color)} : #{player2.score} ".center(68, '*') + "\n" + Line
    end

    def game_end(game)
      if game.status == 'draw'
        Line + "  It's a DRAW  ".center(50, '*') + "\n" + Line
      else
        Line + "  #{color(game.current_player.name, game.current_player.color)} WINS  ".center(59, '*') + "\n" + Line
      end
    end
  end
end
