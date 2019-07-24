# frozen_string_literal: true

require_relative '../lib/board'

# Ui module contains a collection of methods for displaying state of the game and prompt messages.
module Ui
  module_function

  def choose_mark
    user_input = prompt('Player 1, Please choose a mark? (X/O)').upcase
    loop do
      break if %w[X O].include?(user_input)

      user_input = prompt('Please enter a valid mark! (X/O)').upcase
    end
    user_input
  end

  def play_again?
    answer = nil
    until %w[y n].include?(answer)
      winlose = @status == 'win' ? display_wins(@cur_player.name) : display_draw
      answer = prompt(game_over + winlose + prompt_play_again)
    end
    answer == 'y'
  end

  def prompt_cell(cell, _mark)
    cell = nil
    while cell.nil?
      answer = prompt("\n#{@cur_player.name} cur_player\nWhere would you like to put your mark?").to_i
      cell = answer if @board.update(answer, @cur_player.mark) || (1..9).to_a.include?(answer)
    end
    cell
  end

  def prompt(message)
    display(board)
    puts message
    gets.chomp.downcase.to_s
  end

  def display(board = Board.new)
    puts `clear`
    display_instructions
    display_board(board)
  end

  def thanks
    display_instructions
    display_board(Board.new)
    puts "\n*************************************************"
    puts 'Thanks for playing our Tic Tac Toe Implementation'
    puts "\n****** Authors' Github: Nazeh / tundeiness ******"
    puts "*************************************************\n"
  end

  def display_instructions
    puts "\n"
    puts '******** Welcome To Our Tic-Tac-Toe Game! ********'
    puts '**************************************************'
    puts '=================================================='
    puts '**************************************************'
    puts 'Two players will take turns to mark the spaces on '
    puts 'a 3x3 grid. The player who succeeds in placing 3  '
    puts 'of their marks in a horizontal, vertical, or      '
    puts 'diagonal row wins the game. When there are no     '
    puts 'more spaces left to mark, it is consider a draw.  '
    puts 'To place a mark on the grid, type the number on   '
    puts 'the space you would like to mark! As shown below. '
    puts "Good luck! \n "
  end

  def game_over
    "\n*************************************************\n"\
      "****************    GAME OVER    ****************\n"\
      '*************************************************'
  end

  def display_wins(player)
    "\n*************************************************\n"\
      "****************  #{player} Wins  ****************\n"\
      '*************************************************'
  end

  def display_draw
    "\n*************************************************\n"\
      "****************   It's a Draw!  ****************\n"\
      '*************************************************'
  end

  def prompt_play_again
    "\n\nWould you like to play another match? (Y/N)"
  end

  def display_board(board)
    board.board.reverse.each_with_index do |row, i|
      line(row)
      puts '---+---+---'.center(50) unless i == 2
    end
  end

  def line(row)
    # 73 and row.count to keep the row centered after adding the colorize() characters
    row = "#{colorize(row[0])}\e[0m | #{colorize(row[1])}\e[0m | #{colorize(row[2])}\e[0m"
    puts row.center(73 + row.count('X') + row.count('O'))
  end

  def colorize(text)
    "\e[#{if %w[X O].include?(text)
            @player1.mark == text ? @player1.color : @player2.color
          else 1
          end}m#{text}"
  end

  def color(text, color)
    "\e[#{color}m#{text}\e[0m"
  end

  def display_score
    puts "\n"
    puts ' Score '.center(50, '=')
    puts " #{@player1.name} : #{@player1.score}  #{@player2.name} : #{@player2.score} ".center(50, '=')
  end
end
