class Board
  WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                [[1, 4, 7], [2, 5, 8], [3, 6, 9]] +   # columns
                [[1, 5, 9], [3, 5, 7]]                # diagonals
  def initialize
    @squares = {} 
    (1..9).each { |key| @squares[key] = Square.new }
  end
  
  def get_square_at(key)
    @squares[key]
  end
  
  def set_square_at(key, marker)
    @squares[key].marker = marker
  end
  
  def unmarked_keys
    @squares.keys.select { |key| @squares[key].unmarked? }
  end
  
  def full?
    unmarked_keys.empty?
  end
  
  def reset
    (1..9).each { |key| @squares[key] = Square.new }
  end
    
  def someone_won?
    !!detect_winner
  end

  
  def detect_winner # returns winning marker or nil
    winning_lines = WINNING_LINES.map do |line|
      @squares.values_at(*line)
    end
    winner = winning_lines.find do |line|
      line.all? { |square| square.marker == TTTGame::HUMAN_MARKER } || 
      line.all? { |square| square.marker == TTTGame::COMPUTER_MARKER }
    end
    winner.nil? ? nil : winner.first.marker
  end
end

class Square
  INITIAL_MARKER = " "
  
  attr_accessor :marker
  
  def initialize(marker = INITIAL_MARKER)
    @marker = marker
    # maybe a "status" to keep track of this square's mark?
  end
  
  def unmarked?
    marker == INITIAL_MARKER
  end
  
  def to_s
    @marker
  end
end

class Player
  attr_reader :marker
  
  def initialize(marker)
    @marker = marker
  end
end

class TTTGame
  HUMAN_MARKER = "X"
  COMPUTER_MARKER = "0"
  attr_reader :board, :human, :computer
  
  def initialize
    @board = Board.new
    @human = Player.new(HUMAN_MARKER)
    @computer = Player.new(COMPUTER_MARKER)
  end
  def display_welcome_message
    puts "Welcome to Tic Tac Toe!"
    puts ""
  end
  
  def display_goodbye_message
    puts "Thanks for playing Tic Tac Toe! Goodbye!"
  end
  
  def display_board(clear = true)
    system 'clear' if clear
    puts "You're a #{human.marker}. Computer is a #{computer.marker}."
    puts <<-HEREDOC
         |     |     
      #{board.get_square_at(1)}  |  #{board.get_square_at(2)}  |  #{board.get_square_at(3)}  
         |     |
    -----+-----+-----
         |     |
      #{board.get_square_at(4)}  |  #{board.get_square_at(5)}  |  #{board.get_square_at(6)}
         |     |
    -----+-----+-----
         |     |
      #{board.get_square_at(7)}  |  #{board.get_square_at(8)}  |  #{board.get_square_at(9)}
         |     |
    HEREDOC
  end
  
  def display_result
    display_board
    case board.detect_winner
    when human.marker
      puts "You won!"
    when computer.marker
      puts "Computer won!"
    else
      puts "It's a tie!"
    end
  end
  
  def human_moves
    puts "Choose one of the following squares: #{board.unmarked_keys.join(", ")}: "
    square = nil
    loop do
      square = gets.chomp.to_i
      break if board.unmarked_keys.include?(square)
      puts "Sorry, that's not a valid choice."
    end
    board.set_square_at(square, human.marker)
  end
  
  def computer_moves
    board.set_square_at(board.unmarked_keys.sample, computer.marker)
  end
  
  def play_again?
    answer = nil
    loop do
      puts "Do you want to play again? (y, n)"
      answer = gets.chomp.downcase
      break if ['y', 'n'].include? answer
      puts "Sorry must be 'y' or 'n'."
    end
    
    answer == 'y'
  end
  
  def play
    display_welcome_message
    loop do
      display_board(false)
      
      loop do
        human_moves
        break if board.full? || board.someone_won?
        computer_moves
        break if board.full? || board.someone_won?
        display_board
      end
      
      display_result
      break unless play_again?
      system 'clear'
      puts "Let's play again!"
      board.reset
    end

    display_goodbye_message
  end
end

# we'll kick off the game like this
game = TTTGame.new
game.play