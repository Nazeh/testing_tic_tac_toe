# frozen_string_literal: true

# class player saves, modifies, and read @name, @mark, @color, and increment @score.
class Player
  attr_reader :name
  attr_reader :mark
  attr_reader :color
  attr_reader :score

  def initialize(name)
    @name  = name
    @score = 0
  end

  def add_mark(mark)
    return false unless %w[X O].include?(mark)

    @mark = mark
    @color = @mark == 'X' ? '31' : '32' # red : green
  end

  def add_score
    @score += 1
  end
end
