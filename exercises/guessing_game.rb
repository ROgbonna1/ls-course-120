class Player
  attr_reader :name
  attr_accessor :choice
  
  def initialize(name = "You")
    @name = name
    @choice = nil
  end
  
  def to_s
    name
  end
end

class Game
  RANGE_LOW = 1
  RANGE_HIGH = 100
  
  attr_reader :player, :number
  
  def initialize
    @player = Player.new
    @range = (select_low..select_high)
    @number = @range.to_a.sample
    @guesses = Math.log2(@range.max - @range.min).to_i + 1
  end
  
  def play
    loop do
      display_remaining_guesses
      choose_number
      evaluate_number
      break if player.choice == number || guesses == 0
    end
    puts "You win! The number is #{number}!" if player.choice == number
    puts "You lose! The number was #{number}!" if guesses == 0
  end
  
  protected
  attr_accessor :guesses
  
  def select_low
    low = nil
    
    loop do
      puts "What is the low end of our guessing range?"
      low = gets.chomp
      break if low.to_i.to_s == low
      puts "Invalid. Please choose an integer."
    end
    low = low.to_i
  end
  
  def select_high
    high = nil
    
    loop do
      puts "What is the high end of our guessing range?"
      high = gets.chomp
      break if high.to_i.to_s == high
      puts "Invalid. Please choose an integer."
    end
    high = high.to_i
  end
  
  def display_remaining_guesses
    puts "You have #{guesses} guesses remaining."
  end
  
  def choose_number
    loop do
      puts "Enter a number from 1 to 100."
      player.choice = gets.chomp
      break if player.choice.to_i.to_s == player.choice
      puts "Invalid guess. Enter a number from 1 and 100."
    end
    player.choice = player.choice.to_i
    self.guesses -= 1
  end
  
  def evaluate_number
    puts "Your choice is too low!" if player.choice < number
    puts "Your choice is too high!" if player.choice > number
  end
end

Game.new.play