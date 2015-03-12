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
    @player_score = 0
    @dealer_score = 0

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

    player_move
    dealer_move
  end

  def player_move
    player_score
    if @player_score < 21
      puts "Hit or Stand? (h/s)"
      response = gets.chomp.downcase
      @player_hand << @deck.draw! if response == 'h'
    elsif @player_score >= 21
      game_over
    end

    player_move unless (response == 's') || @player_score == 21
  end

  def dealer_move
    dealer_score

    if @dealer_score.between?(17, 21)
      game_over
    else
      @dealer_hand << @deck.draw!
      dealer_move
    end
  end

  def player_score
    @player_score = score_checker(@player_score, @player_hand)
    puts "Player score is: #{@player_score}"
  end

  def dealer_score
    @dealer_score = score_checker(@dealer_score, @dealer_hand)
    puts "Dealer score is: #{@dealer_score}"
  end

  def score_checker(user_score, user_hand)
    # binding.pry
    scores = user_hand.inject([]) do |arr, card|
      if card.face_card?
        card = 10
      elsif card.ace_card?
        card = 11 if user_score < 10
        card = 1 if user_score > 10
      else
        card = card.rank.to_i
      end
      arr << card
    end
    scores.reduce(:+)
  end

  def game_over
    if @player_score > 21 || @dealer_score > 21
      return puts "Player Loses!" if @player_score > 21
      return puts "Player Wins!" if @dealer_score > 21
    elsif @player_score == @dealer_score
      return puts "Tie!"
    elsif @player_score > @dealer_score
      return puts "Player Wins!"
    else
      return puts "Dealer Wins!"
    end
    # puts "New Game? (y/n)"
    # response = gets.chomp
    # Deck.new if response == "y"
  end
end
