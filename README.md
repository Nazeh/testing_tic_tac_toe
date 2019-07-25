# testing_tic_tac_toe
Testing Tic Tac Toe terminal game (https://github.com/tundeiness/Tic-Tic-Toe)

Tic Tac Toe terminal game implementation using Ruby.

Tic-tac-toe or Xs and Os is a game for two players, X and O,
who take turns marking the spaces in a 3×3 grid.<br/>
The player who succeeds in placing three of their marks
in a horizontal, vertical, or diagonal row wins the game.

## Installation

#### Prerequisites

Ruby 2.5.0+
RSpec 3.0+

#### Run
Run game:
```console
ruby bin/main.rb
```
Run tests:
```console
rspec
```

## Live version

Play it on [Repl.it](https://repl.it/@Nazeh1/Tic-Tac-Toe) <br/>
*Slower and doesn't support console clearing.

## How to Play

Board is divided into a grid of 9 cells numbered in a similar
manner to Numpads for convenience!

- Player 1 chooses a mark: X or O, Player 2 gets the other mark.
- Players choose the number of the cell to mark in their turns.
- The first player to mark a row, column or diagonal wins.
- If the grid is full with no winning conditions the game ends with a draw!
- You can play another match in which case the game will count your score.
- Otherwise, the game will end and the code will terminate. 

Only X/O would be accepted as a mark.<br/>
Only unmarked numbers on the board would be accepted as cell numbers.<br/>
Ond only Y/N would be accepted for other options.<br/>
Inputs can be lower or upper case.

## Authors

* [Ar Nazeh](https://github.com/Nazeh)
* [Tunde Oretade](https://github.com/tundeiness)
