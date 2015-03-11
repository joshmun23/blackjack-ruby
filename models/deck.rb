class Deck
  def initialize
    @collection = []
    SUITS.each do |suit|
      VALUES.each do |value|
        @collection << PlayingCard.new(value, suit)
      end
    end

    @collection.shuffle!
  end

  def collection
    @collection
  end

  def draw!
    @collection.pop
  end
end

SUITS  = ["♤", "♧", "♡", "♢"]
VALUES = ["2", "3", "4", "5", "6", "7", "8", "9", "J", "Q", "K", "A"]

