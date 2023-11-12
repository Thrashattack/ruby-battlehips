# Ruby Battleship 

- Classic battleship game implemented in ruby with STDIO player interaction.
- By default, the board size is 10 and you have 50 shoots to try to sink all ships
- The board size and number of shoots is configurable via command line args
- For a board of size 10, 7 ships will be created with sizes from 1 to 5. The formula is given by: 
    - max_ship_size = board_size / 2
    - number_of_ships = half_board_size + (half_board_size / 2)
- Each turn you will be prompted to input x,y coordinates to fire a shoot
- If a ship is hitted, the board will display its size on the hitted position
- If you sink all ships within the initial number of shoots you win

# Play 

> ruby battleship.rb

# Args 

> ruby battleship.rb [boardSize]: int [numberOfShoots]: int [enableDebug]: bool

# Log 

- A file called game.log will keep record of each turn in your games.
- When debug is enabled, the initial position of the ships will be recorded as well.

# battleship.rb

- Entrypoint of the application
- Load all classes
- Creates a new Game instance, set it up and plays it

# app/game.rb

- The central Game mechanism lifecycle
- Runs the game loop to controll the turns and number of shoots
- Implements win/lose conditions and ship creation formula
- Extends the STDIO class for printing, ask player input, and logging

# app/io/stdio.rb

- Implements several IO methods to communicate with the player and ask, parse and validate its input

# app/io/loggers/default_log.rb

- Abstract the ruby logger with a print function that change terminal colors and clears it

# app/io/errors/invalid_input_error.rb 

- Extends the default IO error with a message to the user when inputing invalid coordinates format

# app/io/parsers/cmd_parser.rb

- Parses the command line args representing board size, shoots, and debug flag, given when running ruby battleship.rb 

# core/cell.rb 

- The abstraction of each one of the board cells
- Keeps record of its coordinates and status (has a ship, is hidden)
- Implements specific to_s and printing methods to be displayed on terminal depending on its state
- Can contain a ship and trigger it's hit method when hitted

# core/ship.rb

- Each one of the ships to be added to the board
- Keeps record of the ship damage, orientation, size, if its sank or not and whether it can be hitted or not

# core/board.rb

- The game board abstraction with the random ship placement logic
- Implements auto fill and reveal methods 
- Implements a specific to_s method to be displayed on terminal such as the board header and side coordinates


