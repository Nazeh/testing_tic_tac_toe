# frozen_string_literal: true

# class player stores player name, chosen mark, color and score
class Player
  attr_reader :name
  attr_reader :mark
  attr_reader :color
  attr_reader :score

  def initialize(name, score = 0)
    @name  = name
    @score = score
  end

  def add_mark(mark)
    @mark = mark
    @color = @mark == 'X' ? '31' : '32' # red : green
  end

  def add_score
    @score += 1
  end
end
