require 'test/unit'
require_relative 'blackjack.rb'

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
    @user = @game.players[1]
    @dealer = @game.players[0]
  end

  def test_game_should_have_a_dealer
    assert(@game.players.any? { |p| p.is_dealer? })
  end

  def test_game_should_have_a_user
    assert(@game.players.any? { |p| p.is_user? })
  end

  def test_game_should_have_a_deck
    assert(@game.deck)
  end

  def test_game_deck_shuould_be_a_deck
    assert_equal Deck, @game.deck.class
  end

  def test_game_can_deal_cards
    @game.deal_cards
  end

  def test_deal_cards_gives_two_cards_to_each_player
    @game.deal_cards
    @game.players.each do |player|
      assert_equal 2, player.hand.cards.count # use count for readablity
    end
  end

  def test_game_turn_starts_at_one
    assert_equal 1, @game.turn
  end

  def test_game_next_turn_increments_turn
    assert_equal 0, @game.next_turn!
  end

  def test_game_should_have_no_winner_at_first
    assert_equal :none, @game.winner
  end

  def test_determine_winner_should_the_player_who_wins_as_winner
    @user.hand.cards << Card.new(:spades, :two, 2)
    @user.hand.cards << Card.new(:diamonds, :five, 5)
    @user.hand.cards << Card.new(:hearts, :eight, 8)
    @user.hand.cards << Card.new(:spades, :ace, [11, 1])
    @dealer.hand.cards << Card.new(:spades, :king, 10)
    @dealer.hand.cards << Card.new(:spades, :queen, 10)
    @dealer.hand.cards << Card.new(:hearts, :ace, [11, 1])
    @game.determine_winner
    assert_equal @dealer, @game.winner
  end

end

class PlayerTest < Test::Unit::TestCase
  def setup
    @dealer = Game.new.players[0]
    @user = @dealer.game.players[1]
  end

  def test_dealer_should_have_a_hand
    assert_equal @dealer.hand.class, Hand
  end

  def test_user_shuld_have_a_hand
    assert_equal @user.hand.class, Hand
  end

  def test_player_who_is_user_can_take_turn
  ##  assert(@user.take_turn) not sure how I am supposed to test this one.
  ## I guess the user tests it (wrong answer)
  end

  def test_player_who_is_dealer_can_take_turn
    @dealer.take_turn
  end

  def test_other_user_should_return_with_whom_you_are_playing
    assert_equal @user.other_player, @dealer
  end

  def test_dealer_should_hit_under_17
    @dealer.hand.cards << Card.new(:spades, :two, 2)
    @dealer.hand.cards << Card.new(:diamonds, :five, 5)
    @dealer.hand.cards << Card.new(:hearts, :eight, 8)
    @dealer.hand.cards << Card.new(:spades, :ace, [11, 1])
    assert_equal 'hit', @dealer.dealer_logic
  end

  def test_dealer_should_stay_at_17
    @dealer.hand.cards << Card.new(:spades, :two, 2)
    @dealer.hand.cards << Card.new(:diamonds, :five, 5)
    @dealer.hand.cards << Card.new(:hearts, :eight, 8)
    @dealer.hand.cards << Card.new(:spades, :ace, [11, 1])
    @dealer.hand.cards << Card.new(:diamonds, :ace, [11, 1])
    assert_equal 'stay', @dealer.dealer_logic
  end

  def test_dealer_should_stay_over_17
    @dealer.hand.cards << Card.new(:spades, :king, 10)
    @dealer.hand.cards << Card.new(:spades, :queen, 10)
    assert_equal 'stay', @dealer.dealer_logic
  end

  def test_hit_should_add_a_card_to_players_hand
    @user.hit!
    assert(@user.hand.cards.first)
  end

  def test_stay_should_not_change_a_players_score
    before_stay = @user.hand.score
    @user.stay!
    assert_equal before_stay, @user.hand.score
  end

  def test_stay_should_set_staying_to_true
    @user.stay!
    assert(@user.staying)
  end

  def test_check_win_or_bust
    @user.check_win_or_bust
  end

  def test_check_win_or_bust_sets_dealer_as_winner_when_score_is_over_21
    @user.hand.cards << Card.new(:spades, :two, 2)
    @user.hand.cards << Card.new(:diamonds, :five, 5)
    @user.hand.cards << Card.new(:hearts, :eight, 8)
    @user.hand.cards << Card.new(:spades, :ace, [11, 1])
    @user.hand.cards << Card.new(:spades, :king, 10)
    @user.check_win_or_bust
    assert_equal @dealer, @user.game.winner
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

  def test_score_with_ace_and_king
    @hand.cards << Card.new(:spades, :ace, [11, 1])
    @hand.cards << Card.new(:clubs, :king, 10)
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
