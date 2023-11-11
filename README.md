# Ruby Battleship 

- Classic battleship game implemented in ruby with STDIO player interaction.
- By default, 7 ships of sizes 1, 1, 2, 2, 3, 4, 5 respectively, will be randomly placed within a 10x10 board.
- You will be given 50 shoots and must fire at their coordinates by inputing the x and y values each turn.
- If after using all your shoots you don't sink all the ships, you lose.

# Play 

> ruby battleship.rb

# Args 

> ruby battleship.rb [boardSize]: int [numberOfShoots]: int [enableDebug]: bool

# Log 

- A file called game.log will keep record of each turn in your games.
- When debug is enabled, the initial position of the ships will be recorded as well.

# battleship.rb

- Entrypoint of the application
- Captures the command line arguments
- Creates a new Game instance, set it up and plays it

# game_log.rb

- Abstract the ruby logger with a print function that change terminal colors and clears it

# errors.rb 

- Extends the default IO error with a message to the user when inputing invalid coordinates format

# cell.rb 

- The abstraction of each one of the board cells
- Keeps record of its coordinates and status (has a ship, is hidden, was fired, was missed)
- Implements specific to_s and printing methods to be displayed on terminal

# ship.rb

- Each one of the ships to be added to the board
- Contains an array of cells with the ship size length
- Keeps record of the ship damage, orientation, size, if its sank or not and whether it can be hitted or not

# board.rb

- The game board abstraction with the random placement logic
- Fills itself at the begining 
- Implements a specific to_s method to be displayed on terminal

# game.rb

- The Game mechanism responsible for user interaction
- Runs the game loop to controll the turns, number of shoots and logging
- Implements input validation and win/lose conditions functionalities

