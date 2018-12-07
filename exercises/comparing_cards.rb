require 'pry'

class Card
  RANK = (2..10).to_a + %w(Jack Queen King Ace)
  
  include Comparable
  
  attr_reader :rank, :suit

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end
  
  def <=>(other_card)
    RANK.index(rank) <=> RANK.index(other_card.rank)    
  end
end

class Deck
  attr_reader :cards
  
  RANKS = ((2..10).to_a + %w(Jack Queen King Ace)).freeze
  SUITS = %w(Hearts Clubs Diamonds Spades).freeze
  
  def initialize
    @cards = []
    RANKS.each do |rank|
      SUITS.each do |suit|
        @cards << Card.new(rank, suit)
      end
    end
    @cards.shuffle!
  end
  
  def reshuffle
    RANKS.each do |rank|
        SUITS.each do |suit|
          cards << Card.new(rank, suit)
      end
    end
    cards.shuffle!
  end
  
  def draw
    if cards.empty?
      reshuffle
    end
    cards.pop
  end
  
end

deck = Deck.new
drawn = []
# binding.pry
52.times { drawn << deck.draw }

puts drawn.count { |card| card.rank == 5 } == 4
puts drawn.count { |card| card.suit == 'Hearts' } == 13

drawn2 = []
52.times { drawn2 << deck.draw }
puts drawn != drawn2