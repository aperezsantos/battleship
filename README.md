# Learning Goals
- Utilize Test Driven Development
- Practice Algorithmic Thinking
- Create an Object Oriented solution to a problem without being given full specifications
- Work in a pair
- Use Pull Requests to collaborate with a partner

# Overview
In this project you’ll use Ruby to build a command line implementation of the classic game Battleship. More detail can be found in the pages below:

1. Setup (https://backend.turing.io/module1/projects/battleship/setup)

REPOSITORY SETUP:
Because this is a paired project, you will want to choose one person to create the project repository and invite the other person as a collaborator using the following steps:

- Person A will create a git repository and link it to a GitHub repository.
- Person A will add Person B as a collaborator to the repository:
  + From the GitHub Repository main page, click on settings
  + In the left nav bar, click on Collaborators
  + Search for a user and click Add Collaborator
- Person B will get an email invite to join the project as a collaborator.
  + Click on the link in the email and accept the invitation.
  + Clone the repository to your local machine.

Once this setup is complete, both partners will be able to push to the GitHub repository, create Pull Requests and Merge the Pull Requests.

2. Requirements (https://backend.turing.io/module1/projects/battleship/requirements)
The specifications give you some classes to help you start breaking this problem down, but you will also have to create some additional classes and methods to build an Object Oriented solution to this problem. This means that there should be very little code outside of a class and you are using your classes to create objects that interact in some way.

Additionally, this project will require you to use Test Driven Development for the first two iterations. While it is not required, it is still suggested that you use TDD beyond iteration 2 to help drive your design.

You and your partner are expected to commit frequently and use Pull Requests. Make sure you are doing this frequently throughout the project.

Please read the Rubric before getting started so that you know what is expected of you.

  - Overview ()
    You are to build a playable game of Battleship that runs in a REPL interface. The game will allow a single human player to play against a (simplistic) computer player.

    Both the Human Player and the Computer have a 4 x 4 board that holds their ships. Each of them has 2 ships: The Cruiser which is 3 cells long and The Submarine which is 2 cells. A board will look like this:

      1 2 3 4
    A S S S .
    B . . . .
    C . S . .
    D . S . .

    Each S represents part of a ship and each . represents an empty space. In this case, the Cruiser is held in cells A1, A2, and A3, and the Submarine is held in cells C2 and D2.

    During the main phase of the game, the computer and the player take turns firing at each other’s ships. The board shown above might look like this after a couple rounds of firing:

      1 2 3 4
    A H S S .
    B M . . M
    C . X . .
    D . X . .

    Where H represents a hit, M represents a shot that missed, and X represents a sunken ship.

    The Game is over when either the User or Computer sinks both enemy ships

  # ITERATION 1
  Test Driven Development:
  In this iteration, you are required to use TDD to create your classes. Use the interaction pattern to determine what a method should do and write one or more tests to verify that expected behavior. Then you can implement the method. You should always write code with the purpose of making a test pass.

  Ship:
  A Ship object will represent a single ship on the board. It will be able to keep track of how much health it has, take hits, and report if it is sunk or not. A ship should start off with health equal to it’s length.

  The Ship class should follow this interaction pattern:

    <!-- pry(main)> require './lib/ship'
    #=> true

    pry(main)> cruiser = Ship.new("Cruiser", 3)
    #=> #<Ship:0x00007feb05112d10...>

    pry(main)> cruiser.name
    #=> "Cruiser"

    pry(main)> cruiser.length
    #=> 3

    pry(main)> cruiser.health
    #=> 3

    pry(main)> cruiser.sunk?
    #=> false

    pry(main)> cruiser.hit

    pry(main)> cruiser.health
    #=> 2

    pry(main)> cruiser.hit

    pry(main)> cruiser.health
    #=> 1

    pry(main)> cruiser.sunk?
    #=> false

    pry(main)> cruiser.hit

    pry(main)> cruiser.sunk?
    #=> true -->

  Cell:
  A Cell object is a single cell on our board. A Cell can either contain a Ship or nothing.

    <!-- pry(main)> require './lib/ship'
    # => true

    pry(main)> require './lib/cell'
    # => true

    pry(main)> cell = Cell.new("B4")
    # => #<Cell:0x00007f84f0ad4720...>

    pry(main)> cell.coordinate
    # => "B4"

    pry(main)> cell.ship
    # => nil

    pry(main)> cell.empty?
    # => true

    pry(main)> cruiser = Ship.new("Cruiser", 3)
    # => #<Ship:0x00007f84f0891238...>

    pry(main)> cell.place_ship(cruiser)

    pry(main)> cell.ship
    # => #<Ship:0x00007f84f0891238...>

    pry(main)> cell.empty?
    # => false -->

  Additionally, a cell knows when it has been fired upon. When it is fired upon, the cell’s ship should be damaged if it has one:

    <!-- pry(main)> require './lib/ship'
    # => true

    pry(main)> require './lib/cell'
    # => true

    pry(main)> cell = Cell.new("B4")
    # => #<Cell:0x00007f84f0ad4720...>

    pry(main)> cruiser = Ship.new("Cruiser", 3)
    # => #<Ship:0x00007f84f0891238...>

    pry(main)> cell.place_ship(cruiser)

    pry(main)> cell.fired_upon?
    # => false

    pry(main)> cell.fire_upon

    pry(main)> cell.ship.health
    # => 2

    pry(main)> cell.fired_upon?
    # => true -->

Finally, a Cell will have a method called render which returns a String representation of the Cell for when we need to print the board. A cell can potentially be rendered as:

  + ”.” if the cell has not been fired upon.
  + “M” if the cell has been fired upon and it does not contain a ship (the shot was a miss).
  + “H” if the cell has been fired upon and it contains a ship (the shot was a hit).
  + “X” if the cell has been fired upon and its ship has been sunk.

Additionally, we will include an optional boolean argument to indicate if we want to reveal a ship in the cell even if it has not been fired upon. This should render a cell that has not been fired upon and contains a ship as an “S”. This will be useful for showing the user where they placed their ships and for debugging.

    <!-- pry(main)> cell_1 = Cell.new("B4")
    # => #<Cell:0x00007f84f11df920...>

    pry(main)> cell_1.render
    # => "."

    pry(main)> cell_1.fire_upon

    pry(main)> cell_1.render
    # => "M"

    pry(main)> cell_2 = Cell.new("C3")
    # => #<Cell:0x00007f84f0b29d10...>

    pry(main)> cruiser = Ship.new("Cruiser", 3)
    # => #<Ship:0x00007f84f0ad4fb8...>

    pry(main)> cell_2.place_ship(cruiser)

    pry(main)> cell_2.render
    # => "."

    # Indicate that we want to show a ship with the optional argument
    pry(main)> cell_2.render(true)
    # => "S"

    pry(main)> cell_2.fire_upon

    pry(main)> cell_2.render
    # => "H"

    pry(main)> cruiser.sunk?
    # => false

    pry(main)> cruiser.hit

    pry(main)> cruiser.hit

    pry(main)> cruiser.sunk?
    # => true

    pry(main)> cell_2.render
    # => "X" -->
  -
  -
  -



- Submission
- Evaluation Rubric
