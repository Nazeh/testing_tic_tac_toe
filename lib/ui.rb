# frozen_string_literal: true

# UI module contains methods for showing the board, prompt messages and game status!
module Ui
  module_function

  def display
    puts `clear`
    display_instructions
    display_board
    display_score
  end

  def thanks
    puts "\n*************************************************"
    puts 'Thanks for playing our Tic Tac Toe Implementation'
    puts "\n****** Authors' Github: Nazeh / tundeiness ******"
    puts "*************************************************\n"
  end

  private

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

  def display_board
    @board.board.reverse.each_with_index do |row, i|
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

  def display_score
    puts "\n"
    puts ' Score '.center(50, '=')
    puts " #{@player1.name} : #{@player1.score}  #{@player2.name} : #{@player2.score} ".center(50, '=')
  end

  def prompt(message)
    display
    puts message
    gets.chomp.downcase.to_s
  end
end
