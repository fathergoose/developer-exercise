require_relative 'blackjack.rb'

puts "Welcome to the casino"
puts "Press enter to begin game"
gets

@game = Game.new
@game.deal_cards

puts "Your hand"
puts @game.players[1].hand.cards
puts "The dealer's hand"
puts @game.players[0].hand.cards.first+" <hidden-card>"

if @game.players[1].hand.score == 21
  puts "Blackjack! You win!"
  puts "Enter to exit"
  gets
  exit
elsif @game.players[0].hand.score == 21
  puts "Dealer wins with am opening blackjack"
  puts "Enter to exit"
  gets
  exit
end

@game.players[@game.turn].take_trun while @game.winner == :none
