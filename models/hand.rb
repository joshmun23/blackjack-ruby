class Hand
  attr_reader :player_hand, :dealer_hand
  def initialize
    @player_hand = []
    @dealer_hand = []
    @deck = Deck.new
    @player_score = 0
    @dealer_score = 0
  end

  def new_game
    2.times do
      @player_hand << @deck.draw!
      @dealer_hand << @deck.draw!
    end
  end

  def current_round
    @player_hand.each do |hand|
      puts "Player was dealt: #{hand.rank + hand.suit}"
    end

    @dealer_hand.each do |hand|
      puts "Dealer was dealt: #{hand.rank + hand.suit} "
    end

    puts "Player score is: #{player_score}"
    puts "Dealer score is: #{dealer_score}"


    if @player_score < 21
      puts "Hit or Stand? (h/s)"
      response = gets.chomp.downcase
    end

    if response == 'h'
      @player_hand << @deck.draw!
    else
      until @dealer_score.between?(17, 27)
        @dealer_hand << @deck.draw!
        dealer_score
      end

      game_over
    end

    current_round
  end

  def player_score
    @player_hand.each do |hand|
      if hand.face_card?
        @player_score += 10
      elsif hand.ace_card?
        if @player_score > 10
          @player_score += 1
        else
          @player_score += 11
        end
      else
      @player_score += hand.rank.to_i
      end
    end

    @player_score
  end

  def dealer_score
    @dealer_hand.each do |hand|
      if hand.face_card?
        @dealer_score += 10
      elsif hand.ace_card?
        if @dealer_score > 10
          @dealer_score += 1
        else
          @dealer_score += 11
        end
      else
        @dealer_score += hand.rank.to_i
      end
    end

    @dealer_score
  end

  def game_over

    if @player_score > 21 || @dealer_score > 21
      puts "Player Loses!" if @player_score > 21
      puts "Player Wins!" if @dealer_score > 21
    elsif @player_score == @dealer_score
      puts "Tie!"
    elsif @player_score > @dealer_score
      puts "Player Wins!"
    else
      puts "Dealer Wins!"
    end

    puts "New Game? (y/n)"
    response = gets.chomp
    new_game if response == "y"
  end
end
