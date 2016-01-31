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
  attr_reader :players, :deck

  def initialize
    @players = []
    @players << Player.new(:dealer)
    @players << Player.new(:user)
    @deck = Deck.new
  end

end

class Player
  attr_reader :hand

  def initialize(role)

    @dealer = true if role == :dealer
    @dealer = false if role == :user

    @hand = Hand.new
  end

  def dealer?
    @dealer
  end

  def user?
    !@dealer
  end

end

require 'test/unit'

class CardTest < Test::Unit::TestCase
  def setup
    @card = Card.new(:hearts, :ten, 10)
  end

  def test_card_suite_is_correct
    assert_equal @card.suite, :hearts
  end

  def test_card_name_is_correct
    assert_equal @card.name, :ten
  end
  def test_card_value_is_correct
    assert_equal @card.value, 10
  end
end

class DeckTest < Test::Unit::TestCase
  def setup
    @deck = Deck.new
  end

  def test_new_deck_has_52_playable_cards
    assert_equal @deck.playable_cards.size, 52
  end

  def test_dealt_card_should_not_be_included_in_playable_cards
    card = @deck.deal_card
    assert(!@deck.playable_cards.include?(card))
  end

  def test_shuffled_deck_has_52_playable_cards
    @deck.shuffle
    assert_equal @deck.playable_cards.size, 52
  end
end

class GameTest < Test::Unit::TestCase
  def setup
    @game = Game.new
  end

  def test_game_should_have_a_dealer
    assert(@game.players.any? { |p| p.dealer? })
  end

  def test_game_should_have_a_user
    assert(@game.players.any? { |p| p.user? })
  end

  def test_game_should_have_a_deck
    assert(@game.deck)
  end

  def test_game_deck_shuould_be_a_deck
    assert_equal Deck, @game.deck.class
  end

end

class PlayerTest < Test::Unit::TestCase
  def setup
    @dealer = Player.new(:dealer)
    @user = Player.new(:user)
  end

  def test_dealer_should_have_a_hand
    assert_equal @dealer.hand.class, Hand
  end

  def test_user_shuld_have_a_hand
    assert_equal @user.hand.class, Hand
  end

  def test_hit_should_add_a_card_to_players_hand
    @user.hit
    assert(@user.hand.cards.first)
  end

end

class HandTest < Test::Unit::TestCase
  def setup
    @hand = Hand.new
  end

  def test_hand_has_score
    assert(@hand.score)
  end

  def test_score_with_two_aces
    @hand.cards << Card.new(:spades, :ace, [11, 1])
    @hand.cards << Card.new(:hearts, :ace, [11, 1])
    assert_equal 12, @hand.score
  end

  def test_score_with_queen_and_king
    @hand.cards << Card.new(:spades, :king, 10)
    @hand.cards << Card.new(:spades, :queen, 10)
    assert_equal 20, @hand.score
  end

  def test_score_with_king_queen_and_ace
    @hand.cards << Card.new(:spades, :king, 10)
    @hand.cards << Card.new(:spades, :queen, 10)
    @hand.cards << Card.new(:hearts, :ace, [11, 1])
    assert_equal 21, @hand.score
  end

  def test_score_with_a_bunch_of_cards
    @hand.cards << Card.new(:spades, :two, 2)
    @hand.cards << Card.new(:diamonds, :five, 5)
    @hand.cards << Card.new(:hearts, :eight, 8)
    @hand.cards << Card.new(:spades, :ace, [11, 1])
    assert_equal 16, @hand.score
  end

  def test_score_with_a_bunch_more_cards
    @hand.cards << Card.new(:spades, :two, 2)
    @hand.cards << Card.new(:diamonds, :five, 5)
    @hand.cards << Card.new(:hearts, :eight, 8)
    @hand.cards << Card.new(:spades, :ace, [11, 1])
    @hand.cards << Card.new(:spades, :king, 10)
    assert_equal 26, @hand.score
  end

end
