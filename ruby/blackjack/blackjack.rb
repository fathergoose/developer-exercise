class Card
  attr_accessor :suite, :name, :value

  def initialize(suite, name, value)
    @suite, @name, @value = suite, name, value
  end
end

class Deck
  attr_accessor :playable_cards
  SUITES = [:hearts, :diamonds, :spades, :clubs]
  NAME_VALUES = {
    :two   => 2,
    :three => 3,
    :four  => 4,
    :five  => 5,
    :six   => 6,
    :seven => 7,
    :eight => 8,
    :nine  => 9,
    :ten   => 10,
    :jack  => 10,
    :queen => 10,
    :king  => 10,
    :ace   => [11, 1]}

  def initialize
    shuffle
  end

  def deal_card
    random = rand(@playable_cards.size)
    p random
    @playable_cards.delete_at(random)
  end

  def shuffle
    @playable_cards = []
    SUITES.each do |suite|
      NAME_VALUES.each do |name, value|
        @playable_cards << Card.new(suite, name, value)
      end
    end
  end
end

class Hand
  attr_accessor :cards

  def initialize
    @cards = []
  end

  def score
    score = self.score_without_aces
    @cards.each do |card|
      if card.name == :ace
        if score >= 10
          score = score + 1
        else
          score = score + 11
        end
      end
    end
    score
  end


  def score_without_aces
    score = 0
    @cards.each do |card|
      score += card.value unless card.name == :ace
    end
    score
  end

end

class Game
  attr_accessor :winner
  attr_reader :players, :deck, :turn

  def initialize
    @players = []
    @players << Player.new(:dealer, self) # players[0]
    @players << Player.new(:user, self) # players[1]
    @deck = Deck.new
    @winner = :none
    @turn = 1
  end

  def deal_cards
    2.times do # Weird code, but thats how blackjack works
      @players.each do |player| # Although dealer should get cards last
        player.hand.cards << @deck.deal_card
      end
    end
  end

  def next_turn!
    if @turn < 1 - @players.length
      @turn += 1
    else
      @turn = 0
    end
  end

end

class Player
  attr_reader :hand, :game, :staying

  def initialize(role, game)
    @dealer = true if role == :dealer
    @dealer = false if role == :user
    @hand = Hand.new
    @game = game
  end

  def is_dealer?
    @dealer
  end

  def is_user?
    not @dealer
  end

  def take_turn
    dealer_logic if self.is_dealer?
    user_logic if self.is_user?
  end

  def hit!
    @hand.cards << @game.deck.deal_card
    check_win_or_bust
    @game.next_turn!
  end

  def stay!
    @game.next_turn!
    @staying = true
  end

  def dealer_logic
    if @hand.score < 17
      hit!
      'hit'
    else
      stay!
      'stay'
    end
  end

  def check_win_or_bust
    if @hand.score > 21
      @game.next_turn!
      @game.winner = @game.players[@game.turn]
    end # elsif is hard to read
    if @hand.score == 21
      @game.winner = @game.players[@game.turn]
    end
  end

  private

  def user_logic
    unless @staying
      puts "Will you hit(j) or stay(k)"
      player_action = gets.chomp
      hit! if player_action == 'j'
      stay! if player_action == 'k'
    end
  end

end
