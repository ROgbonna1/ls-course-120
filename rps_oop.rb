class Move
  attr_accessor :value

  VALUES = ['rock', 'paper', 'scissors']

  def initialize(value)
    @value = value
  end

  def >(other_move)
    value == 'rock' && other_move.value == "scissors" ||
      value == 'paper' && other_move.value == "rock" ||
      value == 'scissors' && other_move.value == "paper"
  end

  def <(other_move)
    true unless value > other_move || value == other_move.value
  end

  def to_s
    value
  end
end

class Player
  attr_accessor :move, :name, :score

  def initialize
    set_name
    @score = 0
  end
end

class Human < Player
  def set_name
    name = ''
    loop do
      puts "What's your name?"
      name = gets.chomp
      break unless name.empty?
      puts "Sorry. Must enter a name."
    end
    self.name = name
  end

  def choose
    choice = nil
    loop do
      puts "Select: 'rock', 'paper', or 'scissors"
      choice = gets.chomp
      break if Move::VALUES.include? choice
      puts "Sorry, invalid choice."
    end
    self.move = Move.new(choice)
  end
end

class Computer < Player
  def set_name
    self.name = ['Hal', 'Adam', 'Satoshi', 'Nick', 'Wei'].sample
  end

  def choose
    self.move = Move.new(Move::VALUES.sample)
  end
end

class RPSGame
  attr_accessor :human, :computer

  def initialize
    @human = Human.new
    @computer = Computer.new
  end

  def display_welcome_message
    puts "Welcome to RPS!"
  end

  def display_goodbye_message
    puts "Thank you! Play again!"
  end

  def display_choices
    puts "#{human.name} chose #{human.move}!"
    puts "#{computer.name} chose #{computer.move}!"
  end

  def check_tie
    puts "It's a tie!" if human.move.value == computer.move.value
  end

  def display_winner
    puts "#{human.name} won!" if human.move > computer.move
    puts "#{computer.name} won!" if computer.move > human.move
  end
  
  def update_score
    human.score += 1 if human.move > computer.move
    computer.score += 1 if computer.move > human.move
  end
  
  def display_score
    puts "#{human.name}'s score is: #{human.score}"
    puts "#{computer.name}'s score is: #{computer.score}"
  end

  def play_again?
    answer = ''

    loop do
      puts "Do you want to play again? ('y' or 'n')"
      answer = gets.chomp
      break if ['y', 'n'].include? answer
      puts 'Invalid input. Try again.'
    end
    answer == 'y' ? true : false
  end

  def play
    loop do
      display_welcome_message
      human.choose
      computer.choose
      display_choices
      check_tie
      display_winner
      update_score
      display_score
      break unless play_again?
    end
    display_goodbye_message
  end
end

RPSGame.new.play
