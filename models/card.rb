class PlayingCard
  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def suit
    @suit
  end

  def rank
    @rank
  end

  def face_card?
    ["J", "Q", "K"].include?(@rank)
  end

  def ace_card?
    @rank == "A"
  end
end
